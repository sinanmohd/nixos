{ pkgs, ... }:

let
  target = "/var/lib/archlinux";
  lock = "/var/lock/syncrepo.lck";
  bwlimit = 0;
  source_url = "rsync://mirror.guillaumea.fr/archlinux/";
  lastupdate_url = "https://mirror.guillaumea.fr/archlinux/";

  rsync_cmd = { src, dest, excludes ? [], extraArgs ? [] }@args:
    let
      cmd = pkgs.writeScript "rsync_cmd-${src}" ''
        rsync -rlptH --safe-links --delete-delay --delay-updates \
          --timeout=600 --contimeout=60 --no-motd \
          ${if pkgs.stty then "-h -v --progress" else "--quiet"} \
          ${if bwlimit > 0 then "--bwlimit=$bwlimit" else ""} \
          ${lib.concatMapStrings (s: " --exclude='${s}'") excludes} \
          ${src} ${dest} ${lib.concatMapStrings (s: " '${s}'") extraArgs}
      '';
    in
      pkgs.stdenv.mkDerivation {
        name = "rsync_cmd-${src}";
        buildInputs = [ pkgs.rsync pkgs.stty ];
        buildPhase = ''
          mkdir -p $out/bin
          cp ${cmd} $out/bin/rsync_cmd-${src}
          chmod +x $out/bin/rsync_cmd-${src}
        '';
      };

in
{
  environment.systemPackages = [ pkgs.coreutils ];

  rsync = rsync_cmd {
    src = source_url;
    dest = target;
    excludes = [ "*.links.tar.gz*" "/other" "/sources" ];
  };

  checkAndUpdateMirror = pkgs.writeScriptBin "checkAndUpdateMirror" ''
    if [[ ! -d "${target}" ]]; then
      mkdir -p "${target}"
    fi

    exec 9>"${lock}"
    flock -n 9 || exit

    # Cleanup any temporary files from old run
    find "${target}" -name '.~tmp~' -exec rm -r {} +

    if [[ ! -t 1 ]] && [[ -f "$target/lastupdate" ]] && diff -b <(curl -Ls "$lastupdate_url") "$target/lastupdate" >/dev/null; then
      ${rsync} --exclude='*.links.tar.gz*' --exclude='/other' --exclude='/sources' --exclude='/lastsync' "${source_url}/lastsync" "${target}/lastsync"
      exit 0
    fi

    ${rsync}
  '';
}
