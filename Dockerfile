FROM nixos/nix as nsjailbin
RUN mkdir -p /export/store
RUN nix --extra-experimental-features 'nix-command flakes' build nixpkgs#nsjail -o /export/.nsjail
RUN ln -s .nsjail/bin/nsjail /export/nsjail
RUN cp -a $(nix-store --query --requisites /export/nsjail) /export/store/

FROM ubuntu:22.04
COPY --from=nsjailbin /export /nix
