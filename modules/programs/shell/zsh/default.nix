{
  self,
  pkgs,
  terminalFileManager,
  ...
}: {
  home-manager.sharedModules = [
    (_: {
      xdg.configFile."zsh/.p10k.zsh".source = ./.p10k.zsh;
      xdg.configFile."zsh/templates" = {
        source = ./templates;
        recursive = true;
      };
      programs.zsh = {
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        enableCompletion = true;
        autocd = true;
        history = {
          size = 100000;
          save = 100000;
          path = "\${XDG_DATA_HOME}/zsh/history";
          ignoreDups = true;
          ignoreSpace = true;
          extended = true;
          share = true;
        };
        dotDir = ".config/zsh";
        
        plugins = [
          {
            name = "zsh-vi-mode";
            src = pkgs.fetchFromGitHub {
              owner = "jeffreytse";
              repo = "zsh-vi-mode";
              rev = "v0.11.0";
              sha256 = "sha256-xbchXJTFWeABTwq6h4KWLh+EvydDrDzcY9AQVK65RS8=";
            };
          }
          {
            name = "zsh-autopair";
            src = pkgs.fetchFromGitHub {
              owner = "hlissner";
              repo = "zsh-autopair";
              rev = "396c38a7468458ba29011f2ad4112e4fd35f78e6";
              sha256 = "sha256-PXHxPxFeoYXYMOC29YQKDdMnqTO0toyA7eJTSCV6PGE=";
            };
          }
          {
            name = "you-should-use";
            src = pkgs.fetchFromGitHub {
              owner = "MichaelAquilina";
              repo = "zsh-you-should-use";
              rev = "1.7.3";
              sha256 = "sha256-DmVkOdOCEv6yWPoehT9PpYsCwAyZDaKMOx8gXuQNR6I=";
            };
          }
          {
            name = "zsh-completions";
            src = pkgs.zsh-completions;
          }
        ];
        
        oh-my-zsh = {
          enable = true;
          plugins = [
            "git"
            "gitignore" 
            "z"
            "docker"
            "docker-compose"
            "sudo"
            "history-substring-search"
            "colored-man-pages"
            "command-not-found"
            "web-search"
            "extract"
            "safe-paste"
            "cp"
          ];
        };
        
        initContent = ''
          # Powerlevel10k Zsh theme
          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
          test -f ~/.config/zsh/.p10k.zsh && source ~/.config/zsh/.p10k.zsh

          # Direnv hook
          eval "$(direnv hook zsh)"

          # Key Bindings
          bindkey '^l' "${terminalFileManager}\r"
          bindkey '^a' beginning-of-line
          bindkey '^e' end-of-line
          bindkey '^[[A' history-substring-search-up
          bindkey '^[[B' history-substring-search-down
          bindkey '^k' history-substring-search-up
          bindkey '^j' history-substring-search-down
          
          # Дополнительные хоткеи
          bindkey '^f' 'cd $(find . -type d -print | fzf)\r'
          bindkey '^r' 'fc -R; history | fzf --tac | cut -c8- | read cmd && print -z $cmd'
          bindkey '^t' tmux-sessionizer
          bindkey '^o' 'cd ..; ls'

          # Zsh options
          unsetopt menu_complete
          unsetopt flowcontrol

          setopt prompt_subst
          setopt always_to_end
          setopt append_history
          setopt auto_menu
          setopt complete_in_word
          setopt extended_history
          setopt hist_expire_dups_first
          setopt hist_ignore_dups
          setopt hist_ignore_space
          setopt hist_verify
          setopt inc_append_history
          setopt share_history
          setopt auto_pushd
          setopt pushd_ignore_dups
          setopt pushd_minus
          setopt correct
          setopt correct_all
          setopt no_beep
          setopt multios
          setopt cdablevarS

          function lf {
              tmp="$(mktemp)"
              command lf -last-dir-path="$tmp" "$@"
              if [ -f "$tmp" ]; then
                  dir="$(cat "$tmp")"
                  rm -f "$tmp"
                  if [ -d "$dir" ]; then
                      if [ "$dir" != "$(pwd)" ]; then
                          cd "$dir"
                      fi
                  fi
              fi
          }
          
          function ex {
           if [ -z "$1" ]; then
              echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
              echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
           else
              for n in "$@"
              do
                if [ -f "$n" ] ; then
                    case "''${n%,}" in
                      *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                      ${pkgs.gnutar}/bin/tar xvf "$n"       ;;
                      *.lzma)      unlzma ./"$n"      ;;
                      *.bz2)       bunzip2 ./"$n"     ;;
                      *.cbr|*.rar)       unrar x -ad ./"$n" ;;
                      *.gz)        gunzip ./"$n"      ;;
                      *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
                      *.z)         uncompress ./"$n"  ;;
                      *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                      ${pkgs.p7zip}/bin/7z x ./"$n"        ;;
                      *.xz)        unxz ./"$n"        ;;
                      *.exe)       cabextract ./"$n"  ;;
                      *.cpio)      cpio -id < ./"$n"  ;;
                      *.cba|*.ace)      unace x ./"$n"      ;;
                      *)
                      echo "Unsupported format"
                      return 1
                      ;;
                    esac
                else
                    echo "'$n' - file does not exist"
                    return 1
                fi
              done
           fi
          }

          function fnew {
            if [ -d "$1" ]; then
              echo "Directory \"$1\" already exists!"
              return 1
            fi
            nix flake new $1 --template ${self}/dev-shells#$2
            cd $1
            direnv allow
          }

          function finit {
            nix flake init --template ${self}/dev-shells#$1
            direnv allow
          }

          function cgen {
            if [ -d "$1" ]; then
              echo "Directory \"$1\" already exists!"
              return 1
            fi
            nix flake new $1 --template ${self}/dev-shells#c-cpp
            cd $1
            cat ~/.config/zsh/templates/ListTemplate.txt >> CMakeLists.txt
            mkdir src
            mkdir include
            cat ~/.config/zsh/templates/HelloWorldTemplate.txt >> src/main.cpp
            direnv allow
          }

          function crun {
            mkdir build 2> /dev/null
            cmake -B build
            cmake --build build
            build/main
          }

          function cbuild {
            mkdir build 2> /dev/null
            cmake -B build
            cmake --build build
          }
          
          
          function mkcd {
            mkdir -p "$1" && cd "$1"
          }
          
          function backup {
            cp "$1" "$1.bak.$(date +%Y%m%d_%H%M%S)"
          }
          
          function findin {
            grep -r "$1" .
          }
          
          function h {
            if [ $# -eq 0 ]; then
              history
            else
              history | grep "$1"
            fi
          }
          
          function sysinfo {
            echo "System Information:"
            echo "=================="
            echo "Hostname: $(hostname)"
            echo "Uptime: $(uptime -p)"
            echo "Memory Usage: $(free -h | awk '/^Mem/ {print $3 "/" $2}')"
            echo "Disk Usage: $(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')"
            echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"
            echo "Kernel: $(uname -r)"
          }
          
          function hf {
            eval $(history | fzf --tac | cut -c8-)
          }
          
          function tmpd {
            cd $(mktemp -d)
          }
          
          function weather {
            curl -s "wttr.in/$1?format=3"
          }
          
          function myip {
            curl -s https://httpbin.org/ip | jq -r '.origin'
          }
          
          function note {
            echo "$(date): $*" >> "$HOME/notes.txt"
          }
          
          function notes {
            cat "$HOME/notes.txt"
          }
          
          function gclone {
            git clone "$1" && cd "$(basename "$1" .git)"
          }
          
          function gcommit {
            git add . && git commit -m "$1"
          }
          
          function gpush {
            git push origin $(git branch --show-current)
          }
          
          function gstatus {
            git status --short --branch
          }
          
          function j {
            case $1 in
              home|~) cd ~ ;;
              dots|config) cd ~/NixOS ;;
              work) cd /mnt/work ;;
              projects|proj) cd /mnt/work/Projects ;;
              downloads|dl) cd ~/Downloads ;;
              documents|docs) cd ~/Documents ;;
              *) echo "Unknown shortcut: $1" ;;
            esac
          }
          
          function editconfig {
            case $1 in
              zsh) nvim ~/NixOS/modules/programs/shell/zsh/default.nix ;;
              hypr|hyprland) nvim ~/NixOS/modules/desktop/hyprland/default.nix ;;
              flake) nvim ~/NixOS/flake.nix ;;
              *) echo "Unknown config: $1. Available: zsh, hypr, flake" ;;
            esac
          }
          
          function psg {
            ps aux | grep -v grep | grep -i "$1"
          }
          
          function countlines {
            find . -name "*.${1:-*}" -type f -exec wc -l {} + | tail -1
          }
          
          function qr {
            echo "$1" | qrencode -t UTF8
          }
          
          function dirsize {
            du -sh "''${1:-.}" | cut -f1
          }
          
          function bigfiles {
            find . -type f -size +''${1:-100M} -exec ls -lh {} + | sort -k5 -hr
          }
        '';
        
        envExtra = ''
          # Defaults
          export XMONAD_CONFIG_DIR="''${XDG_CONFIG_HOME:-$HOME/.config}/xmonad"
          export XMONAD_DATA_DIR="''${XDG_DATA_HOME:-$HOME/.local/share}/xmonad"
          export XMONAD_CACHE_DIR="''${XDG_CACHE_HOME:-$HOME/.cache}/xmonad"

          export FZF_DEFAULT_OPTS=" \
          --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
          --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
          --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
          --height=40% --layout=reverse --border --inline-info"
          
          export LESS="-R -X -F"
          export PAGER="less"
          export EDITOR="nvim"
          export VISUAL="nvim"
          export BROWSER="floorp"
          
          export YSU_MESSAGE_POSITION="after"
          export YSU_MODE=ALL
        '';
        
        shellGlobalAliases = {
          UUID = "$(uuidgen | tr -d \\n)";
          G = "| grep";
          L = "| less";
          H = "| head";
          T = "| tail";
          S = "| sort";
          U = "| uniq";
          C = "| wc -l";
          N = "> /dev/null 2>&1";
        };
        
        shellAliases = {
          cls = "clear";
          c = "clear";
          x = "exit";
          q = "exit";
          
          ".." = "cd ..";
          "..." = "cd ../..";
          "...." = "cd ../../..";
          "....." = "cd ../../../..";
          
          l = "${pkgs.eza}/bin/eza -lh  --icons=auto --git";
          ls = "${pkgs.eza}/bin/eza -1   --icons=auto";
          ll = "${pkgs.eza}/bin/eza -lha --icons=auto --sort=name --group-directories-first --git";
          la = "${pkgs.eza}/bin/eza -a   --icons=auto";
          ld = "${pkgs.eza}/bin/eza -lhD --icons=auto";
          tree = "${pkgs.eza}/bin/eza --icons=auto --tree --level=3";
          treea = "${pkgs.eza}/bin/eza --icons=auto --tree --level=3 -a";
          
          cp = "cp -iv";
          mv = "mv -iv";
          rm = "rm -vI";
          mkdir = "mkdir -pv";
          mkd = "mkdir -pv";
          rmdir = "rmdir -v";
          
          f = "${pkgs.fd}/bin/fd";
          find = "${pkgs.fd}/bin/fd";
          grep = "${pkgs.ripgrep}/bin/rg";
          rg = "${pkgs.ripgrep}/bin/rg";
          
          nf = "${pkgs.microfetch}/bin/microfetch";
          neofetch = "${pkgs.neofetch}/bin/neofetch";
          htop = "${pkgs.btop}/bin/btop";
          top = "${pkgs.btop}/bin/btop";
          df = "df -h";
          du = "du -h";
          free = "free -h";
          ps = "ps auxf";
          pstree = "pstree -p";
          
          v = "nvim";
          nv = "nvim";
          vim = "nvim";
          vi = "nvim";
          vc = "code --disable-gpu";
          code = "code --disable-gpu";
          
          g = "git";
          ga = "git add";
          gaa = "git add --all";
          gc = "git commit";
          gcm = "git commit -m";
          gca = "git commit --amend";
          gco = "git checkout";
          gb = "git branch";
          gbd = "git branch -d";
          gs = "git status --short --branch";
          gst = "git status";
          gl = "git log --oneline --graph --decorate";
          gla = "git log --oneline --graph --decorate --all";
          gd = "git diff";
          gdc = "git diff --cached";
          gp = "git push";
          gpu = "git push -u origin HEAD";
          gpl = "git pull";
          gf = "git fetch";
          gr = "git remote -v";
          gm = "git merge";
          grh = "git reset --hard";
          grs = "git reset --soft";
          gclean = "git clean -fd";
          
          d = "docker";
          dc = "docker-compose";
          dps = "docker ps";
          di = "docker images";
          dlog = "docker logs";
          dexec = "docker exec -it";
          
          t = "tmux";
          ta = "tmux attach";
          tat = "tmux attach -t";
          tn = "tmux new-session";
          tns = "tmux new-session -s";
          tl = "tmux list-sessions";
          tk = "tmux kill-session";
          tks = "tmux kill-session -t";
          
          reboot = "sudo systemctl reboot";
          poweroff = "sudo systemctl poweroff";
          suspend = "sudo systemctl suspend";
          hibernate = "sudo systemctl hibernate";
          
          ping = "ping -c 5";
          wget = "wget -c";
          curl = "curl -L";
          ports = "netstat -tulanp";
          
          tgz = "tar -czf";
          tgx = "tar -xzf";
          tbz = "tar -cjf";
          tbx = "tar -xjf";
          
          tp = "${pkgs.trash-cli}/bin/trash-put";
          tpr = "${pkgs.trash-cli}/bin/trash-restore";
          tpe = "${pkgs.trash-cli}/bin/trash-empty";
          tpl = "${pkgs.trash-cli}/bin/trash-list";
          
          rebuild = "${../../../desktop/hyprland/scripts/rebuild.sh}";
          sysup = "sudo nixos-rebuild switch --flake ~/NixOS#Default --upgrade-all --show-trace";
          nixup = "nix flake update ~/NixOS";
          nixgc = "nix-collect-garbage -d";
          nixstore = "nix-store --gc";
          nixoptimise = "nix-store --optimise";
          nixsearch = "nix search nixpkgs";
          nixshell = "nix-shell";
          nixrun = "nix run nixpkgs#";
          
          home = "cd ~";
          dots = "cd ~/NixOS/";
          conf = "cd ~/NixOS/";
          games = "cd /mnt/games/";
          work = "cd /mnt/work/";
          media = "cd /mnt/work/media/";
          projects = "cd /mnt/work/Projects/";
          proj = "cd /mnt/work/Projects/";
          dev = "cd /mnt/work/Projects/";
          downloads = "cd ~/Downloads/";
          docs = "cd ~/Documents/";
          
          bc = "bc -ql";
          calc = "bc -ql";
          pokemon = "pokego --random 1-8 --no-title";
          weather = "curl -s wttr.in/Moscow";
          qr = "qrencode -t UTF8";
          
          matrix = "cmatrix -s";
          pipes = "pipes.sh";
          clock = "tty-clock -c -C 6 -r -f \"%A, %B %d\"";
          
          bench = "hyperfine";
          
          pbcopy = "wl-copy";
          pbpaste = "wl-paste";
        };
      };
    })
  ];
}
