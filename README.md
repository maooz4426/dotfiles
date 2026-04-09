# dotfiles

Nix ベースのdotfiles

## ディレクトリ構成

```
dotfiles/
├── nix/
│   ├── flake.nix                # メインの flake 設定
│   ├── systems/darwin/          # nix-darwin システム設定
│   │   └── modules/             # borders など追加モジュール
│   └── home/
│       ├── modules/             # zsh, neovim, tmux, ghostty, starship, karabiner
│       └── profiles/maozbook/   # ユーザープロファイル
├── nvim/                        # Neovim Lua 設定
├── starship/                    # Starship テーマ設定
├── ghostty/                     # Ghostty 設定
├── borders/                     # jankyborders 設定
├── install.sh                   # セットアップスクリプト
└── makefile
```

## セットアップ

### 初回セットアップ

```sh
./install.sh [HOSTNAME]
```

- Nix (Determinate Systems) のインストール
- nix-darwin のブートストラップ
- flake 設定の適用

ホスト名を省略すると macOS の `LocalHostName` が使われる（デフォルト: `MAOZBook`）。

### 設定の更新

```sh
make nix/build
# または
sudo nix run nix-darwin -- switch --flake ./nix/flake.nix
```
