{ config, pkgs, ... }: {
  imports = [
    #../../modules/common/fonts/fonts.nix
    ../../modules/home/home.nix

    # ../../modules/macos/service-yabai/service-yabai.nix
    #../../modules/macos/application-desktop/application-desktop.nix
    ../../modules/macos/desktop-apps.nix
    
    ./software.nix
    #./modules/icrossing.nix
  ];
}