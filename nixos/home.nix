{ config, pkgs, ... }:

{
  home.username = "gabriel";
  home.homeDirectory = "/home/gabriel";

  # This should generally match your NixOS version
  home.stateVersion = "24.05"; 

  # Install user-level packages (like your IEM audio tools or Neovim dependencies)
  home.packages = with pkgs; [
    htop
    ripgrep
    unzip
    gcc
    gnumake
    curl
    discord
  ];
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
  xdg.configFile."kitty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/kitty";

  # Let Home Manager manage itself
  programs.home-manager.enable = true;
  programs.zsh = {
  enable = true;
  enableCompletion = true;
  syntaxHighlighting.enable = true;

  oh-my-zsh = {
    enable = true;
    theme = "robbyrussell"; # Or "agnoster", "bira", etc.
    plugins = [
      "git"
      "sudo"
      "npm"
    ];
  };

  # Optional: You can still add standard shell aliases here
  # shellAliases = {
  #   ll = "ls -l";
  #   update = "sudo nixos-rebuild switch --flake ~/dotfiles/#nixos";
  # };
};
}
