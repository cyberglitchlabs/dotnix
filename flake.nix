{
  description = "nix-configurations";

  inputs = {
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
};

outputs = { self, nixpkgs, nix-darwin, home-manager, ... }@inputs: 
  let 
    globalModules = [ 
      { 
        system.configurationRevision = self.rev or self.dirtyRev or null; 
      }
      ./modules/global/global.nix 
    ];
    globalModulesNixos = globalModules ++ [ 
      ./modules/global/nixos.nix
      home-manager.nixosModules.default
    ];
    globalModulesMacos = globalModules ++ [ 
      ./modules/global/macos.nix
      home-manager.darwinModules.default
    ];
  in
  {
    nixosConfigurations = {
      snowshuriken = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = globalModulesNixos
          ++ [ ./hosts/snowshuriken/configuration.nix ];
      };
    };
    darwinConfigurations = {
      macmeh = nix-darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = globalModulesMacos
          ++ [ ./hosts/macmeh/configuration.nix ];
      };
      silicontundra = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = globalModulesMacos
          ++ [ ./hosts/silicontundra/configuration.nix ];
      };
    };
  };
}