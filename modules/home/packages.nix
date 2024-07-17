{ config, lib, pkgs, options, ... }:
with pkgs.stdenv;
with lib;
let
  # fzshInitExtraConfig = import ./zshInitExtraConfig.nix;
  # zshInitExtraConfig = fzshInitExtraConfig { lib = lib; pkgs = pkgs; };
  # fgetZshInitExtra = import ./getZshInitExtra.nix;
  # getZshInitExtra = fgetZshInitExtra { lib = lib; pkgs= pkgs; zshInitExtraConfig = zshInitExtraConfig; };
in {

}