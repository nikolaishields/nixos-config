{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  impermanence = builtins.fetchGit {
    url = "https://github.com/nix-community/impermanence.git";
    ref = "master";
  };
in {
  security = {
    sudo.wheelNeedsPassword = false;
    pam.services.login.fprintAuth = true;
    rtkit.enable = true;
  };

  users.users.nikolai = {
    isNormalUser = true;
    shell = pkgs.unstable.zsh;
    extraGroups = [ "docker" "wheel" "networkmanager" "input" "libvirtd" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMrs3AFRgL4YfA7aMAD7X3O9kihcSCJKY8GiyWYV6Jwx nikolai@nikolaishields.com"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQClYajEyvhqsc4kQ4fXqeu09Bunl75A30qcsVjHNXSThOaWks+DjKYeVE605Fs3iHRa6eHfRf58tCFsjwp3xlMn/uMVd1pjo6X+qGyQsmTCv6tFI281+EqquINrUMpSyAT+yTL4P/IEeu/MyYOpfz9Qvr75B+5sRpDJnmV2PS+WfbM6AyW3sIEfpzrNy4k8V0tuSCICEpgWweR78OMYFhN61k05yzXwkaGTpKWML0WH9uyLKYh6xuzWLxflm4N1cPJnaCFCcTD4Mp/FhRLXKxQuEIkACdKdOozuMxNEDk3PkzptRckuGqtPytyUOKIYo1Uo/ra9ddqohAgR+XcDLNhuOMijIbDpqKJ9YuiVPAz5AeGXJkzPfAl8ove0if/ALkn0S8EFBE/HrOpwqHhETO1y5Nl3rWTIIrmPmRFtgX8p6R4w9rY2nIXhtCNJE/JEYv5opjqxseR9GogFH3Tm2cnoOQEAur1HIS8HwKL60aGaJ6ojgAo7lzHqV2MyR9UBcdoBTREUoo2BlQZsmXQJ6/oAc+SlJDA+7UTr4C+haIlX3DzVOsN/VU+3RZho6ebVjpjnmzCwjGPmcHDtx3ILlWb9SvXwAE85zbYHGKoiv8K5D0Y0Wx0YkqdlrppN68uNjpAGx0n9ti/uK5T2EmPdC6VbfuCCVBK5tzx62qhgKG8p4Q== nikolai@nikolaishields.com"
    ];
  };

  imports = [
    (import "${home-manager}/nixos")
    #(import "${impermanence}/home-manager.nix")
  ];

  home-manager.useGlobalPkgs = true;

  home-manager.users.nikolai = {

    home.username = "nikolai";
    home.homeDirectory = "/home/nikolai";

    home.file = {
      ".config/nvim/lua/nikolaishields" = {
      source = ./nvim/lua/nikolaishields;
      recursive = true;
      };
    };
 
    home.stateVersion = "21.11";

    home.packages = with pkgs.unstable; [
      nixos-generators
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
      nerdfonts
      niv
      pass
      pinentry
      ranger
      ripgrep
      shellcheck
      sops
      tealdeer
      tmux
      vagrant
      whois
      youtube-dl
      yubikey-manager
      yubikey-manager-qt
    ];

    services = {
    # TODO: Get latest keybase working
      kbfs = {
        enable = true;
      };

      keybase = {
        enable = true;
      };

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

      gpg = {
       enable = true; 
       package = pkgs.unstable.gnupg;
      };

      direnv = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };

      fzf = {
        enable = true;
        package = pkgs.unstable.fzf;
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
          tf = "terraform";
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
        package = pkgs.unstable.vscode;
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
      
      neovim = {
        enable = true;
        package = pkgs.unstable.neovim-unwrapped;
        vimAlias = true;
        viAlias = true;
        withPython3 = true;
        extraPackages = with pkgs; [
          ripgrep
          shfmt
          git
        ];

        extraConfig = builtins.readFile nvim/vimrc;

        plugins = with pkgs.unstable.vimPlugins; [
          auto-pairs
          neoformat
          neomake
          nerdcommenter
          nvim-lspconfig
          papercolor-theme
          plenary-nvim
          popup-nvim
          telescope-file-browser-nvim
          telescope-fzy-native-nvim
          telescope-nvim
          undotree
          vim-fugitive
          vim-gitgutter
          vim-go
        ];
      };

      git = {
        enable = true;
        package = pkgs.unstable.gitFull;
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

