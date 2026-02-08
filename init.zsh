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
# Function: p6df::modules::rust::external::brew()
#
#>
######################################################################
p6df::modules::rust::external::brew() {

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
# Function: p6df::modules::rust::init(_module, dir)
#
#  Args:
#	_module -
#	dir -
#
#  Environment:	 P6_DFZ_SRC_DIR
#>
######################################################################
p6df::modules::rust::init() {
  local _module="$1"
  local dir="$2"

  p6_bootstrap "$dir"
  p6df::core::lang::mgr::init "$P6_DFZ_SRC_DIR/p6m7g8/rustenv" "rust"
  p6df::modules::rust::rustenv::init "$P6_DFZ_SRC_DIR"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::rust::rustenv::init(dir)
#
#  Args:
#	dir -
#
#  Environment:	 CARGO_HOME P6_DFZ_LANGS_DISABLE RUSTENV_ROOT RUSTUP_HOME
#>
######################################################################
p6df::modules::rust::rustenv::init() {
  local dir="$1"

  if p6_string_blank "$P6_DFZ_LANGS_DISABLE"; then
    p6_env_export RUSTENV_ROOT "$dir/p6m7g8/rustenv"
    p6_env_export RUSTUP_HOME "$RUSTENV_ROOT/.rustup"
    p6_env_export CARGO_HOME "$RUSTENV_ROOT/.cargo"
    p6_path_if "$CARGO_HOME/bin"
  fi

  p6_return_void
}

######################################################################
#<
#
# Function: str str = p6df::modules::rust::prompt::env()
#
#  Returns:
#	str - str
#
#  Environment:	 CARGO_HOME RUSTENV_ROOT RUSTUP_HOME
#>
######################################################################
p6df::modules::rust::prompt::env() {

  local str="rustenv_root:\t  $RUSTENV_ROOT
rustup_home:\t  $RUSTUP_HOME
cargo_home:\t  $CARGO_HOME"

  p6_return_str "$str"
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
