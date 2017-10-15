# amivtex
Tex templates for the AMIV CI

Two document classes are provided: `amivletter` and `amivbooklet` -- and they
are easy to use, take a look in the examples folder to see all available commands and how to use them.

## Quick Usage

If you only need to edit or create a single document quickly, this is what you need to do:

1. [Download all amivtex files](https://github.com/NotSpecial/amivtex/archive/master.zip)
2. Choose:
    - Copy your document into the `amivtex` subfolder
      (put it right next to the `.sty` files!)
    - Pick the example that fits your intentions best
      and copy it to the `amivtex` folder (again, right next to the `.sty` files)
3. In your editor, set the engine from `LaTex` (or whatever is activated) to `XeLaTex`
   (otherwise we can't use the *DIN Pro* font)
4. Make sure you have the *DIN Pro* Font installed (see *Installation* for quick download links)

All done, you can now edit and compile your document!

## Installation

### Prerequisites: Fonts & XeLaTex

The *Din Pro* font must be installed. It is not public, [but available
for all ETH Members](https://www.ethz.ch/services/en/service/communication/corporate-design/font/ff-din-pro.html).
For convenience, it can also be found in the AMIV Drive and 
[AMIV Wiki](https://wiki.amiv.ethz.ch/Corporate_Design#DINPro).

To use this font, 
[XeLaTex](https://de.wikipedia.org/wiki/XeTeX) must be used.
On Linux, TexLive includes XeLaTeX, MiKTeX on Windows as well.


### Linux & MacOS

Some TeX Editors allow to add additional resources directly.
Otherwise, probably the easiest way is to just add amivtex to the local texmf tree.

```bash
# Create local texmf tree, be careful to get the subdirectories right
## Linux
mkdir -p ~/texmf/tex/latex/
## MacOS
mkdir -p ~/Library/texmf/tex/latex/

# Clone amivtex and create symlink
git clone https://github.com/NotSpecial/amivtex.git
## Linux
ln -s ./amivtex/amivtex ~/texmf/tex/latex
## MacOS
ln -s ./amivtex/amivtex ~/Library/texmf/tex/latex
```

No further steps necessary, it should be detected automatically.
[More info here.](https://wiki.archlinux.org/index.php/TeX_Live#Install_.sty_files)


### Windows

MikTex has several options to add `.sty` files,
e.g. a simple command line option `--include-directory=<your_amivtex_dir>/amivtex`,
which can be added in your Tex Editor.
(Be careful to include the subdirectory `amivtex` which actually contains the .sty files)
[More Info.](http://docs.miktex.org/manual/localadditions.html)


### Verify your installation

Open one of the example `.tex` files. If they compile, you are good to go.


## Docker

If you want to create a python application that requires amivtex,
a Docker image is available with python3, xelatex and the templates installed.
Begin your Dockerfile with
`FROM notspecial/amivtex` and you are nearly set.

As the *Din Pro* font is not public, it cannot be included in the
public image, but the image contains an entrypoint-script which will install
the font at container startup, before the first `CMD` is executed.

**Note**: Make sure *not* to use the `ENTRYPOINT` instruction in your `Dockerfile`,
or you will overwrite this setup!

The font can be provided in the following ways:

### Using docker secrets (recommended)

[Docker secrets](https://docs.docker.com/engine/swarm/secrets/#read-more-about-docker-secret-commands) allow handling sensitive data
conveniently.
The container accepts an URL to download the fonts as secret.
(The URL can be found in the [AMIV Wiki](https://wiki.amiv.ethz.ch/Corporate_Design#DINPro))

```bash
# Create the secret named 'font_url'
echo "URL" | docker secret create font_url -
# Start your container (which builds on amivtex) with the secret
docker service create --name your_amivtex_app --secret font_url your_amivtex_app_image
```

The amivtex image looks for the secret at `/run/secrets/font_url`,
so if you name your secret differently, either adjust the mount point
or specify the path with the environment variable `FONT_URL_FILE`:

```bash
docker service create \
  --name your_amivtex_app \
  --secret my_secret \
  -e FONT_URL_FILE="/run/secrets/my_secret" \
  your_amivtex_app_image
```

### Using environment vars

If you can't use secrets, you can pass
the URL directly with the environment variable `FONT_URL`.

If you don't want the container to download anything,
you can also mount the compressed fonts (`.tar.gz`) and
let the image the path where you mounted the archive with
the environment variable `FONT_ARCHIVE`.
