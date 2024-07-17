{ config, pkgs, ... }: {
  imports = [ ./modules.nix ];
  cfg.os.version = "24.05";
  nix.settings.max-jobs = 16;
  cfg.os.hostname = "macmeh";
  nixpkgs.hostPlatform = "x86_64-darwin";
  security.pam.enableSudoTouchIdAuth = true;
  home-manager.users."${config.cfg.user.name}" = {
    home.sessionPath = [ 
      "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    ];
  };


  system.defaults = {
    dock.autohide = false;
    dock.mru-spaces = false;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    loginwindow.LoginwindowText = "Welcome to the hive";
    screencapture.location = "~/Pictures/screenshots";
    screensaver.askForPasswordDelay = 10;
};
}