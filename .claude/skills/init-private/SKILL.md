---
name: init-private
description: SARFStack の private/ をブートストラップする。private/memory/organization・private/memory/workspaces・private/output・private/README.md を生成する。`bin/init-private` に委譲する薄いラッパー。
version: 1.0.0
---

# Init Private

## SARF Alignment

- **Position**: Set 段階の起点（private/ のディレクトリ構造を用意する）
- **Set Preflight**: なし（これ自体が起点）
- **Feedback Hook**: なし

`bin/init-private` に委譲します。以下を Bash ツールで実行してください。

```bash
bin/init-private
```

生成されるもの（既に存在する場合はスキップ）:

- `private/README.md` — private/ 運用ガイド（`templates/private/README.md` から）
- `private/memory/organization/` — 組織層テンプレ一式（`templates/memory/organization/` から）
- `private/memory/workspaces/` — workspace 置き場（空ディレクトリ）
- `private/output/` — 全スキルの成果物置き場（空ディレクトリ）

既存の organization を再生成したいときは `bin/init-private --force`。

## 実行後の次ステップ

1. `/set-organization` — 組織情報を入力
2. `/set-brand` — ブランドガイドラインを入力
3. `/workspace new <slug>` — 最初の workspace を作成
4. `/next` — 次の一歩を確認
