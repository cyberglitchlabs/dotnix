{ config, lib, pkgs, options, ... }: {
  cfg.os.name = "macos";
  system.stateVersion = 4;

  home-manager.users."${config.cfg.user.name}" = {
    home.sessionPath = [ 
      "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    ];
  };

}