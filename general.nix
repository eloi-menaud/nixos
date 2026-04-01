{ config, pkgs, lib, ... }:
let
  nurpkgs = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/main.tar.gz") { inherit pkgs; };
in
{
	imports = [
		./nvidia/conf.nix
	];

  services.xserver.enable = false;
	programs.niri.enable = true;



  # screen casting
	xdg.portal = {
	  xdgOpenUsePortal = true;
	  enable = true;
	  extraPortals = [
      pkgs.xdg-desktop-portal-gtk
	    pkgs.xdg-desktop-portal-gnome
	  ];
	};

  programs.dconf.enable = true;

  services.gvfs.enable = true;
  services.udisks2.enable = true;

	environment.systemPackages = [

    pkgs.emacs

    pkgs.kubernetes-helm
        
    pkgs.gnome-icon-theme
    pkgs.nautilus
    pkgs.unzip
        
    # screen casting		
    pkgs.xdg-desktop-portal-gnome
		 
		# niri
		pkgs.niri
		pkgs.xwayland-satellite
		pkgs.swaybg
    pkgs.whitesur-icon-theme
								
		# utils
    pkgs.mkosi
    pkgs.bat
		pkgs.ranger
    pkgs.micro
    pkgs.fzf
		pkgs.file
    pkgs.dbus
		pkgs.nix-doc
		pkgs.jq
		pkgs.wget
		pkgs.dtrx
		pkgs.xclip
		pkgs.zip
		pkgs.k3s
		pkgs.pkg-config
		pkgs.openssl
		pkgs.tree
		pkgs.gettext
		pkgs.greetd.tuigreet
    pkgs.wl-clipboard
		pkgs.wireplumber
		pkgs.podman
		pkgs.bc
		pkgs.pipewire
		pkgs.cudatoolkit
		pkgs.ffmpeg_6
		pkgs.pavucontrol
    pkgs.rofi
											
		# terminal
		pkgs.zsh
		pkgs.micro
		pkgs.alacritty

		# system overview
		pkgs.sysstat
		pkgs.lm_sensors		

		# python
		pkgs.python3
		pkgs.python3Packages.pip

		# openssl
		pkgs.openssl
		pkgs.openssl.dev
				
		# gpg
		pkgs.gnupg
		pkgs.pinentry-curses
		    		
		# git
		pkgs.git
		pkgs.mob
		
		# c
		pkgs.gcc
		pkgs.cmake
		
		# rust
    pkgs.rust-analyzer
		pkgs.rustup

		# desktop
    pkgs.kdePackages.dolphin
		# pkgs.firefox
		pkgs.firefox-devedition
		pkgs.signal-desktop
		pkgs.discord
		pkgs.jetbrains.rust-rover
		pkgs.jetbrains-toolbox
		pkgs.telegram-desktop
		pkgs.zed-editor		 
		pkgs.kitty
		pkgs.freecad
  	pkgs.bambu-studio

		# games
		pkgs.prismlauncher

    # other
		pkgs.whitesur-cursors

	];


  # niri
	#services.xserver.enable = false;
	#services.displayManager.enable = false; 

	# screencasting
	services.pipewire = {
	  enable = true;
	  audio.enable = true;
	  pulse.enable = true;
	  alsa.enable = true;
	  alsa.support32Bit = true;
	};



	nixpkgs.config.allowUnfree = true;
	# steam
 	programs.steam.enable = true;

	#build-home
	systemd.services.build-home-postinstall = {
	  description = "Building HOME post-install";
	  wantedBy = [ "multi-user.target" ];
	  serviceConfig = {
	    ExecStart = "/etc/nixos/build-home.sh";
	    Type = "oneshot";
	    RemainAfterExit = false;
	    User = "root";
	  };
	};


	# zsh
	programs.zsh.enable = true;



	# container	
	virtualisation.containers.enable = true;
	virtualisation = {
	  podman = { enable = true; };
	};


	# gnup
	programs.gnupg.agent = {
	   enable = true;
	   pinentryPackage = pkgs.pinentry-curses;
	   enableSSHSupport = true;
	};


	# git
	programs.git = {
		enable = true;
		config = {
			user.name  = "Eloi Menaud";
			user.email = "eloimenaud@proton.me";
			credential.helper = "store";
		};
	};

}












