# shellcheck shell=bash

CRATES_FILE="${ASDF_CRATE_DEFAULT_PACKAGES_FILE:=$HOME}/.default-cargo-crates"

install_default_cargo_crates() {

  if [[ ! -r $CRATES_FILE ]]; then
	echo "Crates file $CRATES_FILE not found"
	return;
  fi

  while read -r line; do
    name=$(echo "$line" |
      sed 's|\(.*\) //.*$|\1|' |  # handle comments after crate name
      sed -E 's|^[[:space:]]*//.*||') # handle full line comments

    [[ -z $name ]] && continue

    echo -ne "\nInstalling \033[33m${name}\033[39m cargo crate... "
    #shellcheck disable=SC2086
    PATH="$ASDF_INSTALL_PATH/bin:$PATH" cargo install $name > /dev/null && rc=$? || rc=$?
    if [[ $rc -eq 0 ]]; then
      echo -e "\033[32mSUCCESS\033[39m"
    else
      echo -e "\033[31mFAIL\033[39m"
    fi
  done < "$CRATES_FILE"
}
