{
  description = "My nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    systems.url = "github:nix-systems/default-linux";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # darwin = {
    #   url = "github:lnl7/nix-darwin";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # Third party programs, packaged with nix
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    apple-silicon.url = "github:tpwrules/nixos-apple-silicon";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, home-manager, systems, ... } @inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs (import systems) (
        system:
          import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          }
      );
      mkNixos = modules: lib.nixosSystem {
        inherit modules;
        specialArgs = { inherit inputs outputs self; };
      };

      # mkDarwin = system: modules: inputs.darwin.lib.darwinSystem {
      #   inherit modules system;
      #   specialArgs = { inherit inputs outputs self; };
      # };

      mkHome = modules: pkgs: lib.homeManagerConfiguration {
        inherit modules pkgs;
        extraSpecialArgs = { inherit inputs outputs self; };
      };
    in {
      inherit lib;
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;
      overlays = import ./overlays {inherit inputs outputs;};
      packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
      devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
      formatter = forEachSystem (pkgs: pkgs.alejandra);

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        # 13" M2 Pro Macbook
        asahi = mkNixos [ ./hosts/asahi ];
      };

      # darwinConfigurations = {};

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "saiful@asahi" = mkHome [ ./home/saiful/asahi.nix ./home/saiful/nixpkgs.nix ] pkgsFor.aarch64-linux;
      };
    };
}
