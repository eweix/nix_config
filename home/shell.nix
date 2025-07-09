{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
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
    # vuv = "source .venv/bin/activate";
    # uvv = "source .venv/bin/activate";
    # condav = "conda activate";
    # condad = "conda deactivate";
    # uvd = "deactivate";

    # other useful aliases
    dots = "cd ~/dev/nix && nvim"; # edit dotfiles & nix config
    ls = "ls --color=auto"; # colorize ls output
    mkdir = "mkdir -pv"; # make parent directories when making directory
    mount = "mount |column -t"; # make mount command readable

    # safety nets
    rm = "rm -I --preserve-root";
    mv = "mv -i";
    cp = "cp -i";
    ln = "ln -i";
    chown = "chown --preserve-root";
    chmod = "chmod --preserve-root";
    chgrp = "chgrp --preserve-root";
  };
}
