---
paths:
  - "**/*.go"
---

# Go実装ポリシー

## Interface guard
- インターフェースを実装する型には、必ずコンパイル時のinterface guardを書く。
- 型定義の直後に置く。
  `var _ Repository = (*userRepository)(nil)`
- 値レシーバで実装する型は `var _ Repository = userRepository{}` と書く。

## テスト
- テストは原則テーブル駆動で書く（`[]struct{ name string; ... }` + `t.Run`）。
- テストケース名（`name`）は必ず接頭辞で始める。
  - 正常系: `正常: <内容>`
  - 異常系: `異常: <内容>`
- 境界値などの特殊ケースも、正常または異常のどちらかの接頭辞を付ける。
