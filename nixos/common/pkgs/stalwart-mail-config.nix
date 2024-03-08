{ lib,
  stdenvNoCC,
  fetchzip,
  stalwart-mail,
}:

stdenvNoCC.mkDerivation {
  pname = stalwart-mail.pname + "-config";
  version = stalwart-mail.version;

  src = let 
    rev = stalwart-mail.src.rev;
    owner = stalwart-mail.src.owner;
    repo = stalwart-mail.src.repo;
  in fetchzip {
    url = "https://github.com/${owner}/${repo}/raw/${rev}/resources/config.zip";
    # gives us a chance to manually verify config changes, if not use
    # stalwart-mail.src
    hash = "sha256-ji7+f3BGzVEb9gp5BXCStPR4/Umy93OTMA+DhYI/azk=";
  };

  outputs = [ "out" ];
  patchPhase = ''
    # TODO: remove me
    # toml spec violation, author said this will be fixed on the next realase
    sed -e 's/\[storage.fts\]//g' -e 's/default-language = "en"//g' \
        -i ./common/store.toml

    # outliers as of 0.6.0
    # smtp/signature.toml:#public-key = "file://%{BASE_PATH}%/etc/dkim/%{DEFAULT_DOMAIN}%.cert"
    # smtp/signature.toml:private-key = "file://%{BASE_PATH}%/etc/dkim/%{DEFAULT_DOMAIN}%.key"
    # common/tls.toml:cache = "%{BASE_PATH}%/etc/acme"
    find -type f \
        -name '*.toml' \
        -exec sed 's=%{BASE_PATH}%/etc=${placeholder "out"}=g' -i {} \;
  '';
  installPhase = "cp -r ./ $out";

  meta = stalwart-mail.meta // {
    description = "Configs for" + stalwart-mail.meta.description;
    maintainers = with lib.maintainers; [ sinanmohd ];
  };
}
