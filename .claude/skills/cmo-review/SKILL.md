---
name: cmo-review
description: Group CMO 視点で、全 workspace（全事業部）を横断したマーケティング戦略の整合性・優先順位・リソース配分を統括レビュー。workspace 間のチャネル重複・ブランド一貫性・予算配分も見る。
version: 1.0.0
---

# CMO Review — Slash エントリ（agent ディスパッチャ）

この skill は `/cmo-review` を slash コマンドから呼び出すための薄いラッパーです。実体は `.claude/agents/cmo-review.md`（Group CMO agent）にあります。

## SARF Alignment

- **Position**: Ask（canonical は agent 側）

## 動作

1. Task tool で `subagent_type: cmo-review` を起動する
2. ユーザーの依頼内容（対象施策・成果物・論点）をそのまま prompt に渡す
3. agent の返却結果をそのまま提示する（追加の編集や要約は原則しない。長すぎる場合のみ短いサマリを先頭に付ける）

## 指示テンプレ（agent への prompt）

```
SARFStack リポジトリ（/Users/yumaendo/repos/cmoteam/sarfstack）で Group CMO レビューを実行してください。

依頼:
<ユーザーの依頼をそのまま貼る>

手順は agent 定義（.claude/agents/cmo-review.md）と SKILL.md に従ってください。
- scope: company-wide（private/memory/workspaces/*/ を全走査）
- [TODO] 残存は Set 不足として明記
- 忖度しない・書き込み副作用なし
```

## なぜラッパーにするか

- agent は Task tool 経由でしか呼べないため、そのままでは `/cmo-review` が Unknown command になる
- レビュー系はコンテキスト分離が価値（メインセッションを全 workspace 走査で汚したくない）ので、skill 本体にロジックは書かず、dispatch のみ行う
- 仕様の canonical な場所は agent 側。skill は slash エントリのみを責務とする
