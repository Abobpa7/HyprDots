{ config, pkgs, unstablePkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  #---------------- BOOT ----------------#
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  #--------------- HOSTNAME --------------#
  networking.hostName = "nixos";

  #--------------- NETWORK ---------------#
  networking.networkmanager.enable = true;

  #--------------- TIMEZONE --------------#
  time.timeZone = "Europe/Chisinau";

  #---------------- LOCALE ---------------#
  i18n.defaultLocale = "ru_RU.UTF-8";

  #---------------- USER -----------------#
  users.users.botnaru = {
    isNormalUser = true;
    initialPassword = "1111";
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [ tree ];
    shell = unstablePkgs.fish;
  };

  #---------------- FONTS ----------------#
  fonts.packages = with pkgs; [
    fira-code
    noto-fonts
    font-awesome
    nerd-fonts.hack
  ];

  #-------------- SERVICES ---------------#
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.libinput.enable = true;
  services.openssh.enable = true;
  services.flatpak.enable = true;

  #------------ PROGRAMS -----------------#
  programs.hyprland = {
    enable = true;
    package = unstablePkgs.hyprland;
  };

  #------------ SYSTEM PACKAGES ----------#
  environment.systemPackages =
    (with pkgs; [
      git
      wget
      lolcat
    ]) ++
    (with unstablePkgs; [
      fish
      fastfetch
      neovim
      xdg-user-dirs
      brightnessctl
      cava
      papirus-icon-theme
      cmatrix
      kitty
      swaynotificationcenter
      rofi
      nwg-look
      waybar
      swww
      nautilus
      grim
      slurp
      wlogout
    ]);

  #------------ NIXPKGS CONFIG -----------#
  nixpkgs.config.allowUnfree = true;

  #------------- NIX EXP FEATURES -----------#
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  #------------- SYSTEM VERSION ----------#
  system.stateVersion = "25.05";
}
