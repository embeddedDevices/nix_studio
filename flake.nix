{
  description = "Studio-Setup: GNOME + Firefox + Zoom";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations = {

      # Host-Name bewusst anders als nixDennis/nixDell,
      # damit klar ist: das ist das Workshop-System.
      studio = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware_dell.nix  # Kopie deiner hardware_dell.nix
          ./configuration.nix
        ];
      };

    };
  };
}
