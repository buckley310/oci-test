FROM ubuntu:22.04 as chal

RUN apt update
RUN apt install -y iproute2
RUN useradd -m chal


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

COPY --from=chal / /chroot

RUN useradd -m sbox

RUN apt install -y uidmap htop

# https://github.com/google/nsjail/blob/master/Dockerfile
