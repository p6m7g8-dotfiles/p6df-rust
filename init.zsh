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

  # rust
  code --install-extension rust-lang.rust
}

######################################################################
#<
#
# Function: p6df::modules::rust::external::brew()
#
#>
######################################################################
p6df::modules::rust::external::brew() {

  brew install rustc-completion
  brew install rustup-init

  brew install rustscan
  brew install rust-analyzer
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
}

######################################################################
#<
#
# Function: p6df::modules::rust::init()
#
#  Environment:	 P6_DFZ_SRC_DIR
#>
######################################################################
p6df::modules::rust::init() {

  p6df::modules::rust::rustenv::init "$P6_DFZ_SRC_DIR"
}

######################################################################
#<
#
# Function: p6df::modules::rust::rustenv::init(dir)
#
#  Args:
#	dir -
#
#  Environment:	 CARGO_HOME DISABLE_ENVS RUSTENV_ROOT RUSTUP_HOME
#>
######################################################################
p6df::modules::rust::rustenv::init() {
  local dir="$1"

  [ -n "$DISABLE_ENVS" ] && return

  export RUSTENV_ROOT=$dir/chriskuehl/rustenv
  export RUSTUP_HOME=$RUSTENV_ROOT/.rustup
  export CARGO_HOME=$RUSTENV_ROOT/.cargo

  p6_path_if "$CARGO_HOME/bin"
}

######################################################################
#<
#
# Function: str str = p6_rust_env_prompt_info()
#
#  Returns:
#	str - str
#
#  Environment:	 CARGO_HOME RUSTENV_ROOT RUSTUP_HOME
#>
######################################################################
p6_rust_env_prompt_info() {

  local str="rustenv_root=$RUSTENV_ROOT
rustup_home=$RUSTUP_HOME
cargo_home=$CARGO_HOME"

  p6_return_str "$str"
}
