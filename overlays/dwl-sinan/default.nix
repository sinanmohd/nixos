final: prev:

{
  dwl-sinan = prev.dwl.overrideAttrs (finalAttrs: prevAttrs:
    {
      pname = prevAttrs.pname + "-sinan";
      src = prev.fetchgit {
        url = "https://git.sinanmohd.com/dwl";
        rev = "cadde97ee92381bfc2222bf18cd876526ab8c948";
        hash = "sha256-H2HgOQnQ5Eltz8/OVpKlS2U89aaivg5t63Ie4fembw8=";
      };
    }
  );
}
