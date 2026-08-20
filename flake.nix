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
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nvf,
    ...
  } @ inputs: 
  let
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

          # Home manager
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
    homeConfigurations = {
      rirdicalPC = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [
          ./home/hosts/rirdicalPC.nix
        ];
      };
    };
  };
}
