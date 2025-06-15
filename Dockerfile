# Multi-stage build for tmap wheel/sdist generation
FROM python:3.12.9-slim AS builder

# Install system dependencies for building
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY ogdf-conda ./ogdf-conda
COPY src ./src
COPY pybind11 ./pybind11
COPY CMakeLists.txt pyproject.toml setup.py ./

# Set working directory
WORKDIR /app/ogdf-conda/src

RUN cmake . && make -j$(nproc) && mkdir lib && cp *.a lib/

# Install Python build dependencies in conda environment
RUN pip install --no-cache-dir build wheel setuptools

WORKDIR /app

# Build the wheel and source distribution
RUN python setup.py build && python setup.py bdist_wheel

# Output stage - just copy the built artifacts
FROM scratch AS artifacts
COPY --from=builder /app/dist/ /dist/

