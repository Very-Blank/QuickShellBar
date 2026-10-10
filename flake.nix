{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixnvim = {
      url = "github:Very-Blank/NixNvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nmux = {
      url = "github:Very-Blank/Nmux";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs {inherit system;};

      tmux = inputs.nmux.mkPackage {
        inherit system;

        extraModule = {...}: {
          config.nmux = {
            name = "QuickShell";
            shell = pkgs.lib.getExe pkgs.zsh;

            extraConfig = ''
              set-hook -g session-created 'send-keys "nvim" enter ; new-window ; send-keys "qs --path Bar.qml" enter; select-window -t 0'
            '';
          };
        };
      };
    in
      pkgs.mkShell {
        packages = [
          inputs.quickshell.packages.${system}.default
          (
            inputs.nixnvim.mkPackage {
              inherit system;

              extraModule = {lib, ...}: {
                config = {
                  vim = {
                    languages.qml = {
                      enable = true;
                      treesitter.enable = false;
                      lsp.enable = true;
                    };

                    syntaxHighlighting = lib.mkForce false;

                    treesitter.highlight.enable = lib.mkForce false;

                    lsp.servers.qmlls = {
                      init_options.provideFormatter = false;

                      # drop semantic tokens so the LSP can't color the buffer
                      on_attach = lib.generators.mkLuaInline ''
                        function(client, bufnr)
                          client.server_capabilities.semanticTokensProvider = nil
                        end
                      '';
                    };

                    local.indenting = [
                      {
                        tabstop = 4;
                        shiftwidth = 4;
                        expandtab = true;
                        pattern = ["qml"];
                      }
                    ];
                  };
                };
              };
            }
          )
        ];

        shellHook = ''
          exec ${pkgs.lib.getExe' tmux "tmux"}
        '';
      };
  };
}
