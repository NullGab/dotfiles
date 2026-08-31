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
    xclip

    # Your custom automation script
    (pkgs.writeShellScriptBin "sys-update" ''
      # Navigate to the root of your dotfiles repository
      cd ~/dotfiles
      
      # Stage all changes (including Kitty and Neovim folders)
      git add .
      
      echo "Rebuilding NixOS..."
      # Run the rebuild command
      sudo nixos-rebuild switch --flake ./nixos#nixos
      
      # Check if the rebuild was successful
      if [ $? -eq 0 ]; then
        echo "Build successful! Committing and pushing..."
        # Auto-generate a commit message with the current timestamp
        git commit -m "Auto-update: $(date '+%Y-%m-%d %H:%M:%S')"
        git push
      else
        echo "Build failed. Git commit aborted to prevent broken states."
      fi
    '')
  ];
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/nvim";
  xdg.configFile."kitty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/kitty";
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark"; 
      package = pkgs.papirus-icon-theme.override { color = "red"; };
    };
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "agnoster"; 
      plugins = [
        "git"
          "sudo"
          "npm"
      ];
    };
  };

  # Optional: You can still add standard shell aliases here
  # shellAliases = {
  #   ll = "ls -l";
  #   update = "sudo nixos-rebuild switch --flake ~/dotfiles/#nixos";
  # };
}
