# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, home-manager, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix ./zfs.nix
    ];

  nix.settings.substituters = lib.mkBefore [ "https://mirror.sjtu.edu.cn/nix-channels/store" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager.users.root = {
    home.stateVersion = "18.09";
    home.file.".xinitrc".source = ./.xinitrc;
    home.file.".config/i3/config".source = ./config;
    home.file.".config/alacritty/alacritty.yml".source = ./alacritty.yml;
    home.file.".config/alacritty/dracula.yml".source = ./dracula.yml;
    home.file."Pictures/wallpaper.png".source = ./wallpaper.png;
    home.file.".config/helix/themes/mytheme.toml".source = ./mytheme.toml;
    home.file.".config/helix/config.toml".source = ./config.toml;
    home.file.".config/fish/config.fish".source = ./config.fish;
  };

  home-manager.users.wlxxs = {
    home.stateVersion = "18.09";
    home.file.".xinitrc".source = ./.xinitrc;
    home.file.".config/i3/config".source = ./config;
    home.file.".config/alacritty/alacritty.yml".source = ./alacritty.yml;
    home.file.".config/alacritty/dracula.yml".source = ./dracula.yml;
    home.file."Pictures/wallpaper.png".source = ./wallpaper.png;
    home.file.".config/helix/themes/mytheme.toml".source = ./mytheme.toml;
    home.file.".config/helix/config.toml".source = ./config.toml;
    home.file.".config/fish/config.fish".source = ./config.fish;
  };

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "zh_CN.UTF-8";
  fonts = {
    enableDefaultFonts = true;
    fontDir.enable = true;
    fonts = with pkgs; [
      sarasa-gothic
    ];
    fontconfig = {
      defaultFonts = {
        emoji = [ "Sarasa Gothic" ];
        serif = [ "Sarasa Gothic" ];
        sansSerif = [ "Sarasa Gothic" ];
        monospace = [ "Sarasa Gothic" ];
      };
    };
  };
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      rime
    ];
  };
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.xkbOptions = "caps:escape";
  services.xserver.windowManager.i3.enable = true;
  services.xserver.displayManager.startx.enable = true;

  # Configure keymap in X11
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.tapping = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wlxxs = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "vboxusers" ]; # Enable ‘sudo’ for the user.
  };
  virtualisation.virtualbox.host.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neofetch
    du-dust
    unar
    bat
    bottom
    fd
    gitui
    ripgrep
    sd
    tealdeer
    zoxide
    starship
    exa
    procs
    tokei
    duf
    maim
    obs-studio
    brightnessctl
    helix
    rnix-lsp
    texlive.combined.scheme-full
    texlab
    abduco
    dvtm
    fish
    alacritty
    picom
    git
    feh
    pass
    zathura
    mpv
    qutebrowser
  ];
  
  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [ fish ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
  
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}

