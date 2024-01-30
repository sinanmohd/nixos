{ pkgs,  ... }: {
   services.pppd.script = {
      "02-ddns-ipv4" = {
         runtimeInputs = with pkgs; [ coreutils knot-dns ];
         type = "ip-up";

         text = ''
            cat <<- EOF | knsupdate
                    server  2001:470:ee65::1
                    zone    sinanmohd.com.

                    update  delete  sinanmohd.com.  A
                    update  add     sinanmohd.com.  180     A       $4

                    send
            EOF
         '';
       };

      "02-ddns-ipv6" = {
         runtimeInputs = with pkgs; [ coreutils knot-dns iproute2 gnugrep ];
         type = "ipv6-up";

         text = ''
            ipv6="$(ip -6 addr show dev $1 scope global | grep -o '[0-9a-f:]*::1')"

            cat <<- EOF | knsupdate
                    server  2001:470:ee65::1
                    zone    sinanmohd.com.

                    update  delete  sinanmohd.com.  AAAA
                    update  add     sinanmohd.com.  180     AAAA    $ipv6

                    send
            EOF
         '';
       };
    };
}
