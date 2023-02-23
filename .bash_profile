#!/usr/bin/env bash

# shellcheck source=/dev/null
[ -r "${HOME}"/.bashrc ] && . "${HOME}"/.bashrc


export PATH="${HOME}/.poetry/bin:${PATH}"
export PATH="${HOME}/.kzenv/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"
. "$HOME/.cargo/env"

if [ -e /home/nicolas/.nix-profile/etc/profile.d/nix.sh ]; then . /home/nicolas/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
