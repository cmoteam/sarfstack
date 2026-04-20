---
name: set-brand
description: SARFのSet段階（brand層）。bin/set-brand でフォーム入力を促し、完了後に充足チェックを行う。
version: 2.0.0
---

# Set Brand

## SARF Alignment

- **Position**: Set（organization 層のブランドガイドラインを埋める）
- **Set Preflight**: `bin/set-organization` 完了済み（organization コンテキストが前提）
- **Feedback Hook**: 実配信後のブランド反応（トーン受容度・認知調査）は `/feedback` 経由で `organization/brand-guidelines.md` に検証ゲート付きで反映

`bin/set-brand` に委譲します。以下を Bash ツールで実行してください。

```bash
bin/set-brand
```

スクリプトが `private/memory/organization/brand-guidelines.md` の TODO 項目を順番に質問します。
空 Enter でスキップ、再実行でいつでも補完できます。

## 実行後の確認（Claude の役割）

スクリプト完了後、`/sarf-check` を使ってブランドガイドラインの充足率と一貫性を確認してください。

## Preflight

- `bin/set-organization` が完了していること（organization コンテキストが前提）
