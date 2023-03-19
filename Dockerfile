FROM nixos/nix as nsjailbin
RUN nix --extra-experimental-features 'nix-command flakes' build nixpkgs#nsjail -o /nsjail

FROM ubuntu:22.04
COPY --from=nsjailbin /nix /nix
COPY --from=nsjailbin /nsjail /nsjail
