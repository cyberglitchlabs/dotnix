{ config, lib, pkgs, options, ... }:
with pkgs.stdenv;
with lib;
let
  # fzshInitExtraConfig = import ./zshInitExtraConfig.nix;
  # zshInitExtraConfig = fzshInitExtraConfig { lib = lib; pkgs = pkgs; };
  # fgetZshInitExtra = import ./getZshInitExtra.nix;
  # getZshInitExtra = fgetZshInitExtra { lib = lib; pkgs= pkgs; zshInitExtraConfig = zshInitExtraConfig; };
in {

  # enable zsh completion for system packages
  environment.pathsToLink = [ "/share/zsh" ];
  home-manager.users."${config.cfg.user.name}" = {
    home.stateVersion = config.cfg.os.version;

    programs.git = {
        enable = true;
        aliases = {
            pushall = "!git remote | xargs -L1 git push --all";
            graph = "log --decorate --oneline --graph";
            add-nowhitespace = "!git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -";
        };
        userName = config.cfg.user.name;
        userEmail = config.cfg.user.email;
        extraConfig = {
            feature.manyFiles = true;
            init.defaultBranch = "main";
            gpg.format = "ssh";
        };

        signing = {
            key = "~/.ssh/id_ed25519";
            signByDefault = builtins.stringLength "~/.ssh/id_ed25519" > 0;
        };

        lfs.enable = true;
        ignores = [ ".direnv" "result" ];
  };

    programs = {
      thefuck = {
        enable = true;
        enableZshIntegration = true;
      };
      jq.enable = true;
      dircolors = {
        enable = true;
        enableZshIntegration = true;
      };
      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
      fzf = {
        enable = true;
        enableZshIntegration = true;
      };
      k9s.enable = true;
      eza = {
        enable = true;
        enableZshIntegration = true;
        icons = true;
        git = true;
      };
      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
      };
      starship = {
        enable = true;
        enableZshIntegration = true;
      };
      nix-index = {
        enable = true;
        enableZshIntegration = true;
      };
      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
      neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
      };

    };
    home.packages = with pkgs; 
      (if config.cfg.os.name == "nixos" then [
        parted # filesystems
        nettools # networking
        openvpn # networking
        killall # processes
        lshw # system info
      ] else if config.cfg.os.name == "macos" then [
      ] else []) ++ [
        coreutils-full # generic

        argocd
        krew
        kubectl
        kubernetes-helm
        kustomize
        talosctl

        findutils # search
        ripgrep # search _ rust alt - find + grep # https://github.com/BurntSushi/ripgrep
        bat
        jq
      ];

  };

}