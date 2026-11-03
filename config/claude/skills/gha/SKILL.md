---
description: GitHub Actionsのワークフローの下地を作る。GHAを組みたいとき、workflowを作りたいとき、CIを追加したいときに使う。
allowed-tools: Bash, Read, Glob, Write, AskUserQuestion
---

## 現在の状態
!`git branch --show-current`
!`ls .github/workflows 2>/dev/null`
!`ls go.mod package.json flake.nix makefile Makefile pyproject.toml Cargo.toml 2>/dev/null`

## Step 1: 現状把握

- `.github/workflows/` の既存ファイルを読む。命名とスタイルを合わせる。
- 言語とビルドツールを確認する（`go.mod`、`package.json`、`flake.nix`、`makefile` 等）。
- `makefile` がある場合、lint・test・build のターゲットを読む。

## Step 2: ヒアリング（必須・生成前に必ず行う）

AskUserQuestion で以下を確認する。推測で埋めない。

1. **実行内容**: lint / test / build / その他（複数選択可）
2. **トリガー**: `push` / `pull_request` / `workflow_dispatch` / `schedule`、対象ブランチ、`paths` の絞り込みの有無
3. **言語とバージョン**: 例: Go 1.x、Node 20
4. **実行コマンド**: Step 1 で見つけた makefile ターゲットを候補にする
5. **runner**: `ubuntu-latest` / `macos-latest` 等
6. **デプロイ系か**: デプロイ系の場合、Step 4 の `cancel-in-progress` を `false` にするか確認する

## Step 3: コミットハッシュの固定（必須）

使用する各 action について以下を行う。

1. 最新の安定タグを取得する。
   ```bash
   gh api repos/<owner>/<repo>/releases/latest --jq .tag_name
   ```
2. タグをコミットSHAに解決する。注釈付きタグは `^{}` の行を採用する。
   ```bash
   git ls-remote https://github.com/<owner>/<repo> refs/tags/<tag> 'refs/tags/<tag>^{}'
   ```
3. 次の形式で書く。SHAは40桁、コメントにタグを書く。
   ```yaml
   - uses: actions/checkout@<40桁SHA> # v4.2.2
   ```

- `@v4` や `@main` のようなタグ・ブランチ参照を書かない。
- SHAを推測で書かない。解決できない action は書かずに報告する。

## Step 4: concurrencyの設定（必須）

トップレベルに必ず書く。

```yaml
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true
```

- デプロイ系は `cancel-in-progress: false` にする。

## Step 5: 下地の出力

- 生成する内容をユーザーに見せ、承認を得てから `.github/workflows/<name>.yml` に書く。
- `permissions: contents: read` をトップレベルに書く。追加の権限が必要なジョブにだけ、ジョブ単位で付ける。
- `name`、`on`、`concurrency`、`permissions`、`jobs` の順に書く。

## Step 6: 検証

- `actionlint` がある場合は実行する。
- 全 `uses:` が40桁SHAであることを確認する。
  ```bash
  grep -nE 'uses:' .github/workflows/<name>.yml | grep -vE '@[0-9a-f]{40}'
  ```
  出力が空であれば合格。ローカル action（`./`）は対象外とする。

## 禁止事項

- タグ・ブランチ参照の `uses:`
- `concurrency` の省略
- 確認なしのコミットと push
- ヒアリングを省略した生成
