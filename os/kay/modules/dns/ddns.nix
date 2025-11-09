{ pkgs, ... }:
{
  services.pppd.script."02-ddns-ipv6" = {
    type = "ipv6-up";
    runtimeInputs = with pkgs; [
      coreutils
      knot-dns
      iproute2
      gnugrep
    ];

    text = ''
      while ! ipv6="$(ip -6 addr show dev "$1" scope global | grep -o '[0-9a-f:]*::1337')"; do
         sleep 0.2
      done

      cat <<- EOF | knsupdate
              server  2001:470:ee65::1
              zone    sinanmohd.com.

              update  delete  sinanmohd.com.  AAAA
              update  add     sinanmohd.com.  180     AAAA    $ipv6

              send
      EOF
    '';
  };
}
