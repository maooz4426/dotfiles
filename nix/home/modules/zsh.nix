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
            PYENV_ROOT = "$HOME/.pyenv";
        };

        initContent = ''
            # starship
            eval "$(starship init zsh)"

            # yazi
            function yz() {
                tmp="$(mktemp -t "yazi-cwd.XXXXX")"
                yazi --cwd-file="$tmp"
                if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                    cd -- "$cwd"
                fi
                rm -f -- "$tmp"
            }

            # タイトルバー
            precmd() { print -Pn "\e]0;%~\a" }

            # nvm
            export NVM_DIR="$HOME/.nvm"
            [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
            [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

            # rbenv
            eval "$(rbenv init - zsh)"

            # pyenv
            export PATH="$PYENV_ROOT/bin:$PATH"
            eval "$(pyenv init -)"


            # thefuck
            eval $(thefuck --alias)

            eval "$(/usr/libexec/path_helper)"

            # cargo
            [ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
        '';
    };

    home.sessionPath = [
        "$HOME/.bun/bin"
        "$HOME/go/bin"
        "$HOME/.rbenv/bin"
        "$HOME/.yarn/bin"
        "/opt/homebrew/opt/mysql-client/bin"
    ];
}
