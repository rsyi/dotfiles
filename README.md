# dotfiles

These are my personal dot-files and configuration files. In general, I've come
to rely a lot less on a bash script for fresh installs as I used to for a
couple of reasons:

1. **Bloat:** I found that I was copying over a lot of files that I didn't
   need. By the time I do some sort of system reset, the file that I set up
years ago is usually full of cruft that I've since deprecated, and so to run it
with confidence requires re-writing it anyway.
2. **Outdated:** The preferred installation mechanisms for things changes --
   e.g. for a long time installing Python binaries directly was the preferred
method of setting up Python, but homebrew has, over the years, become much more
reliable.

So I now follow a much simpler philosophy:

- Copy over dotfiles, keys, and config files so my configurations are ported over.
- Write down some instructions for setting up the manual things that I know I'll need.

In all, the whole process takes only ~15 minutes, which is generally less than
the amount of time it takes to maintain a dedicated shell script.

So where this directory once was fully of shell scripts and a more automated
deployment system, it's now just a collection of configuration files and this
README, compiling the instructions and sharing my philosophy.

## MacOS

Rather than using a shell script and copying over files from this repository,
I've found lately that the fastest way to get started with a new machine for
mac is to copy over the following directories and files manually:

- `~/.config/`
- `~/.hammerspoon/`
- `~/.ssh/`
- `~/.zshrc/`
- `~/.oh-my-zsh/` (optional)
- `~/.tmux.conf`
- `~/path/to/misc/keys/`

Then install software as needed. In particular, set up:

- [Homebrew](https://docs.brew.sh/Installation)
- [Alacritty](https://github.com/alacritty/alacritty)
  - By default, my alacritty toml file uses [VictorMono Nerd Font
  Mono](https://www.nerdfonts.com/font-downloads#:~:text=Download-,VictorMono,-%E2%80%A2%20Version%3A%201.5.6),
  which needs to be downloaded for the system not to fall back to Menlo. For
  lazy.nvim, you need some sort of nerd font at minimum.
- `brew install python3` (note, this comes with `pip3`, but you'll need to
alias `pip3` as `pip`)
- `rust`
- `rust-analyzer` and `rust-src` (or just `brew install rust-analyzer` so
lazy.nvim can detect it)

I otherwise don't keep any static files on disk. I do have an Obsidian vault
which I back up to git, so I pull this, then manually connect it to Obsidian.
