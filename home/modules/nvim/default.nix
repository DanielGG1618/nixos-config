{ pkgs, ... }: {
  imports = [./plugins.nix];

  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = /*lua*/''
      ${builtins.readFile ./lua/set.lua}
      ${builtins.readFile ./lua/remap.lua}
      ${builtins.readFile ./lua/autocommands.lua}
    '';

    extraConfig = /*vim*/''
      set tabstop=2
      set softtabstop=2
      set shiftwidth=2
      set expandtab
      set smartindent

      set termguicolors
    '';

    defaultEditor = true;
  };

  home.packages = with pkgs; [
    ripgrep

    lua-language-server
    nixd
    rust-analyzer
    pyright
    omnisharp-roslyn
    clang-tools
    haskell-language-server
  ];
}
