{ stdenv, fetchFromGitHub, pam }:

stdenv.mkDerivation rec {
  pname = "pam_rundir";
  version = "186";

  src = fetchFromGitHub {
    url = "https://www.padl.com/download/pam_ldap-${version}.tar.gz";
    sha256 = "0lv4f7hc02jrd2l3gqxd247qq62z11sp3fafn8lgb8ymb7aj5zn8";
  };

  buildInputs = [ pam ];

  meta = {
    homepage = "https://www.padl.com/OSS/pam_ldap.html";
    description = "Provide user runtime directory on Linux systems";
    longDescription = ''
      pam_rundir is a PAM module that can be used to provide user runtime
      directory, as described in the XDG Base Directory Specification.

      The directory will be created on login (open session) and removed on
      logout (close session), and its full path made available in an
      environment variable, usually $XDG_RUNTIME_DIR
    '';
    license = "GPL";
    inherit (pam.meta) platforms;
  };
}
