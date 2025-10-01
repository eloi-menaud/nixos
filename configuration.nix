{ config, pkgs, ... }:

{
	imports =
	[
	    ./hardware-configuration.nix
	    ./general.nix
	];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	 
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	networking.hostName = "nixos-eloi";
	networking.networkmanager.enable = true;
	networking.firewall = {
	  enable = true;
	  allowedTCPPorts = [ 8000 ];
	};

	
	time.timeZone = "Europe/Paris";
	i18n.defaultLocale = "en_US.UTF-8";
	i18n.extraLocaleSettings = {
		LC_ADDRESS = "fr_FR.UTF-8";
		LC_IDENTIFICATION = "fr_FR.UTF-8";
		LC_MEASUREMENT = "fr_FR.UTF-8";
		LC_MONETARY = "fr_FR.UTF-8";
		LC_NAME = "fr_FR.UTF-8";
		LC_NUMERIC = "fr_FR.UTF-8";
		LC_PAPER = "fr_FR.UTF-8";
		LC_TELEPHONE = "fr_FR.UTF-8";
		LC_TIME = "fr_FR.UTF-8";
	};


	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};


	# users
	users.users.eloi = {
		isNormalUser = true;
		description = "eloi menaud";
		extraGroups = [ "networkmanager" "wheel" "podman" ];
		packages = with pkgs; [];
		shell = pkgs.zsh; 
	};


	# package
	environment.localBinInPath = true;
	nixpkgs.config.allowUnfree = true;
	environment.systemPackages = [];

	# secu
	security.polkit.enable=true; 
	security.sudo.enable = true;
	security.wrappers.sudo.source = "${pkgs.sudo}/bin/sudo";
	security.wrappers.sudo.owner = "root";
	security.wrappers.sudo.setuid = true;
}
