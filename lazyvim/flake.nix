{
  description = "Flake for Lazyvim with all tools I need";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux"; 
      pkgs = import nixpkgs { inherit system; };

      dependency = [
          pkgs.neovim
          pkgs.cargo
          pkgs.git
	        pkgs.lazygit
	        pkgs.gcc
	        pkgs.curl
	        pkgs.kitty
          pkgs.luarocks
          pkgs.lua5_1
          pkgs.go
          pkgs.miktex
          pkgs.kitty
          pkgs.rustc
          pkgs.rust-analyzer
          pkgs.nodejs_22
          pkgs.vimPlugins.nvim-dap
      ];
    in
    {
      packages.${system}.default = pkgs.buildEnv {
	name = "lazy-vim setup";
	paths = dependency;
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = dependency;
        shellHook = ''
          echo "Willkommen in deiner reproduzierbaren Umgebung!"
          git --version
        '';
      };
    };
}
