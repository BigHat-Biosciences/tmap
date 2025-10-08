# Multi-stage build for tmap wheel/sdist generation
# Using Ubuntu 22.04 (same base as CodeBuild Standard 7.0)
FROM public.ecr.aws/ubuntu/ubuntu:22.04 AS builder

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Install system dependencies for building
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    curl \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libxml2-dev \
    libxmlsec1-dev \
    libffi-dev \
    liblzma-dev \
    && rm -rf /var/lib/apt/lists/*

# Install pyenv (same approach as CodeBuild Standard 7.0)
RUN curl -s -S -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
ENV PATH="/root/.pyenv/shims:/root/.pyenv/bin:$PATH"

# Install Python 3.12 using pyenv (matching CodeBuild Standard 7.0)
ENV PYTHON_312_VERSION="3.12.11"
RUN pyenv install $PYTHON_312_VERSION && \
    pyenv global $PYTHON_312_VERSION && \
    pip3 install --no-cache-dir --upgrade pip && \
    pip3 install wheel setuptools

WORKDIR /app

COPY ogdf-conda ./ogdf-conda
COPY src ./src
COPY pybind11 ./pybind11
COPY CMakeLists.txt pyproject.toml setup.py ./

# Set working directory
WORKDIR /app/ogdf-conda/src

RUN cmake . && make -j$(nproc) && mkdir lib && cp *.a lib/

WORKDIR /app

# Install Python build tool
RUN pip3 install --no-cache-dir build

# Build the wheel and source distribution
RUN python setup.py build && python setup.py bdist_wheel

# Output stage - just copy the built artifacts
FROM scratch AS artifacts
COPY --from=builder /app/dist/ /dist/

