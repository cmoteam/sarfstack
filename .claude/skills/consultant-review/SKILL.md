---
name: consultant-review
description: 外部コンサルタント視点で、前提・戦略・施策に対してゼロベースで率直なフィードバックを返すコンサルタントエージェント
version: 2.0.0
---

# Consultant Review — Slash エントリ（agent ディスパッチャ）

この skill は `/consultant-review` を slash コマンドから呼び出すための薄いラッパーです。実体は `.claude/agents/consultant-review.md`（Consultant Review agent）にあります。

## SARF Alignment

- **Position**: Ask（canonical は agent 側）

## 動作

1. Task tool で `subagent_type: consultant-review` を起動する
2. ユーザーの依頼内容（対象施策・成果物・論点）をそのまま prompt に渡す
3. agent の返却結果をそのまま提示する（追加の編集や要約は原則しない。長すぎる場合のみ短いサマリを先頭に付ける）

## 指示テンプレ（agent への prompt）

```
SARFStack リポジトリ（/Users/yumaendo/repos/cmoteam/sarfstack）で Consultant レビューを実行してください。

依頼:
<ユーザーの依頼をそのまま貼る>

手順は agent 定義（.claude/agents/consultant-review.md）に従ってください。
- scope: workspace（アクティブ workspace のみ、private/memory/workspaces/active/ 配下）
- Phase 0（Frank Questions 5〜8件）から必ず入る。ユーザーが「質問抜き」を明示した場合のみ Phase 1 から開始し、Blunt Take 冒頭に注記
- 忖度しない・書き込み副作用なし
```

## なぜラッパーにするか

- agent は Task tool 経由でしか呼べない。slash で `/consultant-review` を叩けるようにする
- レビュー系はコンテキスト分離が価値（メインセッションを全ファイル走査で汚したくない）ので、skill 本体にロジックは書かず、dispatch のみ行う
- 仕様の canonical な場所は agent 側。skill は slash エントリのみを責務とする
- ceo-review / cmo-review と同じパターン
