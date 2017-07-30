FROM python:3.6-slim

COPY ./texlive.profile /tmp/install-tl-unx/texlive.profile
COPY ./amivtex /usr/local/texlive/texmf-local/tex/latex/amivtex

# Add texlive directory to the path
ENV PATH /usr/local/texlive/2017/bin/x86_64-linux:$PATH

RUN apt-get update && apt-get install -y --no-install-recommends \
		perl \
		wget \
		libfontconfig \
	&& \
    rm -rf /var/lib/apt/lists/* && \
    # Download Installer
    wget -qO- ftp://tug.org/texlive/historic/2017/install-tl-unx.tar.gz | \
    tar -xz -C /tmp/install-tl-unx --strip-components=1 && \
    # Install basic TeX
    /tmp/install-tl-unx/install-tl \
      --profile=/tmp/install-tl-unx/texlive.profile && \
    # Install xelatex and all required packages
    tlmgr install \
        collection-latex \
        collection-langgerman \
        xetex \
        polyglossia \
        xcolor \
        koma-script \
        titlesec \
        extsizes \
        changepage \
        marginnote \
        blindtext \
    && \
    # Cleanup
    rm -rf /tmp/install-tl-unx && \
    apt-get purge -y --auto-remove \
        perl

# Entrypoint script downloads non-public fonts at container start
ENV FONT_URL /run/secrets/font_url
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
