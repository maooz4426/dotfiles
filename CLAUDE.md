# CLAUDE.md

読み込んだら「CLAUDE.mdを読み込みました」と報告してください。

## リポジトリ概要

Nix flakeベースのdotfilesで、リポジトリルートの `flake.nix` を起点に `modules/`（再利用する部品）と `profiles/`（ホストごとの組み立て）で環境設定を管理する。

## コマンド

```sh
# 設定の適用（ターゲットごと）
make nix/build/mac      # sudo nix run nix-darwin -- switch --flake .#MAOZBook
make nix/build/manix    # sudo nixos-rebuild switch --flake .#manix
make nix/build/wsl      # home-manager switch --flake .#maoz@wslnix

# 適用せずビルドのみ（「テスト」に相当 — CIは nix/check/manix を実行する）
make nix/check/mac
make nix/check/manix
make nix/check/wsl

# flakeの評価のみ検証（高速、CIが最初に実行する）
nix flake check . --no-build

# サブモジュール（.claude はgitサブモジュール → github.com/maooz4426/.claude）
make submodule-init
make submodule-update

```

## アーキテクチャ

- `modules/home/` に home-manager の再利用モジュール（tmux・git・starship・zsh・cli・neovim等）を置く。全ホスト共通分は `modules/home/default.nix` がまとめてimportする。
- `modules/darwin/` に nix-darwin 用の再利用モジュール（borders等）を置く。
- `profiles/{darwin,nixos,wsl}/` に各プラットフォーム汎用の設定（`default.nix` がシステム層、`home.nix` がユーザー層）を置く。
- `profiles/maozbook/` はこのマシン固有の設定で、`profiles/darwin/` を import した上で Cask 一覧や開発環境などマシン固有分を足す。
- neovimの設定はlua、packageだけnixCatsにより、nixpackageを閲覧するように
- starshipは動作の関係でシンボリックリンクでみるようにしている

### Neovim (nixCats)

Neovimは `modules/home/neovim.nix` でnixCatsフレームワークを使ってビルドされる:

- プラグインとLSPサーバーはLuaではなくNix側で宣言する（`categoryDefinitions` の `lsp`, `ui`, `editor`, `agents` カテゴリ）。
- Lua設定は `nvim/` にあり、`mkOutOfStoreSymlink` で `~/.config/nvim` にリンクされる — `nvim/**/*.lua` の編集はNixのリビルドなしで反映される。プラグインやLSPバイナリの追加・削除は `neovim.nix` を編集してリビルドが必要。
- `nvim/lua/plugins/` はNixのカテゴリ構成（lsp/, ui/, editor/, agents/）と対応しており、各プラグインのLua設定を置く。

### 規約

- unfreeパッケージは明示的な許可リストへの追加が必要（flake.nixのWSL home構成の `allowUnfreePredicate` を参照）。

