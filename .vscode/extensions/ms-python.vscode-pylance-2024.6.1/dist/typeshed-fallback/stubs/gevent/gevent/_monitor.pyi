from collections.abc import Callable, Sequence
from typing import Any, TypeVar

from gevent.events import IPeriodicMonitorThread, MemoryUsageThresholdExceeded, MemoryUsageUnderThreshold
from gevent.hub import Hub
from greenlet import greenlet

__all__ = ["PeriodicMonitoringThread"]

_T = TypeVar("_T")

# FIXME: While it would be nice to import Interface from zope.interface here so the
#        mypy plugin will work correctly for the people that use it, it causes all
#        sorts of issues to reference a module that is not stubbed in typeshed, so
#        for now we punt and just define an alias for Interface and implementer we
#        can get rid of later
def implementer(interface: Any, /) -> Callable[[_T], _T]: ...

class MonitorWarning(RuntimeWarning): ...

class _MonitorEntry:
    function: Callable[[Hub], object]
    period: float
    last_run_time: float
    def __init__(self, function: Callable[[Hub], object], period: float) -> None: ...
    def __eq__(self, other: object) -> bool: ...
    def __hash__(self) -> int: ...

@implementer(IPeriodicMonitorThread)
class PeriodicMonitoringThread:
    inactive_sleep_time: float
    min_sleep_time: float
    min_memory_monitor_period: float
    should_run: bool
    monitor_thread_ident: int
    pid: int
    def __init__(self, hub: Hub) -> None: ...
    @property
    def hub(self) -> Hub | None: ...
    def monitoring_functions(self) -> list[_MonitorEntry]: ...
    def add_monitoring_function(self, function: Callable[[Hub], object], period: float) -> None: ...
    def calculate_sleep_time(self) -> float: ...
    def kill(self) -> None: ...
    def __call__(self) -> None: ...
    def monitor_blocking(self, hub: Hub) -> tuple[greenlet, Sequence[str]]: ...
    def ignore_current_greenlet_blocking(self) -> None: ...
    def monitor_current_greenlet_blocking(self) -> None: ...
    def can_monitor_memory_usage(self) -> bool: ...
    def install_monitor_memory_usage(self) -> None: ...
    def monitor_memory_usage(self, _hub: Hub) -> MemoryUsageThresholdExceeded | MemoryUsageUnderThreshold | None: ...
