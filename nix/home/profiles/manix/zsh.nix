# manix（NixOS）用のzsh設定。macOS固有の設定（nvm, rbenv, pyenv, homebrew等）は除外。
{ pkgs, ... }: {
    programs.zsh = {
        enable = true;

        plugins = [
            {
                name = "zsh-autosuggestions";
                src = pkgs.zsh-autosuggestions;
                file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
            }
            {
                name = "zsh-syntax-highlighting";
                src = pkgs.zsh-syntax-highlighting;
                file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
            }
        ];

        sessionVariables = {
            GOPATH = "$HOME/go";
        };

        initContent = ''
            # yazi
            function yz() {
                tmp="$(mktemp -t "yazi-cwd.XXXXX")"
                yazi --cwd-file="$tmp"
                if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                    cd -- "$cwd"
                fi
                rm -f -- "$tmp"
            }
        '';
    };

    home.sessionPath = [
        "$HOME/go/bin"
    ];
}
