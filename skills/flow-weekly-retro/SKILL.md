---
name: flow-weekly-retro
description: 週次マーケティング振り返りを実施し、来週のアクションプランを策定するワークフロー
version: 1.0.0
---

# Weekly Retro — 週次マーケティング振り返り

毎週のマーケティング活動を振り返り、データに基づいた改善サイクルを回すワークフローです。
形式的な報告ではなく、具体的なネクストアクションを導出します。

## SARF Alignment

- **Position**: Workflow（Feedback → Set 還元）
- **Set Preflight**: 今週の施策ログと数値が手元にあることが前提。なければ `/data-analyst` を先に実行してから戻ってくる
- **Feedback Hook**: Step 5 で `/set-latest` と `/feedback` を必ず呼び出す。これを省略するとサイクルが閉じず、次週の Set 精度が今週と同じレベルに留まる

**SARF上の位置づけ**: このワークフローは **Feedback → Set** のブリッジを担います。今週のRelease結果（実配信された施策）を数値と定性で集約し、来週の Set（特に `memory/results/` `knowledge/latest/` `memory/company/`）を更新するのが最終目的です。単なる報告会ではなく、AIの次のサイクルの入力精度を上げる儀式として位置づけてください。

## Workflow

```
SARFでの位置: ──Release結果── → Feedback集約 → Setに還元 → 次のAsk

Step 1: /data-analyst — 週次パフォーマンスレポート（Feedbackの数値面）
Step 2: /ask-cmo  — 戦略的インサイトの抽出（Feedbackの定性面）
Step 3: /ask-ceo  — 経営インパクトの評価
Step 4: Next Week    — 来週のアクションプラン策定（次のAsk）
Step 5: Knowledge    — 知識ベースの更新（Setへの還元）
```

## Step 1: Performance Analysis（パフォーマンス分析）

**エージェント**: `/data-analyst`

直近1週間のデータを分析:

### Input Required
- 各チャネルの主要KPI（提供可能な範囲で）
- 実施した施策の一覧
- 発生した問題・トラブル

### Output
- 週次パフォーマンスダッシュボード
- 前週比・目標比の分析
- ファネル分析
- チャネル別パフォーマンス
- 異常値・特筆事項

---

## Step 2: Strategic Insights（戦略的インサイト）

**エージェント**: `/ask-cmo`

`/data-analyst` の結果を受けて、戦略的な視点で解釈:

- 数字の裏にある「Why」の考察
- チャネルミックスの見直し必要性
- コンテンツ戦略の修正必要性
- 競合の動きとの関連
- 今週の学び（What worked / What didn't / Why）

---

## Step 3: Business Impact（経営インパクト）

**エージェント**: `/ask-ceo`

経営視点での評価:
- 売上・収益への貢献度
- CAC/LTVトレンド
- 投資効率の評価
- リソース配分の妥当性
- 経営上の意思決定が必要な事項

---

## Step 4: Next Week Plan（来週のアクションプラン）

今週の分析結果を踏まえて、来週のアクションプランを策定:

```markdown
## Next Week Action Plan

### Must Do（必須）
| # | Action | Owner | KPI | Deadline |
|---|--------|-------|-----|----------|
| 1 | ... | /ads-manager | ... | Mon |
| 2 | ... | /contents-editor | ... | Wed |
| 3 | ... | /seo-specialist | ... | Fri |

### Should Do（推奨）
| # | Action | Owner | KPI |
|---|--------|-------|-----|
| 1 | ... | ... | ... |

### Experiments（実験）
| # | Hypothesis | Test Method | Success Criteria |
|---|-----------|-------------|-----------------|
| 1 | ... | A/B test | CVR +X% |
```

---

## Step 5: Knowledge Update（知識更新 = SARFのSetへの還元）

**このステップを省略するとSARFのループが閉じません。**
振り返りの中で得られた情報を専用スキルで知識ベースに反映し、次サイクルのSetを強化します:

1. **`/set-latest` を実行** — 今週の実測値を `performance-data.md` に、新トレンドを `industry-trends.md` に、仕様変更を `platform-updates.md` に書き戻す
2. **`/feedback` を実行** — 検証済み知見（ICPの解像度向上、ポジショニングの微修正等）の company 層反映を検証ゲート付きで処理する

**注意**: 未検証の仮説をcompany層に直書きしない。必ず `/feedback` の検証ゲートを通すこと。Set層の汚染は以降の全出力を歪めます。

---

## Output Format

```markdown
# Weekly Marketing Retro: [YYYY/MM/DD week]

## This Week's Scorecard
| Metric | Target | Actual | Status |
|--------|--------|--------|--------|
| ... | ... | ... | 🟢/🟡/🔴 |

## Key Wins
1. ...

## Key Misses
1. ...

## Lessons Learned
1. ...

## Decisions Made
1. ...

## Next Week Priorities
1. ...
2. ...
3. ...

## Knowledge Base Updates
- [ ] performance-data.md updated
- [ ] Other updates needed: ...
```

## How to Use

```
/flow-weekly-retro

# 以下の情報を提供してください:
# - 今週実施した施策の概要
# - 各チャネルの主要KPI（わかる範囲で）
# - 特筆すべき出来事（トラブル、発見など）
```

## Cadence

毎週金曜日または月曜日に実施を推奨。
定期実行する場合は `/loop` と組み合わせて自動リマインドを設定できます。
