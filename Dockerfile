FROM ubuntu:22.04

# Enable file sourcing
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Locales
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN apt-get update && apt-get install -y locales && locale-gen en_US.UTF-8

# Common packages
RUN apt-get update && apt-get install -y \
    apt-utils \
    build-essential \
    iputils-ping \
    net-tools \
    python3 \
    unzip \
    sudo \
    git \
    tmux \
    rsync \
    curl \
    wget \
    zsh

# Neovim
RUN apt-get update && apt-get install -y software-properties-common \
    && add-apt-repository ppa:neovim-ppa/unstable \
    && apt-get update \
    && apt-get install -y neovim

# Nodejs and npm
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 19.9.0
RUN mkdir /usr/local/nvm
RUN curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION

# Make node and npm available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Web-TTY Setup
RUN npm i -g yarn \
    && yarn global add wetty@2.5.0
# Upgrade npm version (Wetty needs npm v8.19.2)
RUN npm i -g npm@latest

# Bootstrap
COPY ./bootstrap.sh /usr/local/sbin
RUN chmod u+x /usr/local/sbin/bootstrap.sh
CMD [ "bootstrap.sh" ]
