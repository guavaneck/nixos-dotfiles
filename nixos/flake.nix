{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
  };
  
  outputs = 
  { 
    self, 
    nixpkgs, 
    home-manager, 
    niri, 
    ... 
  }@inputs:
  {
    nixosConfigurations = {
      wyatt = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          niri.nixosModules.niri
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wyatt = import ./home.nix;
          }
        ];
      };
    };
  };
}
