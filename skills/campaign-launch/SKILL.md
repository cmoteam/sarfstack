---
name: campaign-launch
description: キャンペーンの企画→制作→レビュー→ローンチまでの全工程を統合的に実行するワークフロー
version: 1.0.0
---

# Campaign Launch — キャンペーンローンチワークフロー

このワークフローは、マーケティングキャンペーンの企画から実行までの全工程を
1つのサイクルとして回します。各フェーズで適切な専門エージェントを呼び出し、
成果物を次のエージェントに引き継ぎます。

## SAAF Alignment

- **Position**: Workflow（Set → Ask → Action → Feedback の1サイクルを完結）
- **Set Preflight**: Phase 0 で `/saaf-check` 相当の診断を必ず実行。company 層の充足率 < 70% なら `/set-company` を先に走らせるようユーザーに確認する（推定モードで進めることも可能だが明示必須）
- **Feedback Hook**: Phase 6 完了時に `/feedback` を必ず呼び出し、キャンペーン結果を knowledge 層に還元。Feedback を省略するとサイクルが閉じない

**SAAF上の位置づけ**: このワークフローは **Set → Ask → Action → Feedback** の1サイクルを丸ごと包括します。Phase 0でSet（knowledge/の確認）、Phase 1-2-3がAsk、Phase 4-5がAction、Phase 6がFeedbackに対応します。

## Workflow Overview

```
SAAF:         Set        Ask              Action            Feedback
              ↓          ↓                ↓                 ↓
Phase 0: Set          → knowledge/* の確認（[TODO]が残っていないか）
Phase 1: Strategy     → /cmo-review（戦略設計）
Phase 2: Creative     → /creative-director + /content + /ads（制作）
Phase 3: Technical    → /seo + /ui-review（技術最適化）
Phase 4: Executive    → /ceo-review（経営承認）
Phase 5: Launch       → 最終チェックリスト + ローンチ
Phase 6: Measure      → /analytics（効果測定）→ knowledge/latest/ に還元
```

## Phase 0: Set Check（前提確認）

キャンペーン設計に入る前に、SAAFのSetが揃っているかを確認:

- [ ] `knowledge/company/company-overview.md` に現状の数字が入っているか
- [ ] `knowledge/company/icp.md` のICPが具体的か（「20代女性」レベルで止まっていないか）
- [ ] `knowledge/company/positioning.md` に競合との差別化軸があるか
- [ ] `knowledge/company/brand-guidelines.md` にトーン&マナーが定義されているか
- [ ] `knowledge/latest/performance-data.md` に直近のベースライン数値があるか

いずれかに `[TODO]` が残る場合、その項目はAIが推定で埋めることになります。推定で進めるか、先にSetを埋めるかをユーザーに確認してください。

## Phase 1: Strategy（戦略設計）

**エージェント**: `/cmo-review`

ユーザーからキャンペーンの概要を受け取り、以下を定義する:

### Input Required
- キャンペーンの目的（認知/リード獲得/売上/etc.）
- ターゲットオーディエンス
- 予算（概算でOK）
- 期間
- 使用チャネル（または推薦を希望）

### Output
- [ ] キャンペーン戦略書
- [ ] KPI設定（Primary + Secondary）
- [ ] チャネルミックスと予算配分案
- [ ] タイムライン
- [ ] 必要なクリエイティブ一覧

---

## Phase 2: Creative（制作）

**エージェント**: `/creative-director` + `/content` + `/ads`

Phase 1の戦略書に基づき、必要なクリエイティブを制作する。

### 2a: コンセプト開発（`/creative-director`）
- キャンペーンのクリエイティブコンセプト策定
- メッセージのフレームワーク（What to say / How to say）
- トーン&マナーの方向性確定

### 2b: コンテンツ制作（`/content`）
- LP用コピー（ヒーロー、ベネフィット、FAQ、CTA）
- ブログ記事/コンテンツ（必要な場合）
- SNS投稿文
- メール文面（ナーチャリング/プロモーション）

### 2c: 広告設計（`/ads`）
- 各プラットフォームの広告コピー
- ターゲティング設計
- 入札戦略
- UTMパラメータ設計
- 入稿データ準備

### Quality Gate
`/creative-director` がすべての制作物をレビュー:
- ブランド一貫性チェック
- メッセージ品質チェック
- APPROVE / REVISE / REWORK の判定

---

## Phase 3: Technical Optimization（技術最適化）

**エージェント**: `/seo` + `/ui-review`

### 3a: SEO最適化（`/seo`）
- LP/コンテンツのSEO最適化
- メタタグ、構造化データの設定
- 内部リンク設計

### 3b: UI/UXレビュー（`/ui-review`）
- LPのUI/UXレビュー
- コンバージョン最適化
- レスポンシブ対応確認
- 修正コードの出力

---

## Phase 4: Executive Review（経営承認）

**エージェント**: `/ceo-review`

すべての制作物と戦略を経営視点でレビュー:
- ビジネス妥当性の最終確認
- 予算対効果の検証
- GO / PIVOT / KILL 判定

**PIVOTの場合**: 該当フェーズに差し戻し、修正後に再レビュー
**KILLの場合**: Phase 1に戻るか、キャンペーンを中止

---

## Phase 5: Launch Checklist（ローンチ前チェック）

ローンチ前の最終確認チェックリスト:

### 戦略
- [ ] KPIが明確に定義されている
- [ ] ターゲティングが適切
- [ ] 予算配分が確定

### クリエイティブ
- [ ] すべてのコピーがレビュー済み
- [ ] ブランドガイドラインに準拠
- [ ] 誤字脱字チェック完了
- [ ] 法務チェック（景表法、薬機法等）該当する場合

### テクニカル
- [ ] LP公開済み・動作確認済み
- [ ] トラッキングコード設置確認（GA4, コンバージョンタグ）
- [ ] UTMパラメータ確認
- [ ] レスポンシブ表示確認
- [ ] ページ表示速度確認

### 広告
- [ ] 入稿データ準備完了
- [ ] ターゲティング設定確認
- [ ] 入札戦略設定確認
- [ ] 予算設定確認
- [ ] 配信スケジュール確認

---

## Phase 6: Measurement & Feedback（効果測定とSetへの還元）

**エージェント**: `/analytics`

ローンチ後の効果測定サイクル。**SAAFのFeedback段階**であり、次サイクルのSetを更新する起点です:

- **Day 1-3**: 初期パフォーマンスチェック（配信は正常か、異常値はないか）
- **Week 1**: 初回パフォーマンスレポート + 初期最適化提案
- **Week 2-4**: 定常運用 + 週次レポート + 最適化サイクル
- **Campaign End**: 最終レポート + 学びの整理 + 次回への提言

### Optimization Loop（最適化ループ = SAAFの小サイクル）

```
SAAF:   Feedback      →  Ask        →  Action            →  Feedback
/analytics（分析）    →  /cmo-review（判断）→  /ads or /content（改善実行）→  /analytics（再分析）
```

キャンペーン終了時には、得られた知見を `knowledge/latest/performance-data.md` に書き戻してサイクルを閉じてください。

## How to Use

```
/campaign-launch

# 以下の情報を提供してください:
# - キャンペーンの目的
# - ターゲット
# - 予算
# - 期間
# - 使いたいチャネル（任せる場合は「おまかせ」）
```

ワークフローは各フェーズで成果物を出力し、ユーザーの承認を得てから次のフェーズに進みます。
