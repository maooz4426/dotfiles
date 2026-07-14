# CLAUDE.md

読み込んだら「CLAUDE.mdを読み込みました」と報告してください。

## リポジトリ概要

Nix flakeベースのdotfilesで、`nix`配下に基本的な環境設定が書かれている。


## コマンド

```sh
# 設定の適用（ターゲットごと）
make nix/build/mac      # sudo nix run nix-darwin -- switch --flake ./nix/flake.nix
make nix/build/manix    # sudo nixos-rebuild switch --flake ./nix#manix
make nix/build/wsl      # home-manager switch --flake ./nix#maoz@wslnix

# 適用せずビルドのみ（「テスト」に相当 — CIは nix/check/manix を実行する）
make nix/check/mac
make nix/check/manix
make nix/check/wsl

# flakeの評価のみ検証（高速、CIが最初に実行する）
nix flake check ./nix --no-build

# サブモジュール（.claude はgitサブモジュール → github.com/maooz4426/.claude）
make submodule-init
make submodule-update

```

## アーキテクチャ

- nixに基本的に設定を記述する
- neovimの設定はlua、packageだけnixCatsにより、nixpackageを閲覧するように
- starshipは動作の関係でシンボリックリンクでみるようにしている

### Neovim (nixCats)

Neovimは `nix/home/modules/neovim.nix` でnixCatsフレームワークを使ってビルドされる:

- プラグインとLSPサーバーはLuaではなくNix側で宣言する（`categoryDefinitions` の `lsp`, `ui`, `editor`, `agents` カテゴリ）。
- Lua設定は `nvim/` にあり、`mkOutOfStoreSymlink` で `~/.config/nvim` にリンクされる — `nvim/**/*.lua` の編集はNixのリビルドなしで反映される。プラグインやLSPバイナリの追加・削除は `neovim.nix` を編集してリビルドが必要。
- `nvim/lua/plugins/` はNixのカテゴリ構成（lsp/, ui/, editor/, agents/）と対応しており、各プラグインのLua設定を置く。

### 規約

- unfreeパッケージは明示的な許可リストへの追加が必要（flake.nixのWSL home構成の `allowUnfreePredicate` を参照）。

