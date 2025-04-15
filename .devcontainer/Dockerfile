FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    build-essential \
    tcl8.6-dev tk8.6-dev \
    libx11-dev libxmu-dev libxt-dev libxpm-dev \
    libgtk2.0-dev libpcap-dev \
    gawk libssl-dev \
    git xgraph python3 gnuplot wget unzip

# Download and install NS2 (version 2.35 here)
RUN cd /opt && \
    wget https://sourceforge.net/projects/nsnam/files/allinone/ns-allinone-2.35/ns-allinone-2.35.tar.gz && \
    tar -xvzf ns-allinone-2.35.tar.gz && \
    cd ns-allinone-2.35 && \
    ./install

ENV PATH="/opt/ns-allinone-2.35/ns-2.35/:$PATH"
