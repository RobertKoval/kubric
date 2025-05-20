FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    # Essential build tools
    build-essential \
    cmake \
    git \
    curl \
    wget \
    ca-certificates \
    # Python 3.10 support (python3-dev for C extensions, pip)
    python3-dev \
    python3-pip \
    python3-distutils \
    # Common libraries for Python C extensions
    libffi-dev \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libsqlite3-dev \
    uuid-dev \
    # Blender and rendering dependencies
    libopenexr-dev \
    libx11-dev \
    libxxf86vm-dev \
    libxcursor-dev \
    libxi-dev \
    libxrandr-dev \
    libxinerama-dev \
    libglew-dev \
    subversion \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

RUN pip3 install --upgrade pip wheel
RUN pip3 install --upgrade --force-reinstall -r requirements.txt

COPY . .

# Install kubric
RUN pip3 install --no-cache-dir .