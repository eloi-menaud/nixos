{ config, pkgs, lib, ... }:
let
  nurpkgs = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/main.tar.gz") { inherit pkgs; };
in
{
	imports = [
		./nvidia/conf.nix
	];

	  
    fonts.packages = [
      pkgs.terminus_font_ttf
      pkgs.terminus_font
      pkgs.spleen
      pkgs.tamzen
      pkgs.tamsyn
      pkgs.cozette
    ];
    fonts.fontconfig.localConf = ''
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
<fontconfig>
  <description>Accept bitmap fonts</description>
<!-- Accept bitmap fonts -->
 <selectfont>
  <acceptfont>
   <pattern>
     <patelt name="outline"><bool>false</bool></patelt>
   </pattern>
  </acceptfont>
 </selectfont>
</fontconfig>
  '';




	# ------- screencasting -------
	services.pipewire = {
	  enable = true;
	  audio.enable = true;
	  pulse.enable = true;
	  alsa.enable = true;
	  alsa.support32Bit = true;
	};

	xdg.portal = {
	  xdgOpenUsePortal = true;
	  enable = true;
	  extraPortals = [
	    pkgs.xdg-desktop-portal-gnome
	  ];
	};

	programs.niri.enable = true;
	# ----------------------------


	services.xserver.enable = false;
	services.displayManager.enable = false; 


	environment.systemPackages = [
                pkgs.kdePackages.dolphin
                pkgs.micro
		pkgs.file
pkgs.vdhcoapp
                pkgs.rust-analyzer
                pkgs.bat
		nurpkgs.repos.hexadecimalDinosaur.jetbrains-fleet
                pkgs.fzf
		pkgs.emacs
		pkgs.zed-editor		 
		pkgs.kitty
		pkgs.ranger

                pkgs.rofi

		pkgs.gradia
		
	    pkgs.xdg-desktop-portal-gnome
		 
		# niri
		pkgs.niri
		pkgs.xwayland-satellite
		pkgs.swaybg
								
		# utils
	    pkgs.dbus
		pkgs.nix-doc
		pkgs.jq
		pkgs.wget
		pkgs.dtrx
		pkgs.xclip
		pkgs.zip
		pkgs.k3s
		pkgs.pkg-config
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
		pkgs.rustup

		# desktop
		pkgs.firefox
		pkgs.signal-desktop
		pkgs.discord
		pkgs.jetbrains.rust-rover
		pkgs.jetbrains-toolbox
		pkgs.telegram-desktop
				
		# games
		pkgs.prismlauncher

        # other
		pkgs.whitesur-cursors

	];

	
	
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
