#  Install all apps and packages here.
{pkgs, ...}: {
  # Install packages from nix's official package repository. The packages
  # installed here are available to all users, and are reproducible across
  # machines, and are rollbackable. But on macOS, it's less stable than
  # homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331

  environment.systemPackages = with pkgs; [
    neovim
    git
    just # use Justfile to simplify nix-darwin's commands
  ];

  # Disable default homebrew analytics
  environment.variables.HOMEBREW_NO_ANALYTICS = "1";

  environment.variables.EDITOR = "nvim";

  # TODO To make this work, homebrew need to be installed manually, see
  # https://brew.sh

  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs,
  # especially for GUI apps!

  # I use homebrew to install GUI apps only, and leave all of the command line
  # tools to nixpkgs. I believe the reproducibility hit is made up for by
  # homebrew's better support for macos GUI.

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true; # Fetch the newest stable branch of Homebrew's git repo
      upgrade = true; # Upgrade outdated casks, formulae, and App Store apps
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas. You need to install
    # all these Apps manually first so that your apple account have records for
    # them. otherwise Apple Store will refuse to install them. For details, see
    # https://github.com/mas-cli/mas
    masApps = {
      Paprika = 1303222868; # Recipe manager
      Things = 904280696; # To-do list
      Amphetamine = 937984704; # Sleep utility
      Xcode = 497799835; # Developer tools
    };

    taps = [
      "homebrew/services"
      # "mhaeuser/mhaeuser" # battery toolkit
      # "domt4/autoupdate" # update daemon for homebrew
    ];

    # `brew install`
    brews = [
      # "wget" # download tool
      # "curl" # do not install curl via nixpkgs, it's not working well on macOS!
      # "aria2" # download tool
      # "httpie" # http client
      # "coreutils"
      # "direnv"
      # "fd"
      # "gcc"
      # "grep"
      # "ripgrep"
      # "trash"
      # "tree-sitter"
      # "fastfetch" # Neofetch, but maintained
      # "go"
      # "hugo" # Static site generator
      # "node"
      # "node-sass"
      # "mit-scheme" # Didactic language
      # "rust" # For funsies

      # "battery-toolkit" # battery life tool
      # TODO find some way to automatically run the following script
      # brew autoupdate start 604800 --leaves-only --ac-only --upgrade --cleanup
      # https://github.com/DomT4/homebrew-autoupdate
    ];

    # `brew install --cask`
    casks = [
      # Browsing
      "netnewswire" # RSS reader
      "librewolf" # Firefox, but with privacy
      "tor" # Onion router
      "eloston-chromium" # Chrome, without telemetry

      # IM & audio & remote desktop & meeting
      "signal" # encrypted messanger client
      "discord" # social
      "slack" # for work
      "element" # matrix client

      # Development
      "wezterm" # Terminal emulator
      "docker" # Virutalization software
      "utm" # Virtual Machine Manager
      "sublime-text" # Best text editor, aside from neovim
      "mactex-no-gui" # TeX live installation, no GUI

      # Security
      "lulu" # Firewall

      # Writing/Reading
      "scrivener" # Rich text editor
      "obsidian" # Markdown editor
      "zotero" # Reference manager
      "skim" # PDF reader

      # Syncing
      "onedrive"
      "google-drive"
      "box-drive"
      "carbon-copy-cloner"

      # Science tools
      "wolfram-engine" # mathematica w/out GUI
      "pymol" # Molecular structure viewing
      "jalview" # Sequence alignments
      "fiji" # Image processing tool

      # Misc
      "monitorcontrol" # Brightness and volume controls for external monitors.
      "leader-key" # Leader keys for commands/quick switching
      "keka" # unarchiver
      "selfcontrol"
      "stats" # display stats
      "cheatsheet" # show all shortcuts
      "jordanbaird-ice" # menu bar utility

      "alfred" # Launcher to replace spotlight
      "daisydisk" # Diagnostics and disksweeping
      "iina" # media player
      "acorn" # Image editor
      "retroarch" # Emulator frontend
      "anki" # flashcards
      "fantastical" # Calendar

      # fonts
      "font-departure-mono-nerd-font" # Pixel terminal font
      "font-fira-code-nerd-font" # Nicer nerd font
      "font-overpass-nerd-font" # Fun sans-serif font
    ];
  };
}
