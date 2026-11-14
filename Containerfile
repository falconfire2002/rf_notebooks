FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive

# 1. Install core system packages & GNU Radio via APT
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip \
    python3-venv \
    python3-numpy \
    python3-scipy \
    python3-matplotlib \
    gnuradio \
    soapysdr-tools \
    libsoapysdr-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# 2. Create a virtual environment and install Jupyter Lab inside it
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir jupyterlab

EXPOSE 8888
WORKDIR /workspace

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]