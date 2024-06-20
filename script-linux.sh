#!/usr/bin/env bash

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

echo 'set nocompatible' > "$HOME"/.vimrc
