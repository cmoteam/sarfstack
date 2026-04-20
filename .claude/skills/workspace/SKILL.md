---
name: workspace
description: SARFStack のアクティブ workspace を切り替え・一覧・新規作成する。bin/workspace に委譲する薄いラッパー。
---

# Workspace

## SARF Alignment

- **Position**: Set（workspace コンテナ管理。Set の入れ物を作る前提操作）

`bin/workspace` に委譲します。以下のコマンドを Bash ツールで実行してください。

```
bin/workspace list                  # 一覧 + アクティブ表示
bin/workspace current               # アクティブ slug
bin/workspace new <slug>            # 新規作成 + 即アクティブ化
bin/workspace switch <slug>         # 切替
bin/workspace remove <slug>         # 削除（確認プロンプトあり）
```

## 注意事項

- `remove` は破壊的操作なので **必ずユーザー確認を取る**（bin/workspace 内でも確認する）
- slug は小文字英数字とハイフンのみ。`default` は禁止
- `new` 実行後は `bin/set-organization` → `bin/set-brand` → `bin/set-workspace` の順で情報を入力するよう案内する
