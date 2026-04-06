# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::rust::deps()
#
#>
######################################################################
p6df::modules::rust::deps() {
  ModuleDeps=(
    p6m7g8-dotfiles/p6common
    MenkeTechnologies/zsh-cargo-completion
    p6m7g8/rustenv
  )
}

######################################################################
#<
#
# Function: p6df::modules::rust::env::init(_module, _dir)
#
#  Args:
#	_module -
#	_dir -
#
#  Environment:	 CARGO_HOME P6_DFZ_LANGS_DISABLE P6_DFZ_SRC_DIR RUSTENV_ROOT RUSTUP_HOME
#>
######################################################################
p6df::modules::rust::env::init() {

  local _module="$1"
  local _dir="$2"
  if p6_string_blank_NOT "$P6_DFZ_LANGS_DISABLE"; then
    p6_env_export RUSTENV_ROOT "$P6_DFZ_SRC_DIR/p6m7g8/rustenv"
    p6_env_export RUSTUP_HOME "$RUSTENV_ROOT/.rustup"
    p6_env_export CARGO_HOME "$RUSTENV_ROOT/.cargo"
    p6_path_if "$CARGO_HOME/bin"
  fi

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::rust::aliases::init(_module, _dir)
#
#  Args:
#	_module -
#	_dir -
#
#>
######################################################################
p6df::modules::rust::aliases::init() {

  local _module="$1"
  local _dir="$2"
  # override co=cargo from MenkeTechnologies/zsh-cargo-completion; free co for codex
  p6_alias "ca" "cargo"
  unalias co 2>/dev/null || true

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::rust::langmgr::init()
#
#  Environment:	 P6_DFZ_SRC_DIR
#>
######################################################################
p6df::modules::rust::langmgr::init() {

  p6df::core::lang::mgr::init "$P6_DFZ_SRC_DIR/p6m7g8/rustenv" "rust"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::rust::external::brews()
#
#>
######################################################################
p6df::modules::rust::external::brews() {

  p6df::core::homebrew::cli::brew::install rustc-completion
  p6df::core::homebrew::cli::brew::install rustup

  p6df::core::homebrew::cli::brew::install rustscan
  p6df::core::homebrew::cli::brew::install rust-analyzer

  p6df::core::homebrew::cli::brew::install zig

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::rust::langs()
#
#>
######################################################################
p6df::modules::rust::langs() {

  rustup-init -v --profile complete --no-modify-path -y

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::rust::vscodes()
#
#>
######################################################################
p6df::modules::rust::vscodes() {

  p6df::modules::vscode::extension::install rust-lang.rust-analyzer

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::rust::vscodes::config()
#
#>
######################################################################
p6df::modules::rust::vscodes::config() {

  cat <<'EOF'
  "[rust]": {
    "editor.defaultFormatter": "rust-lang.rust-analyzer"
  },
  "rust-analyzer.check.overrideCommand": [
    "cargo",
    "clippy",
    "--fix",
    "--workspace",
    "--message-format=json",
    "--all-targets",
    "--allow-dirty",
    "--allow-staged"
  ],
  "rust-analyzer.procMacro.enable": true
EOF

  p6_return_void
}

######################################################################
#<
#
# Function: str str = p6df::modules::rust::prompt::lang()
#
#  Returns:
#	str - str
#
#>
######################################################################
p6df::modules::rust::prompt::lang() {

  local str
  str=$(p6df::core::lang::prompt::lang \
    "rs" \
    "rustenv version-name 2>/dev/null | p6_filter_extract_before '-'" \
    "rustc --version 2>/dev/null | p6_filter_column_pluck 2")

  p6_return_str "$str"
}

######################################################################
#<
#
# Function: words rust = p6df::modules::rust::prompt::env()
#
#  Returns:
#	words - rust
#
#  Environment:	 CARGO_HOME
#>
######################################################################
p6df::modules::rust::prompt::env() {

  p6_return_words 'rust' '$CARGO_HOME'
}
