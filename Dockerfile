FROM ubuntu:20.04
LABEL maintainer = "mbentz@ufl.edu"
LABEL version = "1.0.0"

# Install baseline packages
RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
    build-essential \
    git \
    bash \
    curl \
    wget \
    unzip \
    htop \
    man \
    vim \
    sudo \
    python3 \
    python3-pip \
    ca-certificates \
    locales \
    expect

# Install fabricate
RUN pip3 install fabric3

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Add a user `dev` so that you're not developing as the `root` user
RUN adduser --gecos '' --disabled-password cts-dev && \
  echo "cts-dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd

# COPY ~/.ssh ~/.ssh 

VOLUME /workspace
WORKDIR /workspace

USER cts-dev
