{ ... }: {
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "flakes" "nix-command" "repl-flake" ];
  };
}
