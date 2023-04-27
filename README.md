# Noe's Dotfiles

My dotfiles are heavily inspired by [Luke Smith's dotfiles](https://github.com/LukeSmithxyz/voidrice), which I strongly encourage you to check out for more info.

* Very useful scripts are in `~/.local/bin/`
* Settings for:
    * nvim (text editor)
    * zsh (shell)
    * lf (file manager)
    * mpd/ncmpcpp (music)
    * nsxiv (image/gif viewer)
    * mpv (video player)
    * other stuff like xdg default programs, inputrc and more, etc.
* I try to minimize what's directly in `~` so:
    * All configs that can be in `~/.config/` are.
    * Some environmental variables have been set in `~/.zprofile` to move configs into `~/.config/`
* Bookmarks in text files used by various scripts
    * File bookmarks in `~/.config/shell/bm-files`
    * Directory bookmarks in `~/.config/shell/bm-dirs`

## Usage

These dotfiles are intended to go with numerous suckless programs I use:

* [dwm](https://github.com/thatguynoe/dwm) (window manager)
* [dwmblocks](https://github.com/thatguynoe/dwmblocks) (statusbar)
* [st](https://github.com/thatguynoe/st) (terminal emulator)

## A Note on Neovim

My `init.vim` is split into multiple files for easier management. Consequently, grabbing my `init.vim` is tedious as you would also have to grab all the sourced files. You can run the following to combine all sourced files into one `init.vim` after cloning the repo.

```sh
sed 's|^\([^/]*\/\)\{2\}|dots/\.config/nvim/|g' dots/.config/nvim/init.vim | xargs cat > combined_init.vim
```

## Install these dotfiles and all dependencies

```sh
curl -O https://raw.githubusercontent.com/thatguynoe/NARBS/main/narbs.sh
sh narbs.sh
```
