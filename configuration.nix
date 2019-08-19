{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ./network.nix
    ./environment.nix
    ./fonts.nix
    ./programs.nix
    ./services.nix
    ./users.nix
    ./audio.nix
    ./print.nix
  ];
  system = {
    stateVersion = "19.03";
  };
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  nix = {
    binaryCaches = [
      "https://cache.nixos.org/"
      "https://hie-nix.cachix.org"
    ];
    binaryCachePublicKeys = [
      "hie-nix.cachix.org-1:EjBSHzF6VmDnzqlldGXbi0RM3HdjfTU3yDRi9Pd0jTY="
    ];
    trustedUsers = [ "root" "hussein" ];
  };
}
