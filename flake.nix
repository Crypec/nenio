{
  description = "nenio: ctx's NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # home-manager.url = "github:nix-community/home-manager";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";

      # optionally choose not to download darwin deps (saves some resources on Linux)
      inputs.darwin.follows = "";
    };

  };

  outputs =
    inputs@{
      nixpkgs,
      nixos-hardware,
      home-manager,
      agenix,
      stylix,
      ...
    }:
    {
      nixosConfigurations = {
        date = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/date
            ./modules/gui
            ./modules/stylix

            agenix.nixosModules.default
            nixos-hardware.nixosModules.msi-b550-a-pro
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            {

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = inputs;
              home-manager.users.simon = import ./home;

              home-manager.backupFileExtension = "hm.bk";
            }
          ];
        };
        late = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/date
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = inputs;
              home-manager.users.simon = import ./home;

            }
          ];
        };
        dune = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/dune
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = inputs;
              home-manager.users.simon = import ./home;
            }
          ];
        };
      };
    };
}
