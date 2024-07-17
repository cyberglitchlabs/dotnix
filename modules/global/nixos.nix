{ config, lib, pkgs, ... }: {
  cfg.os.name = "nixos";
  boot.tmp.cleanOnBoot = true;
  boot.tmp.useTmpfs = true;
  i18n.defaultLocale = config.cfg.localization.lang;
  # location.latitude = config.cfg.localization.latitude;
  # location.longitude = config.cfg.localization.longitude;
  security.allowUserNamespaces = true;
  system.stateVersion = config.cfg.os.version;
  users.mutableUsers = true;

  home-manager.users."${config.cfg.user.name}" = {
    home.sessionPath = [ 
      "/usr/local/bin"
    ];
  };

}