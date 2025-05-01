# ID's GNU/Linux dotfiles

This repository exists because the git history of my old dotfiles is a
fucking mess. The git directory of the old ones are so fat, since I
used to use git to track my fonts (binary files). This large size of
directory forces me to clone with `--depth=1` flag, this strategy
works well at first, but then, I have a new Thinkpad, which I created
a new branches for. And I think cloning with `--depth=1` and branches
don't work together very well, for example, sometimes I try to merge
the branches, and because the history is chopped off (`--depth=1`,)
git will yell at me. Thus I created this new repo, and I promise I
won't track binary font files this time. ;)

Also, I'll try to keep the content of these new configs simple, nice,
and clean.

## Quick start

### General software configs

I usually clone this repositoy under my home directory.

```console
# Replace emacs with other things.
$ mkdir ~/.config/emacs
$ ln -s ~/dotfiles/.config/emacs/* ~/.config/emacs
```

There is also a `.bash_custom` file for my bash customisation, e. g.
`vterm` integration.

```console
$ ln -s ~/dotfiles/.bash_custom ~/
```

### GTK stuffs

I'm currently using
[Skewaita](https://git.disroot.org/eudaimon/Skewaita.git) GTK theme
and [Oxylite](https://github.com/mx-2/oxylite-icon-theme) icon pack.

The script [theme-setup.sh](./theme-setup.sh) should do all the works
for you. simply run `./theme-setup.sh all` and things should be done.
but I don't know if this script I wrote (I'm not a Bash master) is
robust enough to run on every machine, something could go horribly
wrong (no `rm` is used in the script, so the most severe case should
be a few symlinks and files littered in your home directory,) so use
at your own risk. To deploy the themes by yourself, run:

```console
$ cd .local/share/themes/Skewaita/source/templates
$ ./use_scheme.sh colorscheme-dark-adwaita.sh
$ cd ..
$ ./compile.sh dark

$ gsettings set org.gnome.desktop.interface gtk-theme Skewaita
$ gsettings set org.gnome.desktop.interface icon-theme oxylite
$ gsettings set org.gnome.desktop.interface color-scheme prefer-dark

$ gsettings set org.gnome.desktop.interface font-name "Source Sans 3 12"
$ gsettings set org.gnome.desktop.interface monospace-font-name "Source Code Pro 12"
$ gsettings set org.gnome.desktop.interface document-font-name "Source Seirf 4 12"
```
