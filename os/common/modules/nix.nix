{ ... }: {
  nix.settings = {
    auto-optimise-store = true;
    use-xdg-base-directories = true;
    experimental-features = [ "flakes" "nix-command" "repl-flake" ];
  };
}
