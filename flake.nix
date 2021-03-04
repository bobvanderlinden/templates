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
    };

    defaultTemplate = self.templates.trivial;

  };
}
