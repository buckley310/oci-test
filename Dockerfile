FROM ubuntu:22.04 as chal

RUN apt update
RUN apt install -y curl iproute2 iputils-ping uidmap htop
RUN useradd -m -u 1000 chal

FROM ubuntu:22.04

RUN apt-get -y update && apt-get install -y \
    autoconf \
    bison \
    flex \
    gcc \
    g++ \
    git \
    libprotobuf-dev \
    libnl-route-3-dev \
    libtool \
    make \
    pkg-config \
    protobuf-compiler

RUN git clone --branch 3.3 https://github.com/google/nsjail.git

RUN cd /nsjail && make && mv /nsjail/nsjail /bin && rm -rf -- /nsjail

RUN apt install -y curl iproute2 iputils-ping uidmap htop

COPY --from=chal / /chroot

# https://github.com/google/nsjail/blob/master/Dockerfile
