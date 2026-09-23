---
description: Pull Requestを安全に作成する。PRを作りたいとき、gh pr createを実行したいときに使う。
allowed-tools: Bash, Read, Glob
---

## 現在の状態
!`git branch --show-current`
!`git remote show origin | grep 'HEAD branch'`
!`git status --short`

## Step 1: デフォルトブランチの取得

`git remote show origin | grep 'HEAD branch'` の出力からデフォルトブランチ名を取得する。`main` と決め打ちしない。

## Step 2: デフォルトブランチ保護チェック（最重要）

現在のブランチ == デフォルトブランチ の場合：

1. diffの内容からブランチ名の候補を提案する（例: `feat/add-login`, `fix/null-pointer`）
2. ユーザーにブランチ名を確認する
3. 承認されたら以下を実行してブランチを切り替え、そのままPR作成フローを続ける

```bash
git checkout -b <branch-name>
```

## Step 3: 差分の確認

以下を並列実行する：
```
git log origin/<default>..HEAD --oneline
git diff origin/<default>..HEAD --stat
```

コンフリクトがある場合は即停止して報告する。

## Step 4: コンテキスト収集

以下があれば読む：
- `.github/pull_request_template.md`
- `CONTRIBUTING.md`

ユーザーに関連issueがあるか確認する。

## Step 5: PR内容の生成

diffを読んでタイトルと本文を生成する。

**タイトル形式**: `<type>: <summary>`（70文字以内）
- type: `feat` / `fix` / `refactor` / `docs` / `chore` / `test`

**本文形式**:
- Step 4 で対象リポジトリの `.github/pull_request_template.md` が見つかった場合はそれに従う
- 見つからなかった場合は `~/.claude/.github/pull_request_template.md` を Read で読み、その構成に従う

## Step 6: ユーザー確認（必須・実行前に必ず行う）

以下を明示してユーザーに確認を取る：

1. **draft** にするか ready にするか
2. **base ブランチ**: `<検出したデフォルトブランチ>` であることを明示
3. **レビュアー**をアサインするか

## Step 7: 実行

```bash
gh pr create \
  --base <default-branch> \
  --title "<title>" \
  --body "$(cat <<'EOF'
<body>
EOF
)" \
  [--draft]
```

## 禁止事項

- デフォルトブランチへの直push（必ずユーザー確認）
- デフォルトブランチ上でのPR作成（必ずブランチを切ってから行う）
- コンフリクトがある状態でのPR作成（即停止して報告）
- `main` / `master` の決め打ち
