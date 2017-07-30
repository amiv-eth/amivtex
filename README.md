# amivtex
Tex templates for the AMIV CI

Two document classes are provided: `amivletter` and `amivbooklet` -- and they
are easy to use, ake a look in the examples folder to see all available commands and how to use them.

## Docker

(Will add as soon as the automated build is set up)

## Installation

### Prerequisites: Fonts & XeLaTex

The `DinPro` Font must be installed. To be able to switch to a different font in Latex, 
[XeLaTex](https://de.wikipedia.org/wiki/XeTeX) must be used. On Linux TexLive includes XeLaTeX, MikTex on Windows as well.


### Linux

Probably the easiest way is to just clone amivtex into the local texmf tree.

```bash
# Create local texmf tree, be careful to get the subdirectories right
mkdir -p ~/texmf/tex/latex/

# Clone amivtex and create symlink
git clone https://github.com/NotSpecial/amivtex.git
ln -s amivtex/amivtex ~/texmf/tex/latex
```

No further steps necessary, it should be detected automatically.
[More info here.](https://wiki.archlinux.org/index.php/TeX_Live#Install_.sty_files)


### Windows

MikTex has several options to add `.sty` files,
e.g. a simple command line option `--include-directory=<your_amivtex_dir>`.
[Detailed Info.](http://docs.miktex.org/manual/localadditions.html)


### Verify your installation

Open one of the example `.tex` files. If they compile, you are good to go.
