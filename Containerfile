FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

ARG GNURADIO_VERSION=v3.10.12.0

# 1. Install base requirements, venv, and all required build tools & dependencies for libiio
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    python3 \
    python3-pip \
    python3-venv \
    sudo \
    cmake \
    build-essential \
    pkg-config \
    libxml2-dev \
    libusb-1.0-0-dev \
    libiio-utils \
    libzstd-dev \
    libavahi-client-dev \
    libavahi-common-dev \
    libaio-dev \
    flex \
    bison \
    && rm -rf /var/lib/apt/lists/*

# 2. Build and install libiio v1.x from source so Python bindings match
RUN git clone https://github.com/analogdevicesinc/libiio.git /tmp/libiio && \
    cmake -S /tmp/libiio -B /tmp/libiio/build -DPYTHON_BINDINGS=ON -DCMAKE_BUILD_TYPE=Release && \
    cmake --build /tmp/libiio/build -j$(nproc) && \
    cmake --install /tmp/libiio/build && \
    ldconfig && \
    rm -rf /tmp/libiio

# 3. Clone GNU Radio into the home directory (~/gnuradio -> /root/gnuradio) and check out your version
RUN cd /root && \
    git clone https://github.com/gnuradio/gnuradio.git gnuradio && \
    cd gnuradio && \
    git checkout ${GNURADIO_VERSION} && \
    git submodule update --init --recursive

# 4 Doug Geiger's installer scripts into ~/gr-installers (/root/gr-installers)
RUN mkdir -p /root/gr-installers && cd /root/gr-installers && \
    for f in gnuradio_dependencies_installer.py gnuradio_clone_builder.py; do \
      python3 -c "import sys, urllib.request; urllib.request.urlretrieve(sys.argv[1] + sys.argv[2], sys.argv[2])" https://github.com/duggabe/gr-wiki-revision/releases/latest/download/ $f; \
    done

# 5. Run the dependency installer non-interactively to configure build tools, UHD, and drivers
RUN cd /root/gr-installers && \
    python3 gnuradio_dependencies_installer.py --yes --no-images

# 6. Run the clone builder script non-interactively with testing disabled via cmake args
RUN cd /root/gr-installers && \
    python3 gnuradio_clone_builder.py -y --cmake-args="-DENABLE_TESTING=OFF"

# 7. Set up Python virtual environment and install packages safely with quoted version constraints
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir "numpy<2.0.0" scipy jupyterlab pylibiio matplotlib matplotlib-inline pyadi-iio
    
RUN echo 'source /root/gnuradio-pkg/setup_env.sh' >> /root/.bashrc
# 8. Link the compiled GNU Radio package environment paths
# 8. Set up environment paths and dynamic library links for the compiled GNU Radio package
ENV PATH="/root/gnuradio-pkg/bin:$PATH"
ENV PYTHONPATH="/root/gnuradio-pkg/lib/python3.12/site-packages:/root/gnuradio-pkg/lib/python3/dist-packages:$PYTHONPATH"
ENV LD_LIBRARY_PATH="/root/gnuradio-pkg/lib:$LD_LIBRARY_PATH"

# Register the custom library path with the system linker
RUN echo "/root/gnuradio-pkg/lib" > /etc/ld.so.conf.d/gnuradio.conf && ldconfig

EXPOSE 8888
WORKDIR /workspace

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser", "--ServerApp.token='pluto'"]