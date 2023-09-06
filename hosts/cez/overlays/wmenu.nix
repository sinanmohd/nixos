final: prev:

{
  wmenu = prev.wmenu.overrideAttrs (finalAttrs: prevAttrs:
    {
      pname = prevAttrs.pname + "-sinan";
      postPatch = ''
        sed 's/monospace 10/monospace 13/g' -i main.c
      '';
    }
  );
}
