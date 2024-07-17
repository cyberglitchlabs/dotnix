{ config, lib, pkgs, ... }: 
with lib;
{
  imports = [ ./options.nix ];
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 10d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = "nix-command flakes";
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  environment.variables.LANG = config.cfg.localization.lang;
  networking.hostName = config.cfg.os.hostname;
  nixpkgs.config.allowUnfree = true;

  nix.settings.trusted-users = [ config.cfg.user.name ];

  users.users."${config.cfg.user.name}" = (mkMerge [
    (if config.cfg.os.name == "nixos" then {
      createHome = true;
      extraGroups = [ 
        "wheel"
        "video"
        "audio"
      ] ++ ifTheyExist [
        "network"
        "wireshark"
        "i2c"
        "mysql"
        "docker"
        "podman"
        "git"
        "libvirtd"
        "deluge"
      ];
      group = config.cfg.user.name;
      home = "/home/${config.cfg.user.name}";
      isNormalUser = true;
    } else {})
    ( if config.cfg.os.name == "macos" then {
      home = "/Users/${config.cfg.user.name}";
    } else {})
    ({
      name = config.cfg.user.name;
      shell = pkgs.zsh;
    })
  ]);

  home-manager.users."${config.cfg.user.name}" = {

    home.shellAliases = {
      "wtf" = "thefuck";
    };

    home.sessionPath = [ 
      "$HOME/bin"
      "$HOME/.local/bin"
    ];
  };

}