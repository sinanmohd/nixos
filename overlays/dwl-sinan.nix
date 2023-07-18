final: prev:

{
  dwl-sinan = prev.dwl.overrideAttrs (finalAttrs: prevAttrs:
    {
      pname = prevAttrs.pname + "-sinan";
      src = prev.fetchgit {
        url = "https://git.sinanmohd.com/dwl";
        rev = "f708547efb0b3afe4149f6eb7bcc685fc39f351a";
        sha256 = "04rb90hasicm4aj51403hjxyyszm87qiqz6phrjy3364vkqvrx3c";
      };
    }
  );
}
