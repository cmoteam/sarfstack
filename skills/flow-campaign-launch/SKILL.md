---
name: flow-campaign-launch
description: キャンペーンの企画→制作→レビュー→ローンチまでの全工程を統合的に実行するワークフロー
version: 1.0.0
---

# Campaign Launch — キャンペーンローンチワークフロー

このワークフローは、マーケティングキャンペーンの企画から実行までの全工程を
1つのサイクルとして回します。各フェーズで適切な専門エージェントを呼び出し、
成果物を次のエージェントに引き継ぎます。

## SARF Alignment

- **Position**: Workflow（Set → Ask → Release → Feedback の1サイクルを完結）
- **Set Preflight**: Phase 0 で `/sarf-check` 相当の診断を必ず実行。company 層の充足率 < 70% なら `/set-company` を先に走らせるようユーザーに確認する（推定モードで進めることも可能だが明示必須）
- **Feedback Hook**: Phase 6 完了時に `/feedback` を必ず呼び出し、キャンペーン結果を knowledge 層に還元。Feedback を省略するとサイクルが閉じない
- **[Optional] Campaign Funnel Stage**: キャンペーン全体のメインターゲット段階（TOFU / MOFU / BOFU）。指定があれば各 Phase の専門エージェント呼び出し時に `Target Funnel Stage` として引き継ぐ
- **[Optional] Campaign Segment**: キャンペーンの Primary Segment。指定があれば `/ask-cmo` `/contents-editor` `/ads-manager` 等に `Target Segment` として引き継ぐ
- **[Optional] Campaign Primary KPI**: キャンペーン成功の単一判定指標（CPA / ROAS / パイプライン額 / サインアップ数等）。指定があれば各 Phase の KPI として引き継ぎ、Phase 6 の Feedback 軸に採用
- **[Optional] Release Gate (Phase 5)**: 本番ローンチ前にトラッキング実装・ベースライン記録・承認ログを計測チェックリストで確認する（Marketing Extension の Release 計測完了条件）

**SARF上の位置づけ**: このワークフローは **Set → Ask → Release → Feedback** の1サイクルを丸ごと包括します。Phase 0でSet（knowledge/の確認）、Phase 1-2-3がAsk、Phase 4-5がRelease（経営承認と本番ローンチ）、Phase 6がFeedbackに対応します。

## Workflow Overview

```
SARF:         Set        Ask              Release           Feedback
              ↓          ↓                ↓                 ↓
Phase 0: Set          → knowledge/* の確認（[TODO]が残っていないか）
Phase 1: Strategy     → /ask-cmo（戦略設計）
Phase 2: Creative     → /creative-director + /contents-editor + /ads-manager（制作）
Phase 3: Technical    → /seo-specialist + /ui-designer（技術最適化）
Phase 4: Executive    → /ask-ceo（経営承認）
Phase 5: Launch       → 最終チェックリスト + ローンチ（Release）
Phase 6: Measure      → /data-analyst（効果測定）→ memory/results/ に還元
```

## Phase 0: Set Check（前提確認）

キャンペーン設計に入る前に、SARFのSetが揃っているかを確認:

- [ ] `memory/company/company-overview.md` に現状の数字が入っているか
- [ ] `memory/company/icp.md` のICPが具体的か（「20代女性」レベルで止まっていないか）
- [ ] `memory/company/positioning.md` に競合との差別化軸があるか
- [ ] `memory/company/brand-guidelines.md` にトーン&マナーが定義されているか
- [ ] `memory/results/performance-data.md` に直近のベースライン数値があるか

いずれかに `[TODO]` が残る場合、その項目はAIが推定で埋めることになります。推定で進めるか、先にSetを埋めるかをユーザーに確認してください。

## Phase 1: Strategy（戦略設計）

**エージェント**: `/ask-cmo`

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

**エージェント**: `/creative-director` + `/contents-editor` + `/ads-manager`

Phase 1の戦略書に基づき、必要なクリエイティブを制作する。

### 2a: コンセプト開発（`/creative-director`）
- キャンペーンのクリエイティブコンセプト策定
- メッセージのフレームワーク（What to say / How to say）
- トーン&マナーの方向性確定

### 2b: コンテンツ制作（`/contents-editor`）
- LP用コピー（ヒーロー、ベネフィット、FAQ、CTA）
- ブログ記事/コンテンツ（必要な場合）
- SNS投稿文
- メール文面（ナーチャリング/プロモーション）

### 2c: 広告設計（`/ads-manager`）
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

**エージェント**: `/seo-specialist` + `/ui-designer`

### 3a: SEO最適化（`/seo-specialist`）
- LP/コンテンツのSEO最適化
- メタタグ、構造化データの設定
- 内部リンク設計

### 3b: UI/UXレビュー（`/ui-designer`）
- LPのUI/UXレビュー
- コンバージョン最適化
- レスポンシブ対応確認
- 修正コードの出力

---

## Phase 4: Executive Review（経営承認）

**エージェント**: `/ask-ceo`

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

**エージェント**: `/data-analyst`

ローンチ後の効果測定サイクル。**SARFのFeedback段階**であり、次サイクルのSetを更新する起点です:

- **Day 1-3**: 初期パフォーマンスチェック（配信は正常か、異常値はないか）
- **Week 1**: 初回パフォーマンスレポート + 初期最適化提案
- **Week 2-4**: 定常運用 + 週次レポート + 最適化サイクル
- **Campaign End**: 最終レポート + 学びの整理 + 次回への提言

### Optimization Loop（最適化ループ = SARFの小サイクル）

```
SARF:   Feedback      →  Ask        →  Release           →  Feedback
/data-analyst（分析）  →  /ask-cmo（判断）→  /ads-manager or /contents-editor（改善本番反映）→  /data-analyst（再分析）
```

キャンペーン終了時には、得られた知見を `memory/results/performance-data.md` に書き戻してサイクルを閉じてください。

## How to Use

```
/flow-campaign-launch

# 以下の情報を提供してください:
# - キャンペーンの目的
# - ターゲット
# - 予算
# - 期間
# - 使いたいチャネル（任せる場合は「おまかせ」）
```

ワークフローは各フェーズで成果物を出力し、ユーザーの承認を得てから次のフェーズに進みます。
