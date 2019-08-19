{ config, pkgs, ... }:

let
  userName = "hussein";
  userDescription = "Hussein Ait Lahcen";
in
{
  time = {
    timeZone = "Europe/Paris";
  };
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    consoleKeyMap = "fr";
  };
  users = {
    extraGroups = [
      { name = userName; gid = 1000; }
    ];
    extraUsers = {
      "${userName}" = {
        home = "/home/${userName}";
        isNormalUser = true;
        description = userDescription;
        extraGroups = [
          "wheel"
          "networkmanager"
          "video"
          "audio"
          "docker"
        ];
        shell = pkgs.zsh;
      };
    };
  };
}
