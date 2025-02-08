# ID's GNU/Linux dotfiles

This repository exists because the git history of my old dotfiles is a fucking
mess.  The git directory of the old ones are so fat, since I used to use git to
track my fonts (binary files).  This large size of directory forces me to clone
with `--depth=1` flag, this strategy works well at first, but then, I have a new
Thinkpad, which I created a new branches for.  And I think cloning with
`--depth=1` and branches don't work together very well, for example, sometimes I
try to merge the branches, and because the history is chopped off (`--depth=1`,)
git will yell at me.  Thus I created this new repo, and I promise I won't track
binary font files this time. ;)

Also, I'll try to keep the content of these new configs simple, nice, and clean.

## Quick start

I usually clone this repositoy under my home directory.

```console
# Replace emacs with other things.
$ mkdir ~/.config/emacs
$ ln -s -t ~/.config/emacs ~/dotfiles/.config/emacs/*
```

There is also a `.bash_custom` file for my bash customisation, e. g. `vterm`
integration.

```console
$ ln -s ~/dotfiles/.bash_custom ~/
```

## Softwares I have config for

- Terminals:
  - Alacritty
  - Kitty
  - Foot

- Editors:
  - Emacs
  - Lem
  - Neovim

- Others:
  - Bash
  - i3wm
  - dunst
  - git
