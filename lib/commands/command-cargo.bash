# shellcheck shell=bash

current_script_path=${BASH_SOURCE[0]}
plugin_dir=$(dirname "$(dirname "$current_script_path")")

# shellcheck source=../../lib/utils.bash
source "$plugin_dir/utils.bash"
rust_install_dir=$(asdf where rust)
export CARGO_HOME=$rust_install_dir/cargo

case "$1" in
	'install')
		install_default_cargo_crates
		;;
esac
