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
    in {
      default = lib.makeOverridable ({
        palette ? {
          base00 = "#2E3440";
          base01 = "#3B4252";
          base02 = "#434C5E";
          base03 = "#4C566A";
          base04 = "#D8DEE9";
          base05 = "#E5E9F0";
          base06 = "#ECEFF4";
          base07 = "#8FBCBB";
          base08 = "#BF616A";
          base09 = "#D08770";
          base0A = "#EBCB8B";
          base0B = "#A3BE8C";
          base0C = "#88C0D0";
          base0D = "#81A1C1";
          base0E = "#B48EAD";
          base0F = "#5E81AC";
        },
        icons ? {
          package = pkgs.papirus-icon-theme;
          theme = "Papirus";
        },
        font ? {
          package = pkgs.nerd-fonts.jetbrains-mono;
          family = "JetBrainsMono Nerd Font Mono";
        },
      }: let
        sourceDir = lib.fileset.toSource {
          root = ./.;
          fileset = lib.fileset.unions [
            ./icons
            ./modules
            ./services
            ./styled
            ./shell.qml
          ];
        };

        configDir =
          pkgs.runCommand "configDir" {
            config = import ./Config.nix {
              inherit palette;

              paths = {
                sh = "sh";
                cat = "cat";
                echo = "echo";
                brightnessctl = "${lib.getExe pkgs.brightnessctl}";
              };

              fontFamily = font.family;
            };

            passAsFile = ["config"];
          } ''
            mkdir -p $out/
            cp $configPath $out/Config.qml
            cp -r ${sourceDir}/. $out/
          '';

        fontConfig = pkgs.writeText "fonts.conf" ''
          <?xml version='1.0'?>
          <!DOCTYPE fontconfig SYSTEM 'urn:fontconfig:fonts.dtd'>
          <fontconfig>
            <dir>${font.package}</dir>
            <cachedir>/var/cache/fontconfig</cachedir>
            <cachedir prefix="xdg">fontconfig</cachedir>
          </fontconfig>
        '';
      in
        pkgs.symlinkJoin {
          name = "quickshell";
          paths = [inputs.quickshell.packages.${system}.default];
          buildInputs = [pkgs.makeWrapper];
          postBuild = let
            set = "--set QS_ICON_THEME ${icons.theme} --prefix XDG_DATA_DIRS : ${icons.package}/share/ --set FONTCONFIG_FILE ${fontConfig}";
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
