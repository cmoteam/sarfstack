---
name: flow-landing-page
description: LP（ランディングページ）の設計→制作→最適化までを一貫して行うワークフロー
version: 1.0.0
---

# Landing Page — LP制作ワークフロー

LPの設計からコピーライティング、HTML/CSS実装、SEO最適化、CVR改善まで
一貫して行うワークフローです。そのまま使えるLP一式を出力します。

## SARF Alignment

- **Position**: Workflow（Ask → Release → Feedback設計）
- **Set Preflight**: `icp.md` `positioning.md` `brand-guidelines.md` の3つが揃っていないと LP コピーが刺さらない。開始前に `/sarf-check` を推奨、欠けていれば `/set-company` に先回りする
- **Feedback Hook**: 公開後の CVR・フォーム離脱率・ヒートマップ結果を `/data-analyst` → `/feedback` へ。A/B テスト結果は `performance-data.md` に時系列で蓄積する

**SARF上の位置づけ**: Step 1がAsk（戦略設計）、Step 2-6がRelease（制作・最適化を経てLPを本番公開）、Step 7がFeedback設計（計測の仕込み）です。公開後は `/data-analyst` でCVR実績を取得し、`memory/results/performance-data.md` に書き戻してサイクルを閉じてください。

## Workflow

```
Step 1: /ask-cmo        — LP戦略・構成設計
Step 2: /contents-editor    — LPコピーライティング
Step 3: /ui-designer        — UI実装・レビュー
Step 4: /seo-specialist     — SEO・技術最適化
Step 5: /creative-director  — 全体品質レビュー
Step 6: /ads-manager        — 広告連携設計
Step 7: /data-analyst       — 計測設計
```

## Step 1: Strategy & Structure（戦略・構成）

**エージェント**: `/ask-cmo`

LPの目的と構成を設計:
- LPの目的（リード獲得 / 購入 / 資料請求 / 問い合わせ）
- ターゲット（ICPのどのセグメント）
- オファー（何を提供するか）
- 成功KPI（CVR目標、CPA目標）
- ページ構成案

**推奨LP構成**:
```
1. Hero Section（課題提示 + 解決策 + CTA）
2. Problem（課題の深掘り）
3. Solution（解決策の詳細）
4. Features/Benefits（特徴とベネフィット）
5. Social Proof（事例・テスティモニアル・数字）
6. How it Works（使い方・導入フロー）
7. Pricing（料金 — 該当する場合）
8. FAQ
9. Final CTA
```

---

## Step 2: Copywriting（コピーライティング）

**エージェント**: `/contents-editor`

各セクションのコピーを執筆:
- ヒーローヘッドライン（複数パターン）
- サブヘッドライン
- 各セクションの本文
- CTAボタンテキスト（複数パターン）
- FAQ（5-10問）
- マイクロコピー（フォーム周り、信頼要素）

---

## Step 3: UI Implementation & Review（UI実装・レビュー）

**エージェント**: `/ui-designer`

Step 2のコピーを使ってLPをHTML/CSSで実装し、レビュー:
- レスポンシブ対応のHTML/CSS出力
- CVR最適化のベストプラクティス適用
- アクセシビリティ対応
- パフォーマンス最適化

---

## Step 4: SEO Optimization（SEO最適化）

**エージェント**: `/seo-specialist`

- title / meta description の最適化
- OGP設定
- 構造化データ（JSON-LD）
- Core Web Vitals対応
- canonical URL設定

---

## Step 5: Creative Quality Check（品質チェック）

**エージェント**: `/creative-director`

全体を通したクリエイティブ品質レビュー:
- メッセージの一貫性
- ブランド整合性
- 視覚的なインパクト
- APPROVE / REVISE / REWORK 判定

---

## Step 6: Ads Integration（広告連携）

**エージェント**: `/ads-manager`

LPへの流入経路となる広告の設計:
- Google検索広告のコピー
- Meta広告のコピー
- UTMパラメータ設計
- ターゲティング設定案

---

## Step 7: Measurement Setup（計測設計）

**エージェント**: `/data-analyst`

効果測定の設計:
- コンバージョン定義
- GA4イベント設計
- A/Bテスト設計（ヘッドライン、CTA、レイアウト）
- ヒートマップ設置推奨箇所

## How to Use

```
/flow-landing-page

# 以下の情報を提供してください:
# - LPの目的
# - ターゲット
# - オファー内容
# - 参考LP（あれば）
# - ブランドカラー/フォント指定（あれば）
```
