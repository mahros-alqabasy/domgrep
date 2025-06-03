# Use official Ubuntu LTS base image
FROM ubuntu:22.04

# Set noninteractive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary build tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    dpkg-dev \
    debhelper \
    fakeroot \
    gzip \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workdir

# By default, the container runs bash
CMD ["bash"]
