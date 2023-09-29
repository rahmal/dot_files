from powerline_shell.themes.default import DefaultColor


class Color(DefaultColor):
    """Basic theme which only uses colors in 0-15 range"""
    TIME_FG = 14#254
    TIME_BG = 0 #166 #31

    USERNAME_FG = 0 #250
    USERNAME_BG = 14 #161
    USERNAME_ROOT_BG = 124

    HOSTNAME_FG = 250
    HOSTNAME_BG = 238

    HOME_SPECIAL_DISPLAY = True
    HOME_BG = 31  # blueish
    HOME_FG = 15  # white
    PATH_BG = 4 #237  # dark grey
    PATH_FG = 15 #250  # light grey
    CWD_FG = 254  # nearly-white grey
    SEPARATOR_FG = 244

    READONLY_BG = 1
    READONLY_FG = 15

    REPO_CLEAN_BG = 2   # green
    REPO_CLEAN_FG = 0   # black
    REPO_DIRTY_BG = 1   # red
    REPO_DIRTY_FG = 15  # white
