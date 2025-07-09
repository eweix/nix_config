{
  pkgs,
  lib,
  ...
}: {
  # disable nix configuration
  nix.enable = false;

  # enable flakes globally
  # nix.settings.experimental-features = ["nix-command" "flakes"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # Use this instead of services.nix-daemon.enable if you
  # don't wan't the daemon service to be managed for you.
  # nix.useDaemon = true;

  # nix.package = pkgs.nix;

  # The following settings manage garbage collection and storage optimization to
  # keep disk usage low. This is important because storage is expensive on
  # macbooks.
  #   https://nixos.wiki/wiki/Storage_optimization

  # do garbage collection weekly to keep disk usage low
  # nix.gc = {
    # automatic = lib.mkDefault true;
    # interval = { Weekday = 0; Hour = 0; Minute = 0; };
    # options = lib.mkDefault "--delete-older-than 7d";
  # };

  # nix.settings = {
    # Disable auto-optimise-store because of this issue:
    #   https://github.com/NixOS/nix/issues/7273
    # "error: cannot link '/nix/store/.tmp-link-xxxxx-xxxxx' to '/nix/store/.links/xxxx': File exists"
    # auto-optimise-store = false;
    # keep-failed = false;
  # };
}
