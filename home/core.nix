{pkgs, ...}: {
  home.packages = with pkgs; [
    direnv # very important for making reproducible development shells

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processer https://github.com/mikefarah/yq
    fzf # A command-line fuzzy finder
    pandoc # A file processer and converter
    pngquant # compresses pngs very nicely!
    fd # needed for some telescope and nvim stuff

    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    # socat # replacement of openbsd-netcat
    # nmap # A utility for network discovery and security auditing

    # development
    # docker # for building containers
    starship # nicer command line prompts
    uv # python tools
    typst # for writing!
    # hugo # static site generator
    lazygit # TUI for git
    rustc
    rustup # rust toolchain installer
    tree-sitter
    go
    # nodenv # for multiple node installations
    # luajit # lua 5.1 compiler
    # luarocks-nix # lua module manager
    # lua-language-server
    prettierd # prettier daemon

    # misc
    chezmoi
    fastfetch # neofetch replacement
    # cowsay
    # file
    # which
    tree
    # gnused
    # gnutar
    # gawk
    # zstd
    # caddy
    # gnupg
  ];

  programs = {
    # we use direnv with flakes in each project to create a reproducible
    # development environment. This should work across computers and systems by
    # determining all of the "system-level" programs that need to be installed.
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    # A modern replacement for ‘ls’
    # useful in bash/zsh prompt, not in nushell.
    eza = {
      enable = true;
      git = true;
      icons = "auto";
      enableZshIntegration = true;
    };

    # terminal file manager
    yazi = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        manager = {
          show_hidden = true;
          sort_dir_first = true;
        };
      };
    };

    # skim provides a single executable: sk.
    # Basically anywhere you would want to use grep, try sk instead.
    skim = {
      enable = true;
      enableBashIntegration = true;
    };

    # Normally, one has to import all of the home-manager configs individually?
    # Maybe I wasn't reading the config stuff correctly. After some digging, I
    # found a snippet that allows recursive import of *everything* in the
    # dotfiles subdirectory here.
    # see: https://github.com/nix-community/home-manager/issues/3849#issuecomment-2115899992
    # home.file = with pkgs; let
    #  listFilesRecursive = dir: acc:
    #    lib.flatten (lib.mapAttrsToList
    #      (k: v:
    #        if v == "regular"
    #        then "${acc}${k}"
    #        else listFilesRecursive dir "${acc}${k}/")
    #      (builtins.readDir "${dir}/${acc}"));

    #  toHomeFiles = dir:
    #    builtins.listToAttrs
    #    (map (x: {
    #      name = x;
    #      value = {source = "${dir}/${x}";};
    #    }) (listFilesRecursive dir ""));
    #in
    #  toHomeFiles ./dotfiles;
  };
}
