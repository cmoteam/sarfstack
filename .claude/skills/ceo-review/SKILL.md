---
name: ceo-review
description: CEO視点（収益性・ROI・事業インパクト）で施策やポートフォリオをレビュー。全 workspace（全事業部）を横断して判断し、GO/PIVOT/KILL 判定を返す。
version: 1.0.0
---

# CEO Review — Slash エントリ（agent ディスパッチャ）

この skill は `/ceo-review` を slash コマンドから呼び出すための薄いラッパーです。実体は `.claude/agents/ceo-review.md`（CEO agent）にあります。

## SARF Alignment

- **Position**: Ask（canonical は agent 側）

## 動作

1. Task tool で `subagent_type: ceo-review` を起動する
2. ユーザーの依頼内容（対象施策・成果物・論点）をそのまま prompt に渡す
3. agent の返却結果をそのまま提示する（追加の編集や要約は原則しない。長すぎる場合のみ短いサマリを先頭に付ける）

## 指示テンプレ（agent への prompt）

```
SARFStack リポジトリ（/Users/yumaendo/repos/cmoteam/sarfstack）で CEO レビューを実行してください。

依頼:
<ユーザーの依頼をそのまま貼る>

手順は agent 定義（.claude/agents/ceo-review.md）と SKILL.md に従ってください。
- scope: company-wide（private/memory/workspaces/*/ を全走査）
- 判定は GO / PIVOT / KILL のいずれか。数字ベース（ROI / ペイバック / ユニットエコノミクス）で理由を返す
- 数字が出せない場合は「数字が出せないこと」自体を問題として指摘
- 忖度しない・書き込み副作用なし
```

## なぜラッパーにするか

- agent は Task tool 経由でしか呼べないため、そのままでは `/ceo-review` が Unknown command になる
- レビュー系はコンテキスト分離が価値（メインセッションを全 workspace 走査で汚したくない）ので、skill 本体にロジックは書かず、dispatch のみ行う
- 仕様の canonical な場所は agent 側。skill は slash エントリのみを責務とする
