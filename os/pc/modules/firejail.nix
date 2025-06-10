{ pkgs, lib, ... }:
{
  programs.firejail = {
    enable = true;

    wrappedBinaries.spotify = {
      executable = lib.getExe pkgs.spotify;
      profile = "${pkgs.firejail}/etc/firejail/spotify.profile";
    };
  };
}
