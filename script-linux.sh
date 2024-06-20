#!/usr/bin/env bash

function _EnvSetup {
  if [[ -d "${ASDF_DIR:-$HOME/.asdf}" ]]; then
    . "${ASDF_DIR:-$HOME/.asdf}"/asdf.sh
    if [[ -n $ASDF_DIR ]]; then
      . "${ASDF_DIR:-$HOME/.asdf}"/completions/asdf.bash
      for i in ${ENV_LIST[@]}; do
        asdf reshim "$i" >/dev/null 2>&1 || true
      done
    fi
  fi
}

DOTFILES_PATH="${HOME}"/.config/dotfiles
mkdir -p "${HOME}"/.config "${HOME}"/.local/bin "${HOME}"/.local/share "${HOME}"/tmp

git clone --depth=1 --single-branch --recurse-submodules --shallow-submodules --no-tags \
    https://github.com/mmguero/dotfiles.git "${DOTFILES_PATH}"
rm -rf "${DOTFILES_PATH}"/.git

[[ -r "$DOTFILES_PATH"/bash/rc ]] && rm -vf "$HOME"/.bashrc && \
  ln -vrs "$DOTFILES_PATH"/bash/rc "$HOME"/.bashrc

[[ -r "$DOTFILES_PATH"/bash/aliases ]] && rm -vf "$HOME"/.bash_aliases && \
  ln -vrs "$DOTFILES_PATH"/bash/aliases "$HOME"/.bash_aliases

[[ -r "$DOTFILES_PATH"/bash/functions ]] && rm -vf "$HOME"/.bash_functions && \
  ln -vrs "$DOTFILES_PATH"/bash/functions "$HOME"/.bash_functions

[[ -d "$DOTFILES_PATH"/bash/rc.d ]] && rm -vf "$HOME"/.bashrc.d && \
  ln -vrs "$DOTFILES_PATH"/bash/rc.d "$HOME"/.bashrc.d

[[ -r "$DOTFILES_PATH"/linux/tmux/tmux.conf ]] && rm -vf "$HOME"/.tmux.conf && \
  ln -vrs "$DOTFILES_PATH"/linux/tmux/tmux.conf "$HOME"/.tmux.conf

[[ -r "$DOTFILES_PATH"/bash/context-color/context-color ]] && rm -vf "$HOME"/.local/bin/context-color && \
  ln -vrs "$DOTFILES_PATH"/bash/context-color/context-color "$HOME"/.local/bin/context-color

[[ -r "$DOTFILES_PATH"/bash/development_setup.sh ]] && rm -vf "$HOME"/.local/bin/bash/development_setup.sh && \
  ln -vrs "$DOTFILES_PATH"/bash/bash/development_setup.sh "$HOME"/.local/bin/bash/development_setup.sh

echo 'set nocompatible' > "$HOME"/.vimrc

ASDF_DIR="${ASDF_DIR:-$HOME/.asdf}"
git clone --recurse-submodules --shallow-submodules https://github.com/asdf-vm/asdf.git "$ASDF_DIR"
pushd "$ASDF_DIR" >/dev/null 2>&1
git checkout "$(git describe --abbrev=0 --tags)"
popd >/dev/null 2>&1

if [[ -d "${ASDF_DIR}" ]]; then
  _EnvSetup
  asdf update
  ENV_LIST=(
    age
    bat
    direnv
    eza
    fd
    fzf
    peco
    jq
    ripgrep
    viddy
    yq
    yj
  )
  for i in ${ENV_LIST[@]}; do
    asdf plugin add "$i"
    asdf install "$i" latest
    asdf global "$i" latest
    asdf reshim "$i"
  done
  _EnvSetup
fi # .asdf check
