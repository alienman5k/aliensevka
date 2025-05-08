{
  description = "A basic flake with tools for scripting development (Shell, Python, etc.)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    # flake-utils for cross-platform support
    flake-utils.url = "github:numtide/flake-utils";
    iosevka = {
      url = "github:be5invis/iosevka";
      ref = "v33.2.2";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells = with pkgs; {
          default = mkShell {
            # List of packages to use
            buildInputs = [
              nodejs
              # importNpmLock.hooks.linkNodeModulesHook
              ttfautohint-nox
            ];

            # npmDeps = importNpmLock.buildNodeModules {
            #   npmRoot = ./.;
            #   inherit nodejs;
            # };
            # Hook to start Zsh instead of Bash
            shellHook = ''
              echo 'Starting Nix Shell for NodeJS Development'
            '';
          };
        };

        packages = with pkgs; {
          default = buildNpmPackage {
            pname = "aliensevka";
            version = "0.0.1";
            src = ./.;

            npmDeps = importNpmLock {
              npmRoot = ./.;
            };

            npmConfigHook = importNpmLock.npmConfigHook;
          };
        };
      }
    );
}
