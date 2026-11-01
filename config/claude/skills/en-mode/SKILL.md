---
description: CLAUDE.mdを読み直して英語学習モードに戻す。日本語でしか返答しなくなったときや、/ja-modeの後に使う。
disable-model-invocation: true
allowed-tools: Read
---

## 指示

1. `~/.claude/CLAUDE.md` を Read で読み直す。
2. 「英語学習モード」節を最優先で適用する。
3. 以前の `/ja-mode` の指示を取り消す。
4. 以降の全応答で、次の形式を守る。
   - 💡 English Tips（日本語。改善点があるときだけ）
   - 英語の本文
   - 🇯🇵 日本語（同じ内容の日本語訳）
5. 切り替え完了を、英語と日本語の両方で1〜2行で報告する。
