{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in {
  security = {
    sudo.wheelNeedsPassword = false;
    pam.services.login.fprintAuth = true;
    rtkit.enable = true;

  };

  users.users.nikolai = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "docker" "wheel" "networkmanager" "input" "libvirtd" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMrs3AFRgL4YfA7aMAD7X3O9kihcSCJKY8GiyWYV6Jwx nikolai@nikolaishields.com"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQClYajEyvhqsc4kQ4fXqeu09Bunl75A30qcsVjHNXSThOaWks+DjKYeVE605Fs3iHRa6eHfRf58tCFsjwp3xlMn/uMVd1pjo6X+qGyQsmTCv6tFI281+EqquINrUMpSyAT+yTL4P/IEeu/MyYOpfz9Qvr75B+5sRpDJnmV2PS+WfbM6AyW3sIEfpzrNy4k8V0tuSCICEpgWweR78OMYFhN61k05yzXwkaGTpKWML0WH9uyLKYh6xuzWLxflm4N1cPJnaCFCcTD4Mp/FhRLXKxQuEIkACdKdOozuMxNEDk3PkzptRckuGqtPytyUOKIYo1Uo/ra9ddqohAgR+XcDLNhuOMijIbDpqKJ9YuiVPAz5AeGXJkzPfAl8ove0if/ALkn0S8EFBE/HrOpwqHhETO1y5Nl3rWTIIrmPmRFtgX8p6R4w9rY2nIXhtCNJE/JEYv5opjqxseR9GogFH3Tm2cnoOQEAur1HIS8HwKL60aGaJ6ojgAo7lzHqV2MyR9UBcdoBTREUoo2BlQZsmXQJ6/oAc+SlJDA+7UTr4C+haIlX3DzVOsN/VU+3RZho6ebVjpjnmzCwjGPmcHDtx3ILlWb9SvXwAE85zbYHGKoiv8K5D0Y0Wx0YkqdlrppN68uNjpAGx0n9ti/uK5T2EmPdC6VbfuCCVBK5tzx62qhgKG8p4Q== nikolai@nikolaishields.com"
    ];
  };

  imports = [ (import "${home-manager}/nixos") ];
  home-manager.useGlobalPkgs = true;

  home-manager.users.nikolai = {

    home.username = "nikolai";
    home.homeDirectory = "/home/nikolai";

    home.stateVersion = "21.11";

    home.packages = with pkgs.unstable; [
      k9s
      kubectl
      ffmpeg
      file
      fira-code-symbols
      font-awesome
      gnumake
      gnupg
      htop
      jq
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
    ];

    home.file.".config/nvim".source = ./dotfiles/nvim;
    programs = {
      home-manager.enable = true;

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
        };

        oh-my-zsh = {
          enable = true;
          theme = "awesomepanda";
        };

        localVariables = { EDITOR = "nvim"; };

        dirHashes = {
          code = "$HOME/code";
          work = "$HOME/code/rancher";
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
          key = "41A343B84C29084CB55B2B02C8BB48128FB0B5E4";
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

