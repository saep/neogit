{
  description = "neogit";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        neogit-saep = pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "neogit-saep";
          version = "HEAD";
          src = ./.;
        };
      in rec { defaultPackage = neogit-saep; }) // {
        overlay = final: prev: {
          vimPlugins = prev.vimPlugins // {
            neogit-saep = self.defaultPackage.${prev.system};
          };
        };
      };
}
