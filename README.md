# amivtex
Tex templates for the AMIV CI

This contains a basic AMIV letter only yet.

## Prequisites

To be able to switch to a different font [Xetex](https://de.wikipedia.org/wiki/XeTeX) must be used in stead of pdflatex.
On Linux TexLive supports this, MikTex on Windows afaik as well.

## What is used

The excellent [KOMA script](http://www.komascript.de) package with the ```scrlltr2``` class

## How is it structured

In  ```amivdefaults.sty``` all basic packages are included and amiv information such as public address etc are set.

In ```komadefaults.sty``` everything needed for KOMA letters is done.

Finally ```amiv_letter_template.tex``` shows how this is all used together (This file can be used as a template)

## Common problems:

### Font

Make sure the DinPro Font is installed on your system or it wont work.
