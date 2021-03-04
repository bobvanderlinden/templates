{
  description = "A collection of flake templates";

  outputs = { self }: {

    templates = {

      trivial = {
        path = ./trivial;
        description = "A very basic flake";
      };

      simpleContainer = {
        path = ./simple-container;
        description = "A NixOS container running apache-httpd";
      };

      ruby = {
        path = ./ruby;
        description = "A flake for Ruby projects";
      };

      devShell = {
        path = ./dev-shell;
        description =
          "A devShell flake for cross-platform use of 'nix develop'";
      };

    };

    defaultTemplate = self.templates.trivial;

  };
}
