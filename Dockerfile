FROM ubuntu:22.04 as chroot
RUN /usr/sbin/useradd -u 1000 user
RUN pacman -Sy --noconfirm bind nmap

FROM ghcr.io/google/nsjail/nsjail:latest
COPY --from=chroot / /chroot
