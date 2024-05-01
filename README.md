# ID's new GNU/Linux config files.

My old configs and their git historys are way too messy.  Plus the git directory
is too fat, since I used to use git to track my fonts.  This made me have to use
`--depth 1` flag every time I clone the repo to another PC, But this sometimes
fucked up the git branches.  So I decide to start this new repo to hold the
config files I actually use now.  It's small (for now,) and won't have any
font-related commits in here.

Old configs can still be found
[here](https://www.github.com/funk443/old-dotfiles).

# Usage

Make sure you have "JetBrains Mono" font family installed on your system.  I
typically clone the repo under my home directory.

```
mkdir -p ~/.config

ln -sf -t ~/.config ~/dotfiles/.config/nvim ~/dotfiles/.config/kitty

ln -sf ~/dotfiles/.bash_custom ~/
```

Add this to `.bashrc` (or `.profile`, or things like that):

```
source ~/.bash_custom
```
