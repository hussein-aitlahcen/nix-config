{ config, pkgs, ... }:

{
  fonts = {
    fonts = with pkgs; [
      corefonts
      fira-code
      fira-code-symbols
      powerline-fonts
      emacs-all-the-icons-fonts
    ];
  };
}