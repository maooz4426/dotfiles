# dotfiles

Nix flake ベースのdotfiles。macOS・NixOS・WSL2 を1つのflakeで管理する。


## ディレクトリ構成

```
dotfiles/
├── flake.nix              # エントリーポイント（4つの構成を出力）
├── makefile                # 適用・ビルド確認コマンド
├── install.sh              # macOS初回セットアップ
├── modules/
│   ├── darwin/             # nix-darwin用モジュール（borders.nix）
│   └── home/                # home-manager共通モジュール
│       ├── default.nix      # 全ホスト共通分をimportする
│       └── nixvim/          # Neovim設定（ui / editor / lsp / agents）
├── profiles/
│   ├── darwin/              # macOS汎用（default.nix=システム, home.nix=ユーザー）
│   ├── maozbook/             # MAOZBook固有（Cask一覧・開発環境）
│   ├── nixos/                # manix
│   └── wsl/                  # wslnix
├── starship/starship.toml  # starship設定（starship.nixが読む）
└── .github/workflows/       # CI
```

## セットアップ

### 初回セットアップ（macOS）

```sh
./install.sh [HOSTNAME]
```

- Nix (Determinate Systems) のインストール
- nix-darwinのブートストラップ
- flake設定の適用

ホスト名を省略するとmacOSの `LocalHostName` が使われる。

### 設定の適用

```sh
make nix/build/mac      # MAOZBookへ適用
make nix/build/manix    # manixへ適用
make nix/build/wsl      # maoz@wslnixへ適用
```

### ビルド確認（適用しない）

```sh
make nix/check/mac
make nix/check/manix
make nix/check/wsl

# flakeの評価のみ検証（高速）
nix flake check . --no-build
```

## Neovim (nixvim)

Neovimは `modules/home/nixvim.nix` がnixvimで1つのパッケージとしてビルドする。`nvim` / `vim` / `vi` はそのラッパースクリプト。

設定はNixで宣言する。`modules/home/nixvim/` の各モジュールを見る。

- `config.nix` — rootモジュール（leader、opts、autocmds、keymaps）
- `ui.nix` — テーマ、UI系プラグイン
- `editor.nix` — treesitter、telescope等
- `lsp.nix` — LSPサーバーとcmp
- `agents.nix` — claudecode連携

設定変更にはリビルドが必要（`make nix/build/mac` 等）。旧nixCats構成にあった `mkOutOfStoreSymlink` による即時反映は無い。例外は `modules/home/nixvim/lua/alpha.lua` のみで、生のLuaを残している。

## CI

`.github/workflows/ci.yml` が `main` へのpush・PRで以下を実行する。

1. `nix flake check . --no-build`
2. `make nix/check/manix`
