{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initContent = ''
      eval "$(direnv hook zsh)"
      eval "$(starship init zsh)"

      # ollama settings for gpu acceleration
      export OLLAMA_GPU_LAYERS=-1
      export OLLAMA_KEEP_ALIVE=10m
      export PYTORCH_ENABLE_MPS_FALLBACK=1
      export PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0
    '';
  };

  home.shellAliases = {
    # file browsing and text editing
    k = "kubectl"; # kubernetes cluster manager
    y = "yazi";
    n = "nvim";
    vim = "nvim";
    vi = "nvim";
    ff = "fastfetch";
    lg = "lazygit";
    ls = "ls --color=auto"; # colorize ls output
    mkdir = "mkdir -pv"; # make parent directories when making directory
    mount = "mount |column -t"; # make mount command readable

    # Shortcuts
    dots = "cd ~/.config && chezmoi edit";
    nixcon = "cd ~/dev/nix && nvim"; # edit dotfiles & nix config
    snip = "cd ~/dev/snippets && nvim"; # edit
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
