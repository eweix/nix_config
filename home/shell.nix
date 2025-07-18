{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initContent = ''
      eval "$(direnv hook zsh)"
      eval "$(starship init zsh)"
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

    mkdir = "mkdir -pv"; # make parent directories when making directory
    mount = "mount |column -t"; # make mount command readable

    # Shortcuts
    dots = "cd ~/.config && chezmoi edit";
    nixcon = "cd ~/dev/nix && nvim"; # edit dotfiles & nix config
    flakes = "cd ~/dev/flakes && nvim"; # edit flake repo
    snip = "cd ~/dev/snippets && nvim"; # edit snippets
    snips = "cd ~/dev/snippets && nvim";
    snippets = "cd ~/dev/snippets && nvim";
    dev = "cd ~/dev && eza";

    # python development
    pyv = "source .venv/bin/activate || conda activate"; # python env activation command
    pyd = "deactivate || conda deactivate"; #
    py = "python3";
    csave = "conda env export -v -f ENV.yml"; # export conda environment
  };
}
