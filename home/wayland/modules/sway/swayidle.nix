{ config, lib, pkgs, ... }: let
  swaylock = lib.getExe config.programs.swaylock.package;
  brightnessctl = lib.getExe pkgs.brightnessctl;
  swaymsg = "${pkgs.sway}/bin/swaymsg";
in {
  services.swayidle = {
    enable = true;
    systemdTarget = "sway-session.target";

    timeouts = [
      {
	timeout = 250;
	command =
	  "${brightnessctl} --save; "
	  + "${brightnessctl} set 10%-";
	resumeCommand = "${brightnessctl} --restore";
      }

      {
	timeout = 300;
	command = swaylock;
      }

      {
	timeout = 600;
	command =
	  "${swaymsg} --type command 'output * dpms off'; "
	  + "${brightnessctl} -c leds -d platform::kbd_backlight --save; "
	  + "${brightnessctl} -c leds -d platform::kbd_backlight set 0";
	resumeCommand =
	  "${brightnessctl} -c leds -d platform::kbd_backlight --restore; "
	  + "${swaymsg} --type command 'output * dpms on'";
      }
    ];
  };
}
