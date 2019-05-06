# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
 # boot.loader.systemd-boot.enable = true;
 # boot.loader.efi.canTouchEfiVariables = true;
 # boot.loader.grub.useOSProber = true;

  # - lsblk
  # - blkid
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      # assuming /boot is the mount point of the  EFI partition in NixOS (as the installation section recommends).
      efiSysMountPoint = "/boot";
    };
    grub = {
      # despite what the configuration.nix manpage seems to indicate,
      # as of release 17.09, setting device to "nodev" will still call
      # `grub-install` if efiSupport is true
      # (the devices list is not used by the EFI grub install,
      # but must be set to some value in order to pass an assert in grub.nix)
      devices = [ "nodev" ];
      efiSupport = true;
      enable = true;
      # set $FS_UUID to the UUID of the EFI partition
      extraEntries = ''
        menuentry "Windows" {
          insmod part_gpt
          insmod fat
          insmod search_fs_uuid
          insmod chain
          search --no-floppy --fs-uuid --set=root 46D6-BC87
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
      '';
      version = 2;
    };
  };

  networking.hostName = "jiest"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Quick guide to getting on wifi:
  # 1. Setting - networking.networkmanager.enable = true
  # 2. Make sure it's running - systemctl start network-manager
  # 3. Scan for access points - nmcli device wifi rescan / nmcli divice wifi list(nmcli radio/nmcli device)
  # 4. Connect - nmcli device wifi connect SSID-name password wireless-password
  # ----
  # cat > /etc/wpa_supplicant.conf
  # network={
  # ssid="****"
  # psk="****"
  # }
  # ^D
  # systemctl start wpa_supplicant  
  # ----
  
  nixpkgs.config.allowUnfree = true;
  #services.xserver.videoDrivers = [ "nvidia" ];
  hardware.bumblebee.enable = true;
  #hardware.nvidiaOptimus.disable = true;
  #hardware.opengl.extraPackages = [ pkgs.linuxPackages.nvidia_x11.out ];
  #hardware.opengl.extraPackages32 = [ pkgs.linuxPackages.nvidia_x11.lib32 ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   wget vim
  # ];
  environment.systemPackages = with pkgs; [
    vim htop firefox terminator pcmanfm nitrogen vlc unzip volumeicon git openjdk11 scala jetbrains.idea-community rustc rustup rustfmt 
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  # hardware.pulseaudio.enable = true;
  # - alsactl restore

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  #services.xserver.layout = "us,ru";
  # services.xserver.xkbOptions = "eurosign:e";
  #services.xserver.xkbOptions = "grp:alt_shift_toggle,grp_led:caps,terminate:ctrl_alt_bksp";		

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  # };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
	#fonts.fonts = with pkgs; [
	#	noto-fonts
	#	noto-fonts-cjk
	#	noto-fonts-emoji
	#];
	#
	#
	#nixpkgs.config.packageOverrides = super: {
	#	plasma5 = super.plasma5.override { 
	#		packageOverrides = plasma5-self: plasma5-super: {
	#			plasma-desktop = null;
	#			plasma-workspace = null;
	#			plasma-workspace-wallpapers = null;
	#		};
	#	};
	#};
	#environment.systemPackages = [ pkgs.htop pkgs.firefox pkgs.vim pkgs.terminator pkgs.nitrogen pkgs.wmctrl pkgs.pcmanfm ];
	environment.pathsToLink = ["/libexec"];
	services.xserver = {
		enable = true;
  		libinput.enable = true;
		layout = "us,ru";
		xkbOptions = "grp:alt_shift_toggle,grp_led:caps,terminate:ctrl_alt_bksp";		

		#displayManager.sddm.enable = true;
  		#desktopManager.plasma5.enable = true;
		displayManager.gdm.enable = true;
  		#desktopManager.gnome3.enable = true;
		#desktopManager = {
		#	default = "xfce";
		#	xterm.enable = false;
		#	xfce = {
		#		enable = true;
		#		noDesktop = true;
		#		enableXfwm = false;
		#	};
		#};
		#desktopManager = {
		#	default = "gnome3";
		#	gnome3 = {
		#		enable = true;
		#	};
		#};

		windowManager.i3 = {
			enable = true;
			package = pkgs.i3-gaps;
			extraPackages = with pkgs; [ 
				dmenu 
				i3status 
				i3lock 
				i3blocks
			];
		};
	};
	#stdenv.mkDerivation rec {
	#	name = "i3status";
	#	installPhase = ''
	#		cp ~/home/kozinaki/i3status.conf $out/etc/
	#	'';
	#};

}
