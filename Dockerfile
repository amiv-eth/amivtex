FROM python:3.12.9-bullseye

COPY ./texlive.profile /tmp/install-tl-unx/texlive.profile
COPY ./amivtex /usr/local/texlive/texmf-local/tex/latex/amivtex

# Add texlive directory to the path
ENV PATH /usr/local/texlive/bin/x86_64-linux:$PATH

RUN apt-get update && apt-get install -y --no-install-recommends \
		perl \
		wget \
        # Xelatex needs libfontconfig
		libfontconfig \
        # Small tools to allow entrypoint to check if fonts are installed
        fontconfig \
	&& \
    rm -rf /var/lib/apt/lists/* 
    # Download Installer
RUN wget -O- http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz | \
    tar -xz -C /tmp/install-tl-unx --strip-components=1 
    # Install basic TeX
RUN    /tmp/install-tl-unx/install-tl \
      --profile=/tmp/install-tl-unx/texlive.profile 
    # Install xelatex and all required packages
RUN tlmgr install        collection-latex 
RUN tlmgr install        collection-langgerman 
RUN tlmgr install        xetex 
RUN tlmgr install        polyglossia 
RUN tlmgr install        xcolor 
RUN tlmgr install        pgf 
RUN tlmgr install        koma-script 
RUN tlmgr install        titlesec 
RUN tlmgr install        extsizes 
RUN tlmgr install        changepage 
RUN tlmgr install        count1to multitoc prelim2e ragged2e  
RUN tlmgr install        blindtext 
RUN tlmgr install        hyperref 
RUN tlmgr install        zapfding 
RUN tlmgr install        etoolbox 
        # required for iflang
RUN tlmgr install        oberdiek 
    
    # Cleanup
RUN rm -rf /tmp/install-tl-unx && \
    apt-get purge -y --auto-remove \
        perl

# Entrypoint script downloads non-public fonts at container start
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
