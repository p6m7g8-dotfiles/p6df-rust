# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::rust::rustup::inline()
#
#>
######################################################################
p6df::modules::rust::rustup::inline() {

  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}
