{ pkgs, lib, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    syntaxHighlighting.enable = true;

    initExtraFirst = ''
      eval "$(${lib.getExe pkgs.direnv} hook zsh)"
      ${lib.getExe pkgs.fastfetch} --config examples/13 --logo none
    '';

    shellAliases = {
      hms = "home-manager switch --flake /home/daniel/nix";
      hmnews = "home-manager news --flake /home/daniel/nix";
      rb = "sudo nixos-rebuild switch --flake /home/daniel/nix";

      ls = "${lib.getExe pkgs.eza} --icons --group-directories-first";
      tree = "${lib.getExe pkgs.eza} --color=auto --icons --tree";
      grep = "grep --color=auto";
      ":q" = "exit";
      v = "nvim";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
      ];
      theme = "norm";
    };
  };
}
