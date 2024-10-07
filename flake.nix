{
  description = "nenio: ctx's NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";

      # optionally choose not to download darwin deps (saves some resources on Linux)
      inputs.darwin.follows = "";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix.url = "github:musnix/musnix";

    nix-mineral = {
      url = "github:crypec/nix-mineral";
      flake = false;
    };

    nur.url = github:nix-community/NUR;
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixos-hardware,
    disko,
    nur,
    home-manager,
    agenix,
    stylix,
    alejandra,
    ...
  }: {
    nixosConfigurations = {
      date = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          agenix.nixosModules.default
          nixos-hardware.nixosModules.msi-b550-a-pro
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          inputs.musnix.nixosModules.musnix
          nur.nixosModules.nur

          ./hosts/date
          ./modules/mineral

          ./modules/virtualisation
          ./modules/yubikey

          ./modules/polkit

          ./users/simon.nix
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              extraSpecialArgs = {inherit inputs;};

              backupFileExtension = "hm.bk";
            };
          }
        ];
      };

      late = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          agenix.nixosModules.default
          nixos-hardware.nixosModules.msi-b550-a-pro
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          inputs.musnix.nixosModules.musnix
          nur.nixosModules.nur

          ./hosts/late
          ./modules/mineral
          ./modules/gui
          ./modules/virtualisation
          ./modules/stylix
          ./modules/yubikey

          ./modules/polkit

          ./users/simon.nix
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              extraSpecialArgs = {inherit inputs;};

              backupFileExtension = "hm.bk";
            };
          }
        ];
      };

      sate = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          disko.nixosModules.disko

          ./hosts/sate
          ./users/simon.nix

          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.simon = import ./home;
          }
        ];
      };
    };
  };
}
