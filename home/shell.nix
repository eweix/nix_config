{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      eval "$(starship init zsh)"
    '';
  };

  home.shellAliases = {
    # file browsing and text editing
    k = "kubectl"; # kubernetes cluster manager
    y = "yazi";
    n = "nvim";
    vim = "nvim";
    vi = "nvim";

    # python development
    pyv = "source .venv/bin/activate || conda activate"; # python env activation command
    pyd = "deactivate || conda deactivate"; #
    py = "python3";
    csave = "conda env export -v -f ENV.yml"; # export conda environment

    # other useful aliases
    nixcon = "cd ~/dev/nix && nvim"; # edit dotfiles & nix config
    ls = "ls --color=auto"; # colorize ls output
    mkdir = "mkdir -pv"; # make parent directories when making directory
    mount = "mount |column -t"; # make mount command readable
    chez = "chezmoi";
  };
}
