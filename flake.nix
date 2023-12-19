{
  description = "ivrit";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    devshell.url = "github:numtide/devshell";
    pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    devshell,
    pre-commit-hooks-nix,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-darwin"];
      imports = [
        pre-commit-hooks-nix.flakeModule
        devshell.flakeModule
      ];
      flake = {};
      perSystem = {
        config,
        pkgs,
        ...
      }: {
        pre-commit = {
          settings = {
            hooks = {
              treefmt = {
                enable = true;
              };
            };
            settings = {
              treefmt = {
                package = pkgs.writeShellApplication {
                  name = "treefmt";
                  runtimeInputs = with pkgs; [
                    treefmt
                    alejandra
                    swift-format
                  ];
                  text = ''
                    exec treefmt "$@"
                  '';
                };
              };
            };
          };
        };

        devshells.default = {
          name = "ivrit";
          env = [];
          devshell.startup.pre-commit-hooks.text = ''
            ${config.pre-commit.installationScript}
          '';
          packages = with pkgs; [
            treefmt
            alejandra
            swift-format
          ];
        };
      };
    };
}
