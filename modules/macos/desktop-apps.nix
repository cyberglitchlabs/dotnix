{ config, lib, pkgs, options, ... }: {
  imports = [ ./homebrew.nix ];
  config.homebrew.casks = [    
    "iterm2"
    "spotify"
    "signal"
    "logseq"
    "aldente"
  ];
}