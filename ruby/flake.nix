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
        mkRuby = nixpkgs-ruby.lib.mkRuby;
        pkgs = nixpkgs.legacyPackages.${system};
        rubyVersion = nixpkgs.lib.fileContents ./.ruby-version;
        ruby = mkRuby { inherit pkgs rubyVersion; };
        bundler = pkgs.bundler.override { inherit ruby; };
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            ruby.devEnv
            bundler
            pkgconfig
            libxml2
            libxslt
            libmysqlclient
            mysql.client
          ];
        };
      });
}
