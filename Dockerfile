FROM ghcr.io/truatpasteurdotfr/docker-ubuntu-lts2204-ci:latest
MAINTAINER Tru Huynh <tru@pasteur.fr>

# https://gitlab.pasteur.fr/tru/oneapi-hpckit-2023-devel-rl9/-/issues/2
# https://askubuntu.com/questions/1405417/20-04-vs-22-04-inside-docker-with-a-16-04-host-thread-start-failures

RUN apt-get update && DEBIAN_FRONTEND=noninteractive  apt-get -y upgrade && \
	DEBIAN_FRONTEND=noninteractive  apt-get -y install cmake automake clang-15 bison flex libfuse-dev libudev-dev pkg-config libc6-dev-i386 \
		gcc-multilib libcairo2-dev libgl1-mesa-dev curl libglu1-mesa-dev libtiff5-dev \
		libfreetype6-dev git git-lfs libelf-dev libxml2-dev libegl1-mesa-dev libfontconfig1-dev \
		libbsd-dev libxrandr-dev libxcursor-dev libgif-dev libavutil-dev libpulse-dev \
		libavformat-dev libavcodec-dev libswresample-dev libdbus-1-dev libxkbfile-dev \
		libssl-dev libstdc++-12-dev && \
	cd /opt && git clone --recursive https://github.com/darlinghq/darling.git \
	cd darling && \
	tools/uninstall && \
	mkdir build && cd build &&\
	cmake .. && \
	make && make install 

RUN date +"%Y-%m-%d-%H%M" > /last_update
