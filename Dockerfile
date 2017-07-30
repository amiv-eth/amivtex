FROM python:3.6-slim

COPY ./texlive.profile /tmp/install-tl-unx/texlive.profile

# Add texlive directory to the path
ENV PATH /usr/local/texlive/2017/bin/x86_64-linux:$PATH


RUN apt-get update && apt-get install -y --no-install-recommends \
		perl \
		wget \
		tar \
        libfontconfig \
	&& \
    # Download Installer
    wget -qO- ftp://tug.org/texlive/historic/2017/install-tl-unx.tar.gz | \
    tar -xz -C /tmp/install-tl-unx --strip-components=1 && \
    # Install
    /tmp/install-tl-unx/install-tl \
      --profile=/tmp/install-tl-unx/texlive.profile
RUN rm -rf /tmp/install-tl-unx

CMD ["tex"]