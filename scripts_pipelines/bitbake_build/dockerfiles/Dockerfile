FROM crops/poky:latest 

USER root

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        software-properties-common 

RUN add-apt-repository ppa:ubuntu-toolchain-r/test && apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        texinfo \
        python3-pip \
        python3-pexpect \
        python3-git \
        python3-jinja2 \
        libegl1-mesa \
        libsdl1.2-dev \
        pylint3 \
        xterm

