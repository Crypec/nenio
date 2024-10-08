{
  pkgs,
  nur,
  ...
}: {
  imports = [];

  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        # extensions = with config.nur.repos.rycee.firefox-addons; [
        #   ublock-origin
        #   bitwarden
        #   darkreader
        #   vimium
        # ];

        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          "browser.startup.homepage" = "https://sx.ctx.dev";
          "browser.search.defaultenginename" = "Search";
          "browser.search.order.1" = "Search";
        };
        search = {
          force = true;
          default = "Google";
          order = [
            "Google"
            "Searx"
          ];
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://sx.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };
            "NixOS Wiki" = {
              urls = [{template = "https://nixos.wiki/index.php?search={searchTerms}";}];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@nw"];
            };
            "Searx" = {
              urls = [{template = "https://searx.ctx.dev/?q={searchTerms}";}];
              iconUpdateURL = "https://nixos.wiki/favicon.png";
              updateInterval = 24 * 60 * 60 * 1000; # every day
              definedAliases = ["@searx"];
            };
            "Bing".metaData.hidden = true;
            "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias
          };
        };
        # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        #   ublock-origin
        #   bitwarden
        #   darkreader
        #   vimium
        # ];
      };
    };
  };
}
