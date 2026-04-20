---
name: seo
description: SEO 視点で、キーワード戦略・技術 SEO 監査・コンテンツ最適化・サイト構造をレビュー。アクティブ workspace の ICP・Positioning・競合 SERP を前提に実装可能な改善案を返す。
version: 1.0.0
---

# SEO Review — Slash エントリ（agent ディスパッチャ）

この skill は `/seo` を slash コマンドから呼び出すための薄いラッパーです。実体は `.claude/agents/seo.md`（SEO Specialist agent）にあります。

## SARF Alignment

- **Position**: Ask（canonical は agent 側）

## 動作

1. Task tool で `subagent_type: seo` を起動する
2. ユーザーの依頼内容（対象ページ・KW 戦略・論点）をそのまま prompt に渡す
3. agent の返却結果をそのまま提示する（追加の編集や要約は原則しない。長すぎる場合のみ短いサマリを先頭に付ける）

## 指示テンプレ（agent への prompt）

```
SARFStack リポジトリ（/Users/yumaendo/repos/cmoteam/sarfstack）で SEO レビューを実行してください。

依頼:
<ユーザーの依頼をそのまま貼る>

手順は agent 定義（.claude/agents/seo.md）に従ってください。
- scope: workspace（アクティブ workspace の ICP / Positioning / competitors を前提）
- [TODO] 残存は Set 不足として明記
- KW 戦略評価 / 技術 SEO 監査 / コンテンツ最適化案 / 実装案（コード片まで）を返す
- 忖度しない・書き込み副作用なし
```

## なぜラッパーにするか

- agent は Task tool 経由でしか呼べないため、そのままでは `/seo` が Unknown command になる
- レビュー系はコンテキスト分離が価値（メインセッションを全ファイル走査で汚したくない）ので、skill 本体にロジックは書かず、dispatch のみ行う
- 仕様の canonical な場所は agent 側。skill は slash エントリのみを責務とする
- ceo-review / cmo-review / consultant-review / creative-direction と同じパターン
