{ config, pkgs, ... }: {
  targets.genericLinux.enable = true;
  home = {
    stateVersion = "23.05";
    username = "nshields";
    homeDirectory = "/home/nshields";
    file = {
      ".config/nvim/lua/nikolaishields" = {
        source = ./nvim/lua/nikolaishields;
        recursive = true;
      };

      ".local/bin/git-snapshot" = { source = ./scripts/git-snapshot; };
    };
  };

  home.packages = with pkgs; [
    brave
    docker-compose
    ffmpeg
    file
    fira-code-symbols
    font-awesome
    gnumake
    helm
    htop
    jq
    k9s
    wl-clipboard
    kitty
    kubectl
    logseq
    nerdfonts
    nixfmt
    podman
    ranger
    ripgrep
    shellcheck
    sops
    sysz
    tealdeer
    vault
    whois
    youtube-dl
  ];

  programs = {
    home-manager.enable = true;

    bat.enable = true;

    ssh = { forwardAgent = true; };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    fzf = {
      enable = true;
      package = pkgs.fzf;
      enableZshIntegration = true;
    };

    bash = {
      enable = true;
      sessionVariables = {
        EDITOR = "nvim";
        VAULT_ADDR = "https://it-vault.dwavesys.local";
        LD_PRELOAD = "/lib/x86_64-linux-gnu/libnss_sss.so.2";
      };
    };

    zsh = {
      enable = true;
      enableVteIntegration = true;
      completionInit = "autoload -U compinit && compinit";
      autocd = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      shellAliases = {
        la = "ls -la";
        ip = "ip --color=auto";
        k = "kubectl";
        tf = "terraform";
      };

      sessionVariables = {
        EDITOR = "nvim";
        VAULT_ADDR = "https://it-vault.dwavesys.local";
        LD_PRELOAD = "/lib/x86_64-linux-gnu/libnss_sss.so.2";
      };

      oh-my-zsh = {
        enable = true;
        theme = "awesomepanda";
      };

      dirHashes = {
        Code = "$HOME/Code";
        work = "$HOME/Code/dwave/src";
        nix = "$HOME/Code/github.com/nikolaishields/nixos-config";
        dl = "$HOME/Downloads";
      };

    };

    neovim = {
      enable = true;
      package = pkgs.neovim-unwrapped;
      vimAlias = true;
      viAlias = true;
      withPython3 = true;
      extraPackages = with pkgs; [
        git
        gopls
        nodePackages.bash-language-server
        ripgrep
        shfmt
        terraform-ls
      ];

      extraConfig = builtins.readFile nvim/vimrc;

      plugins = with pkgs.vimPlugins; [
        vimwiki
        luasnip
        auto-pairs
        auto-save-nvim
        neoformat
        neomake
        nerdcommenter
        nvim-lspconfig
        papercolor-theme
        plenary-nvim
        popup-nvim
        project-nvim
        nvim-cmp
        cmp-nvim-lsp
        telescope-file-browser-nvim
        telescope-fzy-native-nvim
        telescope-nvim
        undotree
        vim-fugitive
        vim-nix
        telescope-project-nvim
      ];
    };

    git = {
      enable = true;
      package = pkgs.gitFull;
      aliases = {
        co = "checkout";
        c = "commit";
        s = "status";
      };

      userName = "Nikolai Shields";
      userEmail = "nshields@dwavesys.com";
      signing = {
        key = "~/.ssh/id_ed25519";
        signByDefault = true;
      };

      extraConfig = {
        core = {
          editor = "nvim";
          pager = "bat";
        };

        gpg = {
          format = "ssh";
          ssh = { allowedSignersFile = "~/.config/git/allowed_signers"; };
        };

        init = { defaultBranch = "main"; };
      };
    };
  };
}

