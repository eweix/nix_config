{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      eval "$(direnv hook zsh)"
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
    ff = "fastfetch";

    # shorthand command to make a new template
    # dvd = ''
    #   nix flake init --template "https://flakehub.com/f/the-nix-way/dev-templates/dev-templates/*#{ echo $2 }" \
    #   && echo 'use flake' >> .envrc \
    #   && direnv allow
    # '';
    # dvdpy = "nix flake init --template \"\" && echo 'use flake' >> .envrc && direnv allow";
    # dvdhugo = "nix flake init --template \" \" && echo 'use flake' >> .envrc && direnv allow";
    # dvdrust = "nix flake init --template \"https://flakehub.com/f/the-nix-way/dev-templates/*#rust\" && echo 'use flake' >> .envrc && direnv allow";

    # python development
    pyv = "source .venv/bin/activate || conda activate"; # python env activation command
    pyd = "deactivate || conda deactivate"; #
    py = "python3";
    csave = "conda env export -v -f ENV.yml"; # export conda environment

    # other useful aliases
    dots = "cd ~/.config && chezmoi edit";
    nixcon = "cd ~/dev/nix && nvim"; # edit dotfiles & nix config
    ls = "ls --color=auto"; # colorize ls output
    mkdir = "mkdir -pv"; # make parent directories when making directory
    mount = "mount |column -t"; # make mount command readable
    chez = "chezmoi";
  };
}
