{ config, pkgs, ... }:

let
  sysPkgs = with pkgs; [
    xautolock
    xorg.xbacklight
    feh
    keybase
    gnupg
    gtk3
    stdenv
    zip
    unzip
    zeal
    git
    zsh
    zsh-syntax-highlighting
    emacs
  ];
in
{
  environment.systemPackages = sysPkgs;
}
