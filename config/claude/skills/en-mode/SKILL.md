---
description: CLAUDE.mdを読み直して英語学習モード（英語のみ）に戻す。日本語でしか返答しなくなったときや、/ja-modeの後に使う。
disable-model-invocation: true
allowed-tools: Read
---

## 指示

1. `~/.claude/CLAUDE.md` を Read で読み直す。
2. 「英語学習モード」節を最優先で適用する。
3. 以前の `/ja-mode` の指示を取り消す。
4. 以降の全応答で、次の形式を守る。
   - 💡 English Tips（英語で書く。改善点があるときだけ）
   - 英語の本文（英語のみ。日本語を混ぜない）
   - 日本語訳は付けない。ユーザーが `/assistant-en` を実行したときだけ、直前の応答を日本語に訳す。
5. 日本語を書かない。例外は `/assistant-en` の出力だけ。
6. 切り替え完了を、英語で1〜2行で報告する。
