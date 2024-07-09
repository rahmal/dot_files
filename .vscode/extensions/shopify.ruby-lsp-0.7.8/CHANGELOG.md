# vscode-ruby-lsp-v0.7.8
## 🐛 Bug Fixes

- Upgrade esbuild to v0.23 (https://github.com/Shopify/ruby-lsp/pull/2261) by @vinistock



# vscode-ruby-lsp-v0.7.6
## ✨ Enhancements

- Add configuration options for third-party formatters (https://github.com/Shopify/ruby-lsp/pull/2092) by @andyw8
- Add run task command (https://github.com/Shopify/ruby-lsp/pull/2231) by @vinistock
- Add better initialization error handling (https://github.com/Shopify/ruby-lsp/pull/2241) by @vinistock

## 🐛 Bug Fixes

- Fix chruby release candidate ordering (https://github.com/Shopify/ruby-lsp/pull/2212) by @vinistock
- Push disposables to subscriptions (https://github.com/Shopify/ruby-lsp/pull/2254) by @vinistock
- Simplify class and module grammar for more consistency (https://github.com/Shopify/ruby-lsp/pull/2242) by @vinistock



# vscode-ruby-lsp-v0.7.5
## ✨ Enhancements

- Display addons status in the control panel (https://github.com/Shopify/ruby-lsp/pull/2180) by @st0012
- Use quickpick UI to display addons list (https://github.com/Shopify/ruby-lsp/pull/2205) by @st0012

## 🐛 Bug Fixes

- Display warning when launching with no workspaces (https://github.com/Shopify/ruby-lsp/pull/2155) by @vinistock
- Avoid overriding the start function of Client (https://github.com/Shopify/ruby-lsp/pull/2163) by @st0012



# vscode-ruby-lsp-v0.7.4
## ✨ Enhancements

- Add `case` statement to VS Code snippets (https://github.com/Shopify/ruby-lsp/pull/2129) by @SimonBrazell

## 🐛 Bug Fixes

- Continue searching if directory is missing for omitted chruby patch version (https://github.com/Shopify/ruby-lsp/pull/2143) by @vinistock
- Standardize version manager script execution (https://github.com/Shopify/ruby-lsp/pull/2133) by @vinistock
- Ensure update server gem command updates the locked server (https://github.com/Shopify/ruby-lsp/pull/2145) by @vinistock



# vscode-ruby-lsp-v0.7.2
## 🐛 Bug Fixes

- Ensure default gems are part of the document selector (https://github.com/Shopify/ruby-lsp/pull/2127) by @vinistock
- Handle unsaved files in main language server client (https://github.com/Shopify/ruby-lsp/pull/2124) by @vinistock



# vscode-ruby-lsp-v0.7.1
## 🐛 Bug Fixes

- Fix duplicate LSP features appearing in multiroot workspaces (https://github.com/Shopify/ruby-lsp/pull/2101) by @andyw8
- Search for asdf.fish when the shell is fish (https://github.com/Shopify/ruby-lsp/pull/2111) by @vinistock



# vscode-ruby-lsp-v0.7.0
## ✨ Enhancements

- Allow omitting patch in .ruby-version (https://github.com/Shopify/ruby-lsp/pull/2004) by @vinistock

## 🐛 Bug Fixes

- Fix false positive in gem list matching (https://github.com/Shopify/ruby-lsp/pull/2012) by @vinistock
- Improve client integration tests (https://github.com/Shopify/ruby-lsp/pull/2033) by @vinistock
- Set shell and env for ASDF activation (https://github.com/Shopify/ruby-lsp/pull/2006) by @vinistock

## 📦 Other Changes

- Mention that bundleGemfile is not intended for multiroot workspaces (https://github.com/Shopify/ruby-lsp/pull/2011) by @vinistock
- Set dependabot `open-pull-requests-limit` to 100 (https://github.com/Shopify/ruby-lsp/pull/2059) by @egiurleo



# vscode-ruby-lsp-v0.5.21
## ✨ Enhancements

- Add manual Ruby configuration (https://github.com/Shopify/ruby-lsp/pull/1967) by @vinistock
- Allow configuring extra chruby paths (https://github.com/Shopify/ruby-lsp/pull/1976) by @vinistock
- Log invalid JSON environment (https://github.com/Shopify/ruby-lsp/pull/2000) by @vinistock



# vscode-ruby-lsp-v0.5.20
## ✨ Enhancements

- Implement ASDF as a manager object (https://github.com/Shopify/ruby-lsp/pull/1845) by @vinistock

## 🐛 Bug Fixes

- Fix logging manager on activation failure (https://github.com/Shopify/ruby-lsp/pull/1952) by @Earlopain
- Avoid redirecting gem list output to stderr (https://github.com/Shopify/ruby-lsp/pull/1964) by @vinistock
- Avoid setting GEM_HOME and GEM_PATH for rbenv (https://github.com/Shopify/ruby-lsp/pull/1966) by @vinistock



# vscode-ruby-lsp-v0.5.19
## 🐛 Bug Fixes

- Fix the discovered version manager logging as `[object Object]` (https://github.com/Shopify/ruby-lsp/pull/1920) by @Earlopain
- Migrate manager config before activating (https://github.com/Shopify/ruby-lsp/pull/1923) by @vinistock



# vscode-ruby-lsp-v0.5.18
## ✨ Enhancements

- Implement None and Custom as version manager objects (https://github.com/Shopify/ruby-lsp/pull/1878) by @vinistock
- Allow configuring Mise executable path (https://github.com/Shopify/ruby-lsp/pull/1914) by @vinistock

## 🐛 Bug Fixes

- Enable `no-floating-promises` lint (https://github.com/Shopify/ruby-lsp/pull/1876) by @vinistock
- Remove verbose or debug environment variables from Ruby env (https://github.com/Shopify/ruby-lsp/pull/1889) by @vinistock
- [VSCode] Change the order of existence checks for Manager. Check 'asdf' last. (https://github.com/Shopify/ruby-lsp/pull/1909) by @dlwr

## 📦 Other Changes

- Enhance version manager config to accept more fields (https://github.com/Shopify/ruby-lsp/pull/1831) by @vinistock



# vscode-ruby-lsp-v0.5.17
## 🐛 Bug Fixes

- Use VS Code's file API to check for workspace permissions (https://github.com/Shopify/ruby-lsp/pull/1853) by @vinistock
- Use activated environment by RVM (https://github.com/Shopify/ruby-lsp/pull/1868) by @vinistock
- Add ubuntu RVM path to list of possible installations (https://github.com/Shopify/ruby-lsp/pull/1869) by @vinistock



# vscode-ruby-lsp-v0.5.16
## ✨ Enhancements

- Implement Windows activation as a manager object (https://github.com/Shopify/ruby-lsp/pull/1796) by @vinistock
- Implement Rbenv activation as a manager object (https://github.com/Shopify/ruby-lsp/pull/1811) by @vinistock
- Enable ruby language on more file types (https://github.com/Shopify/ruby-lsp/pull/1839) by @snutij
- Implement RVM as a manager object (https://github.com/Shopify/ruby-lsp/pull/1828) by @vinistock

## 🐛 Bug Fixes

- Remove path exists and use VS Code's file system (https://github.com/Shopify/ruby-lsp/pull/1650) by @vinistock
- Prepend vscode for relative image references (https://github.com/Shopify/ruby-lsp/pull/1601) by @vinistock
- Return early when building dependencies view if no client (https://github.com/Shopify/ruby-lsp/pull/1848) by @vinistock


