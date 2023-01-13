FROM ubuntu:22.04

# Enable file sourcing
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Locales
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN apt-get update && apt-get install -y locales && locale-gen en_US.UTF-8

# Common packages
RUN apt update && apt install -y \
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
#RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.8.2/nvim-linux64.tar.gz
#RUN tar xzvf nvim-linux64.tar.gz
#RUN rsync -a nvim-linux64/ /usr/local/
#RUN rm -rf nvim-linux64*
RUN apt update && apt install -y software-properties-common \
	&& add-apt-repository ppa:neovim-ppa/unstable \
	&& apt update \
	&& apt install -y neovim

# Nodejs and npm
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 18.12.1
RUN mkdir /usr/local/nvm
RUN curl https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION #\
    #&& nvm alias default $NODE_VERSION \
    #&& nvm use default

# Make node and npm available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Web-TTY Setup
RUN npm i -g yarn \
    && yarn global add wetty

ADD ./bootstrap.sh /usr/local/sbin
RUN chmod u+x /usr/local/sbin/bootstrap.sh
CMD [ "bootstrap.sh" ]
