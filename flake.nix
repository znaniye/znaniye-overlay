{
  description = "znaniye's nixpkgs overlay";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs =
    { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" ];
      forAllSys = nixpkgs.lib.genAttrs systems;
    in
    {
      overlays.default = import ./overlay.nix;
      packages = forAllSys (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system}.extend self.overlays.default;
        in
        {
          inherit (pkgs) SDL3;
        }
      );
    };
}
