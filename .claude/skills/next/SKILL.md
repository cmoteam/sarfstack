---
name: next
description: 「今何をしたらいいかわからない」時に最初に押すスキル。現在の workspace 状態（Set 充足率・直近の Release / Feedback の有無）を見て、**次に踏むべき一歩を 1 つだけ** 推薦する。迷ったらこれ。
---

# Next — 迷ったらこれ

「何をしたらいいかわからない」「前回どこまでやったか忘れた」「このプロジェクトでAIに何を頼めるんだっけ」という状態からの入口。
現在のリポジトリ状態を最小限走査して、**次の一歩を1つだけ提案する**（ダッシュボードではなく「ボタン」）。

`/sarf-check` はこの `/next` の **詳細モード**（充足率・ブロッカー・Marketing Extension を多角的に可視化）です。迷ってる人向けの短い答えが欲しければ `/next`、数値ダッシュボードが欲しければ `/sarf-check`。

## SARF Alignment

- **Position**: Meta（SARF のどの段階かを判断して次の段階への入口を示す）
- **Set Preflight**: 不要（未完了の Set や workspace 未作成を検出することが責務）
- **Feedback Hook**: なし（推薦のみ、書き込み副作用なし）

## 動作

以下を **順番に** 確認し、最初に該当した条件に対応する推薦を出す。**最初にぶつかった壁だけ**を取り上げる（詳細は `/sarf-check`）。

### Step 0: Workspace が未作成（最優先 / ハード停止）

```bash
test -L memory/profile && test -d "$(readlink memory/profile | sed 's|^|memory/|')" || echo "NO_WORKSPACE"
ls memory/workspaces/ 2>/dev/null
```

- `memory/profile` symlink が存在しない、または `memory/workspaces/` が空
  - → **⚠️ 警告**: 「アクティブな workspace がありません。SARFStack は workspace（事業部・クライアント・プロダクト単位）を1つ作らないと動作しません」
  - → **推薦**: `/workspace new <slug>`（slug は実在する事業名: `acme-saas` / `client-beta` 等。**`default` は使わない**）
  - これ以降のステップはスキップし、ここで止める

### Step 0.5: Organization 層が未作成（organization 固有の壁）

```bash
test -d memory/organization || echo "NO_ORGANIZATION"
```

- `memory/organization/` が未存在
  - → **推薦**: `/set-organization` で組織情報（ミッション・ビジョン・ブランド）を対話で埋める
  - 代替: `cp -r memory/organization.example memory/organization` で手動ブートストラップ

### Step 1: Set 充足率（organization / profile の [TODO]）

```bash
grep -l "\[TODO\]" memory/organization/*.md memory/profile/*.md 2>/dev/null | wc -l
```

- organization ファイルの過半数に `[TODO]` が残っている
  - → **推薦**: `/set-organization` で組織情報を対話で埋める
- profile ファイル（workspace 固有）の過半数に `[TODO]` が残っている
  - → **推薦**: `/set-workspace` で workspace 固有情報を対話で埋める
- どちらも残る場合は organization を先に（上位コンテキスト優先）
  - 代替: 詳細診断なら `/sarf-check`

### Step 2: 直近の Results / Feedback

```bash
ls -t memory/results/*.md 2>/dev/null | head -1
```

- `memory/results/` が空 or 最終更新が 14 日以上前
  - → **推薦**: `/feedback` で直近の施策結果（数字＋定性）を記録
  - 代替: 数字が無いなら `/data-analytics` でまず集計

### Step 3: Release の有無で分岐

```bash
find output -name "*.md" -mtime -7 2>/dev/null | head -5
```

- **最近 Release したものがある**（7日以内）
  - → **推薦**: `/cmo-review` でその成果物をレビュー
  - 代替: `/ceo-review` / `/consultant-review`

- **Release が無い**（新規サイクル開始）
  - → **推薦**: 目的別に選ぶ
    - LP / ページ改善 → `/ui-design` or `/optimize-page`
    - コンテンツ制作 → `/contents-edit`
    - 広告配信 → `/ads-manager`
  - 1つに絞れなければ `/cmo-review` に「今期の優先順位は？」と投げる

### Step 4: 全部クリアならサイクルの次の波

- Set / Results / Release が揃っている
  - → **推薦**: `/sarf-check` で全体診断 → 次の波を決める

## アウトプット形式

短く、1スクリーンに収まる形で返す。

**Step 0 に該当した場合（workspace 未作成）** はこの形式を使わず、警告と `/workspace new <slug>` 誘導だけを返す:

```
⚠️  アクティブな workspace がありません

SARFStack は workspace（事業部 / クライアント / プロダクト単位）を1つ作らないと動作しません。
memory/profile / memory/results がどの workspace も指していない状態です。

👉 最初のステップ: /workspace new <slug>
   slug は実在する事業名を使います（例: acme-saas, client-beta）。
   ❌ default は使わないでください（複数事業を扱う時に境界が引けなくなります）。
```

**それ以外**:

```
🏄 今のあなたの SARF 状態

Active workspace : <slug>
Set 充足率       : N/5 ファイル（[TODO] 残 M 箇所）
直近の Feedback  : YYYY-MM-DD （または 「なし」）
直近の Release   : YYYY-MM-DD （または 「なし」）

👉 次の一歩: /<skill-name>
   理由: <なぜこれが最優先か、1〜2文>

もしこれを選ばないなら:
- /<代替1> — <短い動機>
- /<代替2> — <短い動機>
```

## 原則

- **1つだけ推薦する**。リストで迷わせない（代替は小さく併記）。
- **数字を先に出す**（充足率・経過日数）。主観で推薦しない。
- **理由を1〜2文で**。長い解説はしない。
- **見つからない情報は「なし」と明記**。「推測しない」。
- **workspace 未作成は最優先でブロック**。他のステップを先に走らせない。
- 書き込み副作用なし（推薦を返すだけ）。

## Integrations（optional）

外部連携は不要。ローカル走査のみ。
