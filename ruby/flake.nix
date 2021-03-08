{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-20.09";
    nixpkgs-ruby.url = "github:bobvanderlinden/nixpkgs-ruby";
    nixpkgs-ruby.inputs.nixpkgs.follows = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixpkgs-ruby, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        rubyVersion = nixpkgs.lib.fileContents ./.ruby-version;
        ruby = nixpkgs-ruby.lib.mkRuby { inherit pkgs rubyVersion; };

        gems = pkgs.bundlerEnv {
          name = "gemset";
          inherit ruby;
          gemfile = ./Gemfile;
          lockfile = ./Gemfile.lock;
          gemset = ./gemset.nix;
          groups = [ "default" "production" "development" "test" ];
        };
      in {
        devShell = with pkgs;
          mkShell {
            buildInputs = [
              # gems
              ruby
              bundix
            ];
          };
      });
}
