{ config, pkgs, ... }:

let
  typeMaticDelay = 150;
  typeMaticRate  = 70;
in
{
  virtualisation = {
    docker = {
      enable = true;
    };
  };
  services = {
    openvpn = {
      servers = { 
        client = {
          config = builtins.readFile ./haitlahcen.ovpn;
        };
      };
    };
    keybase = {
      enable = true;
    };
    openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
    mongodb = {
      enable = false;
    };
    nginx = {
      enable = false;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      virtualHosts."gitlab.nerded.com" = {
        locations."/".proxyPass = "http://unix:/run/gitlab/gitlab-workhorse.socket";
      };
    };
    gitlab = {
      enable = false;
      databasePassword = "redacted";
      host = "gitlab.nerded.com";
      port = 80;
      user = "gitlab";
      group = "gitlab";
      extraConfig = { gitlab = { default_projects_features = { builds = false; }; }; };
      secrets = { 
        secret = "194f3fd627a4720888a41e18151ae363538759d83798faf311da8753d00644c8";
        db = "2dfe66ed3b1abb2fe040e7e05e52c87e6958ed9df9e96e258c290aa7e1343d3f";
        otp = "0b6ca28ee347f279ea3f5a8e1cd0ae2961e1a00fc587364d9157799757dc07ab";
        jws = "7dbdcb839eb61836d9bddd1f5cdff0546bf7abe34972af44960a63985ecce5c8";
      };
    };
    gitlab-runner = {
      enable = false;
      packages = [ pkgs.bash pkgs.docker-machine pkgs.busybox ];
      configOptions = { 
        concurrent = 4;
        runners = [{
          name = "nixos";
          limit = 4;
          url = "http://gitlab.nerded.com/";
          token = "dff1ae9e543f0fcdaa656c4ed9cf52";
          executor = "shell";
          builds_dir = "/tmp/gitlab-runner";
          shell = "sh";
        }];
      };
    };
    postgresql = {
      enable = true;
      package = pkgs.postgresql_11;
      enableTCPIP = true;
      authentication = pkgs.lib.mkOverride 10 ''
        local all all trust
        host all all ::1/128 trust
        host all all 0.0.0.0/0 md5
      '';
      extraPlugins = [ pkgs.postgis ];
    };
    xserver = {
      autorun = true;
      enable = true;
      layout = "fr";
      videoDrivers = ["intel" "modesetting"];
      useGlamor = true;
      displayManager = {
        lightdm = {
          enable = true;
          background = "/etc/images/background.jpg";
        };
      };
      windowManager = {
        default = "i3";
        i3 = {
          enable = true;
          configFile = "/etc/i3/config";
          extraSessionCommands = ''
            xrdb -merge /etc/X11/Xresources
            xset r rate ${toString typeMaticDelay} ${toString typeMaticRate}
          '';
        };
      };
      synaptics = {
        enable = true;
        twoFingerScroll = true;
        minSpeed = "1";
        maxSpeed = "1";
      };
    };
  };
}
