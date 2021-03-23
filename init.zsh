######################################################################
#<
#
# Function: p6df::modules::go::deps()
#
#>
######################################################################
p6df::modules::go::deps() {
  ModuleDeps=(
    p6m7g8/p6common
  )
}

######################################################################
#<
#
# Function: p6df::modules::go::home::symlink()
#
#>
######################################################################
p6df::modules::rust::home::symlink() {

  if [ -n "$RUSTROOT" ]; then
    ln -fs $P6_DFZ_SRC_DIR $RUSTROOT/src
  fi
}

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

  rustup-init --options
}

######################################################################
#<
#
# Function: p6df::modules::rust::init()
#
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
#>
######################################################################
p6df::modules::rust::rustenv::init() {
  local dir="$1"

  [ -n "$DISABLE_ENVS" ] && return

  export RUSTENV_ROOT=$dir/chriskuehl/rustenv
  export RUSTUP_HOME=$RUSTENV_ROOT/.rustup
  export CARGO_HOME=$RUSTENV_ROOT/.cargo

  p6df::util::path::if "$CARGO_HOME/bin"
}

######################################################################
#<
#
# Function: p6df::modules::rust::rustenv::prompt::line()
#
#>
######################################################################
p6df::modules::rust::rustenv::prompt::line() {

  p6_rust_path_prompt_info
}

######################################################################
#<
#
# Function: p6df::modules::rust::prompt::line()
#
#>
######################################################################
p6df::modules::rust::prompt::line() {

  p6_rust_prompt_info
  p6_rust_path_prompt_info
}

######################################################################
#<
#
# Function: str str = p6_rust_path_prompt_info()
#
#  Returns:
#	str - str
#
#>
######################################################################
p6_rust_path_prompt_info() {

  local str="rust:\t"

  p6_return_str "$str"
}

######################################################################
#<
#
# Function: p6_rust_prompt_info()
#
#>
######################################################################
p6_rust_prompt_info() {

  echo -n "rust:\t  "
  p6_lang_version "rust"
}
