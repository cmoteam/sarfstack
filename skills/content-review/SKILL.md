---
name: content-review
description: コンテンツの企画→制作→多角的レビュー→公開までのサイクルを回すワークフロー
version: 1.0.0
---

# Content Review — コンテンツレビューワークフロー

コンテンツ（ブログ記事、SNS投稿、メール等）を制作し、
SEO・クリエイティブ・戦略の各観点からレビューして品質を担保するワークフローです。

**SAAF上の位置づけ**: Step 1がAction（制作）、Step 2-4が複数視点からのAsk（レビュー）、Step 5が本番Action（公開）です。公開後はセットで `/analytics` を走らせ、Feedbackをknowledge/latestに還元することでサイクルを閉じてください。

## Workflow

```
SAAF:              Action →        Ask (多角レビュー)        → Action (公開)

Step 1: /content      — コンテンツの企画・制作
Step 2: /seo          — SEO観点のレビュー・最適化
Step 3: /creative-director — 品質・ブランド整合性のレビュー
Step 4: /cmo-review   — 戦略整合性の最終確認
Step 5: Publish       — 公開チェックリスト
Step 6 (後工程): /analytics — 公開後のFeedback収集 → knowledge/latest/ に反映
```

## Step 1: Content Creation（制作）

**エージェント**: `/content`

入力:
- テーマ / トピック
- ターゲットキーワード（あれば）
- コンテンツタイプ（ブログ / SNS / メール / LP）
- 文字数目安
- 公開チャネル

出力:
- 完成原稿
- メタ情報（title, description）
- CTAの提案

---

## Step 2: SEO Review（SEOレビュー）

**エージェント**: `/seo`

`/content` の成果物を受け取り、SEO観点でレビュー・最適化:
- キーワードの配置は適切か
- メタ情報は最適化されているか
- 見出し構造はSEOフレンドリーか
- 内部リンクの提案
- 構造化データの追加提案

修正が必要な場合、具体的な修正案を提示。

---

## Step 3: Creative Review（クリエイティブレビュー）

**エージェント**: `/creative-director`

SEO最適化後のコンテンツを、品質・ブランド観点でレビュー:
- メッセージの明確さ
- ブランドの声との一致
- 文章の品質（リズム、冗長さ、具体性）
- 読者の感情への訴求力

APPROVE / REVISE / REWORK を判定。

---

## Step 4: Strategic Review（戦略レビュー）

**エージェント**: `/cmo-review`

最終的な戦略整合性チェック:
- ICPに刺さるコンテンツか
- 全体のコンテンツ戦略と整合しているか
- タイミング・チャネルは適切か

---

## Step 5: Publish Checklist（公開チェック）

```markdown
## Pre-Publish Checklist

### Content
- [ ] 誤字脱字の最終確認
- [ ] リンク切れチェック
- [ ] 画像のalt属性設定
- [ ] OGP設定

### SEO
- [ ] title tagの確認
- [ ] meta descriptionの確認
- [ ] canonical URLの設定
- [ ] 構造化データの確認

### Distribution
- [ ] SNS展開用の要約/ティーザー準備
- [ ] メールニュースレター用の要約準備
- [ ] 内部リンクの設置（既存記事から新記事へ）
```

## How to Use

```
/content-review

# 以下の情報を提供してください:
# - テーマ / トピック
# - ターゲットキーワード（あれば）
# - コンテンツタイプ
# - その他の要件
```
