# Use Arch linux as base because we need up to date version of TexLive
FROM dock0/arch


# Set HOME so we can use a local TEXMF tree and fonts
ENV HOME /


## TeX Setup

# Installation
RUN pacman -Sy --noconfirm texlive-core texlive-bin texlive-latexextra

# Add amivtex to local texmf tree
ADD . /texmf/tex/latex/amivtex


## Font Setup

# Docker build arg for font folder for flexibility
ARG FONT_DIR=./DINPro

# Add DINPro to local fonts and update font cache
ADD $FONT_DIR /.fonts/
RUN fc-cache -f -v
