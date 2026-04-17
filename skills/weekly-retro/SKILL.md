---
name: weekly-retro
description: 週次マーケティング振り返りを実施し、来週のアクションプランを策定するワークフロー
version: 1.0.0
---

# Weekly Retro — 週次マーケティング振り返り

毎週のマーケティング活動を振り返り、データに基づいた改善サイクルを回すワークフローです。
形式的な報告ではなく、具体的なネクストアクションを導出します。

**SAAF上の位置づけ**: このワークフローは **Feedback → Set** のブリッジを担います。今週のAction結果を数値と定性で集約し、来週の Set（特に `knowledge/latest/` と `knowledge/company/`）を更新するのが最終目的です。単なる報告会ではなく、AIの次のサイクルの入力精度を上げる儀式として位置づけてください。

## Workflow

```
SAAFでの位置: ──Action結果── → Feedback集約 → Setに還元 → 次のAsk

Step 1: /analytics   — 週次パフォーマンスレポート（Feedbackの数値面）
Step 2: /cmo-review  — 戦略的インサイトの抽出（Feedbackの定性面）
Step 3: /ceo-review  — 経営インパクトの評価
Step 4: Next Week    — 来週のアクションプラン策定（次のAsk）
Step 5: Knowledge    — 知識ベースの更新（Setへの還元）
```

## Step 1: Performance Analysis（パフォーマンス分析）

**エージェント**: `/analytics`

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

**エージェント**: `/cmo-review`

`/analytics` の結果を受けて、戦略的な視点で解釈:

- 数字の裏にある「Why」の考察
- チャネルミックスの見直し必要性
- コンテンツ戦略の修正必要性
- 競合の動きとの関連
- 今週の学び（What worked / What didn't / Why）

---

## Step 3: Business Impact（経営インパクト）

**エージェント**: `/ceo-review`

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
| 1 | ... | /ads | ... | Mon |
| 2 | ... | /content | ... | Wed |
| 3 | ... | /seo | ... | Fri |

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

## Step 5: Knowledge Update（知識更新 = SAAFのSetへの還元）

**このステップを省略するとSAAFのループが閉じません。**
振り返りの中で得られた情報を知識ベースに反映し、次サイクルのSetを強化します:

- `knowledge/latest/performance-data.md` の更新（実測値を記録）
- `knowledge/latest/industry-trends.md` に新しいトレンドがあれば追記
- `knowledge/latest/platform-updates.md` にプラットフォーム変更があれば追記
- 検証済みの知見（ICPの解像度向上、ポジショニングの微修正）があれば `knowledge/company/*.md` も更新

**注意**: 未検証の仮説をcompany層に書かないこと。Set層の汚染は以降の全出力を歪めます。

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
/weekly-retro

# 以下の情報を提供してください:
# - 今週実施した施策の概要
# - 各チャネルの主要KPI（わかる範囲で）
# - 特筆すべき出来事（トラブル、発見など）
```

## Cadence

毎週金曜日または月曜日に実施を推奨。
定期実行する場合は `/loop` と組み合わせて自動リマインドを設定できます。
