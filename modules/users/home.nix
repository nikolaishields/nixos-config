 imports = [
    (import "${home-manager}/nixos")
  ];
  home-manager.useGlobalPkgs = true;

  home-manager.users.nikolai = {

    home.username = "nikolai";
    home.homeDirectory = "/home/nikolai";

    home.stateVersion = "21.11";

    home.packages = with pkgs; [
      ffmpeg
      file
      fira-code-symbols
      font-awesome
      gnumake
      htop
      jq
      k9s
      kubectl
      lorri
      neovim
      nerdfonts
      niv
      pass
      ranger
      ripgrep
      shellcheck
      sops
      tealdeer
      tmux
      vagrant
      whois
      youtube-dl
      pinentry
      keybase
      yubikey-manager
      yubikey-manager-qt
      kbfs
    ];

    # TODO: migrate to nix neovim config
    home.file.".config/nvim".source = ./dotfiles/nvim;

    services = {
      kbfs.enable = false;
      keybase.enable = false;
      gpg-agent = {
        enable = true;
        enableSshSupport = true;
        pinentryFlavor = "gnome3";
        sshKeys = [
          "86A41395DA53FDDF5C62C7B9A2009105CE189AD8"
        ];
      };
    };

    programs = {

      home-manager.enable = true;

      bat.enable = true;

      gpg.enable = true;

      direnv = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };

      fzf = {
        enable = true;
        enableZshIntegration = true;
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
        };

        oh-my-zsh = {
          enable = true;
          theme = "awesomepanda";
        };

        localVariables = { 
          EDITOR = "nvim"; 
          SSH_AUTH_SOCK = "$(gpgconf --list-dirs agent-ssh-socket)"; 
          GPG_TTY = "$(tty)";
        };

        dirHashes = {
          src = "$HOME/src";
          work = "$HOME/src/github.com/rancher/src";
          nas = "$HOME/src/github.com/nikolaishields";
          nix = "$HOME/src/github.com/nixos";
          dl = "$HOME/down";
        };

      };

      vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
          golang.go
          hashicorp.terraform
          ms-azuretools.vscode-docker
          ms-kubernetes-tools.vscode-kubernetes-tools
          ms-vscode-remote.remote-ssh
          ms-vsliveshare.vsliveshare
          vscodevim.vim
          yzhang.markdown-all-in-one
        ];
      };

      git = {
        enable = true;
        aliases = {
          co = "checkout";
          c = "commit";
          s = "status";
        };

        userName = "Nikolai Shields";
        userEmail = "nikolai@nikolaishields.com";
        signing = {
          key = "389F227A6FAE680E";
          signByDefault = true;
        };

        extraConfig = {
          core = {
            editor = "nvim";
            pager = "less";
          };

          init = { defaultBranch = "main"; };
        };
      };
    };
  };
}
