{ config, pkgs, ... }:

{
  home.username = "gabriel";
  home.homeDirectory = "/home/gabriel";

  home.stateVersion = "24.05"; 

  home.packages = with pkgs; [
    htop
    ripgrep
    unzip
    gcc
    gnumake
    curl
    discord
    xclip
    jre
    (writeShellScriptBin "dictate" ''
     PID_FILE="/tmp/dictation.pid"
     AUDIO_FILE="/tmp/dictation.wav"
     MODEL_PATH="$HOME/models/ggml-large-v3-turbo.bin"

     if [ -f "$PID_FILE" ]; then
     kill -9 $(cat "$PID_FILE")
     rm "$PID_FILE"

     ${pkgs.libnotify}/bin/notify-send -t 2000 "Dictation" "Processing Turbo model..."

     TEXT=$(${pkgs.whisper-cpp}/bin/whisper-cpp -m "$MODEL_PATH" -f "$AUDIO_FILE" -nt 2>/dev/null | sed 's/^[ \t]*//' | tr -d '\n')

     if [ -n "$TEXT" ]; then
     ${pkgs.dotool}/bin/xdotool "$TEXT "
     ${pkgs.libnotify}/bin/notify-send -t 2000 "Dictation" "Text inserted!"
     else
     ${pkgs.libnotify}/bin/notify-send -t 2000 "Dictation" "No speech detected."
     fi
     else
     ${pkgs.libnotify}/bin/notify-send -t 2000 "Dictation" "Recording... Press hotkey again to stop."
       ${pkgs.alsa-utils}/bin/arecord -f S16_LE -c 1 -r 16000 "$AUDIO_FILE" &
       echo $! > "$PID_FILE"
       fi
       '')


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

  
  xdg.desktopEntries.vosviewer = {
    name = "VOSviewer";
    genericName = "Bibliometric Network Viewer";
    exec = "java -jar /home/gabriel/VOSviewer/VOSviewer.jar";
    terminal = false;
    categories = [ "Science" "Education" ];
  };
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
      plugins = [
        "git"
          "sudo"
          "npm"
      ];
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # Optional: You can still add standard shell aliases here
  # shellAliases = {
  #   ll = "ls -l";
  #   update = "sudo nixos-rebuild switch --flake ~/dotfiles/#nixos";
  # };
}
