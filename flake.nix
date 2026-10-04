{
  description = "NixyяOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Home manager module
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Noctalia V5
    noctalia = {
      url = "github:noctalia-dev/noctalia/cachix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # 3D fetch
    areofyl-fetch = {
      url = "github:areofyl/fetch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NVF
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Yazi
    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Zen browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Stylix
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #Happ
    happ-nixos = {
      url = "github:Rirdical/happ-nixos";
      flake = false;
    };
  };

  outputs = {
    self,
    stylix,
    nixpkgs,
    home-manager,
    nvf,
    happ-nixos,
    ...
  } @ inputs: let
    mkHost = {
      hostname,
      homehost,
      user,
      system,
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs;};

        modules = [
          ./hosts/${hostname}
          "${happ-nixos}/happ-module.nix"
          stylix.nixosModules.stylix
          ({pkgs, ...}: {
            environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.nvf];
          })
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "hm-back";
              overwriteBackup = true;
              extraSpecialArgs = {
                inherit inputs hostname;
              };
            };
            home-manager.users = {
              "${user}" = import homehost;
            };
          }
        ];
      };
  in {
    nixosConfigurations = {
      PC = mkHost {
        hostname = "rirdicalPC";
        homehost = ./home/hosts/rirdicalPC.nix;
        user = "rirdical";
        system = "x86_64-linux";
      };
      LT = mkHost {
        hostname = "rirdicalLT";
        homehost = ./home/hosts/rirdicalLT.nix;
        user = "rirdical";
        system = "x86_64-linux";
      };
      VR = mkHost {
        hostname = "rirdicalVR";
        homehost = ./home/hosts/rirdicalVR.nix;
        user = "rirdical";
        system = "aarch64-linux";
      };
    };
    packages."x86_64-linux".nvf =
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [./nvf.nix];
      }).neovim;
  };
}
