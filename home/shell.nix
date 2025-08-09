{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initContent = ''
      eval "$(direnv hook zsh)"
      eval "$(starship init zsh)"
      eval "$(eval pay-respects zsh)"

      export PATH="/Users/eweix/.local/bin:$PATH"

      export PATH="/Users/eweix/orca:$PATH"
      export LD_LIBRARY_PATH="/Users/eweix/orca:$LD_LIBRARY_PATH"
    '';
  };

  home.shellAliases = {
    # list directory contents
    # ls = "ls --color=auto"; # colorize ls output
    l = "eza -lah";
    ls = "eza";

    # shortcuts
    k = "kubectl"; # kubernetes cluster manager
    y = "yazi";
    n = "nvim";
    vim = "nvim";
    vi = "nvim";
    ff = "fastfetch";
    lg = "lazygit";
    g = "lazygit";
    j = "just";

    # docker test shortcuts
    db = "docker build";
    drs = "docker run --user $(id -u):$(id -g) --rm=true -it -v $(pwd):/scratch -w /scratch";
    dls = "docker system df && docker system --help";

    mkdir = "mkdir -pv"; # make parent directories when making directory
    mount = "mount |column -t"; # make mount command readable

    # Shortcuts
    dots = "(cd ~/.config && chezmoi edit)";
    nixcon = "(cd ~/dev/nix && nvim)"; # edit dotfiles & nix config
    nixup = "(cd ~/dev/nix && just darwin)"; # update nix-darwin configuration
    flakes = "(cd ~/dev/flakes && nvim)"; # edit flake repo
    snip = "(cd ~/.snippets && nvim)"; # edit snippets
    snips = "(cd ~/.snippets && nvim)";
    snippets = "(cd ~/.snippets && nvim)";

    # python development
    pyv = "source .venv/bin/activate || conda activate"; # python env activation command
    pyd = "deactivate || conda deactivate"; #
    py = "python3";
    csave = "conda env export -v -f ENV.yml"; # export conda environment
  };
}
