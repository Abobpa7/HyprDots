{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # --- Bootloader ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # --- Unstable channel (rolling setup) ---
  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (final: prev: {
      unstable = import <nixos-unstable> {
        config.allowUnfree = true;
      };
    })
  ];

  # --- Programs ---
  programs.hyprland.enable = true;
  programs.fish.enable = true;

  # --- Services ---
  services = {
    flatpak.enable = true;
    libinput.enable = true;
    openssh.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  # --- Network ---
  networking = {
    hostName = "nixos-third-almost-done";
    networkmanager.enable = true;
  };

  # --- Time & Locale ---
  time.timeZone = "Europe/Chisinau";
  i18n.defaultLocale = "ru_RU.UTF-8";

  # --- User ---
  users.users.botnaru = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  # --- System packages (всё rolling!) ---
  environment.systemPackages =
    with pkgs.unstable; [
      neovim
      wget
      git
      kitty
      swaynotificationcenter
      waybar
      brightnessctl
      rofi
      flatpak
      fastfetch
      cava
      cmatrix
      xdg-user-dirs
      nautilus
      nwg-look
      unzip
      papirus-icon-theme
      hyprlock
      hyprland
    ];

  # --- Fonts ---
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-emoji
      jetbrains-mono
      font-awesome
      nerd-fonts.hack
      nerd-fonts.jetbrains-mono
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];
        emoji = [ "Noto Color Emoji" ];
        sansSerif = [ "Noto Sans" ];
        serif = [ "Noto Serif" ];
      };
    };
  };

  # --- System ---
  system.stateVersion = "25.05";
}
