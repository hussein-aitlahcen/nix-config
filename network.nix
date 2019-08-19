{ config, pkgs, ... }:

let
  hostname = "nerded";
in
{
  networking = {
    hostName = "${hostname}";
    wireless = {
      enable = true;
    };
    nat = {
      enable = true;
      internalInterfaces = ["ve-+"];
      externalInterface = "wlp2s0";
    };
    resolvconfOptions = [
      "127.0.0.1"
    ];
  };
}

