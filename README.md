# amivtex
Tex templates for the AMIV CI

Two document classes are provided: `amivletter` and `amivbooklet` -- and they
are easy to use!

Take a look in the examples folder to see how to use them.

## Prerequisites

### Fonts

The `DinPro` Font must be installed.

### Xetex

To be able to switch to a different font
[XeLatex](https://de.wikipedia.org/wiki/XeTeX) must be used in stead of
pdflatex. On Linux TexLive includes Xetex, MikTex on Windows as well.

## Installation

### Linux

Probably the easiest way is to just clone amivtex into the local texmf tree.

```
# Create directory structure, be careful to create the subdirectories right
mkdir -p ~/texmf/tex/latex/
cd ~/texmf/tex/latex/
# Clone
git clone https://github.com/NotSpecial/amivtex.git
```

No further steps necessary, it should be detected automatically.
[More info here.](https://wiki.archlinux.org/index.php/TeX_Live#Install_.sty_files)

### Windows

MikTex has severeal option, e.g. a simple command line addition.
[Detailed Info.](http://docs.miktex.org/manual/localadditions.html)


### Verify your installation

Open one of the example `.tex` files. If they compile, you are good to go.
