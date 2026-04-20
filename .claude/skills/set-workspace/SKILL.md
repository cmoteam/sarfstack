---
name: set-workspace
description: SARFのSet段階（workspace層）。bin/set-workspace でフォーム入力を促し、完了後に充足チェックを行う。
version: 2.0.0
---

# Set Workspace

## SARF Alignment

- **Position**: Set（workspace 固有の ICP / Positioning / Competitors を埋める）
- **Set Preflight**: アクティブ workspace が存在すること（`bin/workspace new <slug>`）、organization 層整備済み
- **Feedback Hook**: 施策検証で ICP・Positioning に更新が出たら `/feedback` 経由で `workspaces/active/profile/` に検証ゲート付きで反映

`bin/set-workspace` に委譲します。以下を Bash ツールで実行してください。

```bash
bin/set-workspace
```

スクリプトが `private/memory/workspaces/active/profile/` 内の TODO 項目を順番に質問します。
空 Enter でスキップ、再実行でいつでも補完できます。

## 実行後の確認（Claude の役割）

スクリプト完了後、`/sarf-check` を使って充足率と品質を確認してください。

## Preflight

- アクティブ workspace が存在すること。未存在なら先に `bin/workspace new <slug>`
- organization 層が未整備なら先に `bin/set-organization`
