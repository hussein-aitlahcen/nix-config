{ config, pkgs, ... }:

{
  environment = {
    etc = {
      "wpa_supplicant.conf"            .source = ./config/wpa_supplicant.conf;
      "i3/config"                      .source = ./config/i3;
      "X11/Xresources"                 .source = ./config/Xresources;
      "images/background.jpg"          .source = ./images/background.jpg;
    };
    shellAliases = {
      gst = "git status";
      off = "shutdown -f 0";
      bright = "xbacklight -set 100%";
      dark = "xbacklight -set 5%";
      lock = "i3lock -c 000000";
    };
  };
}
