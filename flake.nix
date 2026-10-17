{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    forAllSystems = function:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
      ] (system: function system nixpkgs.legacyPackages.${system});
  in {
    packages = forAllSystems (system: pkgs: let
      lib = pkgs.lib;

      configDir = lib.fileset.toSource {
        root = ./.;
        fileset = lib.fileset.unions [
          ./icons
          ./modules
          ./services
          ./styled
          ./Config.qml
          ./shell.qml
        ];
      };
    in {
      default = lib.makeOverridable ({
        icons ? {
          package = pkgs.papirus-icon-theme;
          theme = "Papirus";
        },
      }:
        pkgs.symlinkJoin {
          name = "quickshell";
          paths = [inputs.quickshell.packages.${system}.default];
          buildInputs = [pkgs.makeWrapper];
          postBuild = let
            set = "--set QS_ICON_THEME ${icons.theme} --prefix XDG_DATA_DIRS : ${icons.package}/share/";
            flags = "--add-flags --path --add-flags ${configDir}";
          in ''
            wrapProgram $out/bin/quickshell ${set} ${flags}
            wrapProgram $out/bin/qs ${set} ${flags}
          '';

          meta = {
            mainProgram = "quickshell";
          };
        }) {};
    });
  };
}
