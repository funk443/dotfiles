---
Title: ID's GNU/Linux dotfiles
Author: CToID
---

My personal config files for various softwares, I hope you'll find it useful.

# Quickstart

The deploy script for software configurations are yet to be written, so you'll
have to resolve to manually symlink these files now.

There is a convenience script `theme-setup.sh` for setup the GTK theme and fonts
tho. For GTK theme, I use [Skewaita], which is already setup as a submodule of
this repository. For icon theme, I use [Oxylite].

The script can do the following things for you:

- Clone the Skewaita submodule, and set it up to MY taste, symlink it to the
  standard XDG directory, then set it as the GTK theme.
- Get the release of Oxylite, uncompress it, symlink it to the standard XDG
  directory, then set it as icon theme.
- Set default fonts for GTK applications.

[Skewaita]: <https://git.disroot.org/eudaimon/Skewaita>
[Oxylite]: <https://github.com/mx-2/oxylite-icon-theme>
