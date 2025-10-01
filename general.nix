{ config, pkgs, ... }: {
	imports = [
		./nvidia/conf.nix
	];


	environment.systemPackages = [
				
		# utils
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
		pkgs.wireplumber
		pkgs.wl-clipboard
		pkgs.podman
		pkgs.bc
		pkgs.pipewire
		pkgs.cudatoolkit

											
		# niri
		pkgs.niri
		pkgs.xwayland-satellite
		pkgs.swaybg
		
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

		# games
		pkgs.prismlauncher

        # other
		pkgs.whitesur-cursors
	];

	
	
 	programs.steam.enable = true;

	system.activationScripts.monscript = {
	  text = ''
	    /etc/nixos/build-home.sh > /tmp/activation-log.sh 2>&1;
	  '';
	};

	# build-home
	# systemd.services.build-home-postinstall = {
	#   description = "Building HOME post-install";
	#   wantedBy = [ "multi-user.target" ];
	#   serviceConfig = {
	#     ExecStart = "/etc/nixos/build-home.sh";
	#     Type = "oneshot";
	#     RemainAfterExit = true;
	#     User = "root";
	#   };
	# };


	# niri
	# services.xserver.enable = false;
	# services.displayManager.enable = false;

	# zsh
	programs.zsh.enable = true;

	
	# fonts
	fonts = {
		enableDefaultPackages = true;
		packages = [
			pkgs.terminus_font_ttf
			pkgs.terminus_font
			pkgs.roboto
			pkgs.spleen
			pkgs.nerd-fonts._0xproto
		];
	};


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
	

	# audio
	# security.rtkit.enable = true;
	# hardware.pulseaudio.enable = false;
	#services.pipewire = {
	#  alsa = {
	#	  enable = true;
	#	  support32Bit = true;
	#  };
	#    audio.enable = true;
	#    pulse.enable = true;
	#};
  	#services.pipewire.wireplumber.enable = true;


}






