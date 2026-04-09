# macOSシステムレベルの設定。nix-darwinで管理する。
# ユーザー設定（home-manager）とは異なり、OS全体に影響する設定をここに書く。
{...}: {
    imports = [
        ./modules/borders.nix
    ];

    # nix-darwinのnix管理を無効化（Determinate Nixを使用しているため）
    nix.enable = false;

    system.stateVersion = 5;
    system.primaryUser = "maoz";

    users.users.maoz.home = "/Users/maoz";

    # sudoでTouch IDを使えるようにする
    security.pam.services.sudo_local = {
        touchIdAuth = true;
        reattach = true; # tmux内でも動作するように必要
    };

    # VPNクライアント
    # https://nix-darwin.github.io/nix-darwin/manual/#opt-services.tailscale.enable
    services.tailscale.enable = true;

    # nixpkgsで配布されていないGUIアプリはHomebrewのCaskで管理する
    homebrew = {
        enable = true;
        brews = [];
        casks = [
            "alt-tab"
            "parsec"
            "claude-code"
            "1password"
            "raycast"
            "ghostty"
            "mactex-no-gui"
            "thunderbird"
            "gcloud-cli"
            "postman"
            "cursor"
            "zotero"
            "session-manager-plugin"
            "karabiner-elements"
            "google-chrome"
            "discord"
        ];
    };
}

