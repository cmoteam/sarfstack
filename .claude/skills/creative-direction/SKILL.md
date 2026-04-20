---
name: creative-direction
description: クリエイティブディレクター視点で、コピー・ビジュアル・LP・広告素材のブランド一貫性とトーン&マナーをレビュー。アクティブ workspace のブランドガイドラインと照合し、適合度スコアと修正指示を返す。
version: 2.0.0
---

# Creative Direction — Slash エントリ（agent ディスパッチャ）

この skill は `/creative-direction` を slash コマンドから呼び出すための薄いラッパーです。実体は `.claude/agents/creative-direction.md`（Creative Director agent）にあります。

## SARF Alignment

- **Position**: Ask（canonical は agent 側）

## 動作

1. Task tool で `subagent_type: creative-direction` を起動する
2. ユーザーの依頼内容（対象クリエイティブ・論点・スコア基準）をそのまま prompt に渡す
3. agent の返却結果をそのまま提示する（追加の編集や要約は原則しない。長すぎる場合のみ短いサマリを先頭に付ける）

## 指示テンプレ（agent への prompt）

```
SARFStack リポジトリ（/Users/yumaendo/repos/cmoteam/sarfstack）で Creative レビューを実行してください。

依頼:
<ユーザーの依頼をそのまま貼る>

手順は agent 定義（.claude/agents/creative-direction.md）に従ってください。
- scope: workspace（アクティブ workspace の brand-guidelines / positioning / icp を基準）
- [TODO] 残存は Set 不足として明記（brand-guidelines → /set-brand、positioning → /set-workspace）
- APPROVE / REVISE / REWORK 判定を必ず返す
- 忖度しない・書き込み副作用なし
```

## なぜラッパーにするか

- agent は Task tool 経由でしか呼べないため、そのままでは `/creative-direction` が Unknown command になる
- レビュー系はコンテキスト分離が価値（メインセッションを全ファイル走査で汚したくない）ので、skill 本体にロジックは書かず、dispatch のみ行う
- 仕様の canonical な場所は agent 側。skill は slash エントリのみを責務とする
- ceo-review / cmo-review / consultant-review と同じパターン
