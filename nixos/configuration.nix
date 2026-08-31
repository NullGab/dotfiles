{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

# =========================================
# Boot & System
# =========================================
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05";

# =========================================
# Networking, Time & Locale
# =========================================
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; 
  };

# =========================================
# Desktop Environment & Display (X11)
# =========================================
  services.xserver = {
    enable = true;
    desktopManager.cinnamon.enable = true;
    videoDrivers = [ "amdgpu" ];
    displayManager.lightdm = {
      enable = true;
      background = ./yotsubato.jpeg; 
    };
    xkb = {
      layout = "br,us";
      options = "grp:alt_shift_toggle";    
    };
  };

# =========================================
# Hardware & Peripherals
# =========================================

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.libinput.enable = true; # Mouse & Touchpad support

    services.keyd = {
      enable = true;
      keyboards = {
        default = {
          ids = ["*"];
          settings = {
            main = {
              capslock = "esc";
              esc = "capslock";
            };
          };
        };
      };
    };


# =========================================
# Audio (PipeWire)
# =========================================
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true; 
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true; 
  };

# =========================================
# Software & Packages
# =========================================
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim 
      wget
      neovim
      kitty
      btop
      keepassxc
      git
      nodejs
      flatpak
      zsh
      oh-my-zsh
      heroic
      obsidian
      mysql-workbench
      postgresql
      python3
      spark
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
      nerd-fonts.meslo-lg
      nerd-fonts.caskaydia-cove
  ];

# =========================================
# Programs & Services Configs
# =========================================
  programs = {
    zsh.enable = true;
    firefox.enable = true;
    nix-ld.enable = true; # Run pre-compiled LSP binaries

      steam = {
        enable = true;
        remotePlay.openFirewall = true; 
        dedicatedServer.openFirewall = true; 
      };
  };

  services.flatpak = {
    enable = true;
    packages = [
      "com.obsproject.Studio"
        "org.vinegarhq.Sober"
    ];
  };

# =========================================
# Users
# =========================================
  users.users.gabriel = {
    isNormalUser = true;
    description = "Gabriel";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh; 
    packages = with pkgs; [];
  };
}
