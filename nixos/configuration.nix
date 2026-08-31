# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

   networking.hostName = "nixos"; # Define your hostname.
	   nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
   time.timeZone = "America/Sao_Paulo";

# Enable Zsh system-wide
programs.zsh.enable = true;
nixpkgs.config.allowUnfree = true;

  # Enable the Steam module
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # Enable Flatpak and Flathub integration
  services.flatpak.enable = true;

  # Define your declarative Flatpaks
  services.flatpak.packages = [
    "com.obsproject.Studio"
    "org.vinegarhq.Sober"
  ];
  # Select internationalisation properties.
 i18n.defaultLocale = "en_US.UTF-8";
 console = {
   font = "Lat2-Terminus16";
   useXkbConfig = true; # use xkb.options in tty.
 };

 services.xserver = {
	 enable = true;
   displayManager.lightdm = {
     enable = true;
     background = ./yotsubato.jpeg; 
   };
	 desktopManager.cinnamon.enable = true;
 };

 # Moved libinput to top-level to fix deprecation warning
 services.libinput.enable = true;

 # Enable nix-ld so Mason can run pre-compiled LSP binaries
 programs.nix-ld.enable = true;

  # Configure keymap in X11
   services.xserver.xkb= {
   layout = "br,us";
   options = "grp:alt_shift_toggle";	
   };
   services.keyd = {
	   enable = true;
	   keyboards={
		   default = {
			   ids=["*"];
			   settings={
				   main = {
					   capslock = "esc";
					   esc = "capslock";
				   };
			   };
		   };
	   };
   };

   hardware.pulseaudio.enable = false;

security.rtkit.enable = true; # Required for PipeWire to request realtime scheduling
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true; # This allows PipeWire to act as the PulseAudio server
};

# Your main user block around line 82
users.users.gabriel = {
  isNormalUser = true;
  description = "Gabriel";
  extraGroups = [ "networkmanager" "wheel" ];
  shell = pkgs.zsh; # <-- Add this line here
  packages = with pkgs; [
    # your packages
  ];
};
   programs.firefox.enable = true;

 environment.systemPackages = with pkgs; [
   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
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
 ];


  system.stateVersion = "26.05"; # Did you read the comment?

}
