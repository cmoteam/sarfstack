# Integrations — 外部ツール直結レイヤー

SARFStack の各スキルが外部サービス（Figma / Google / Meta / X / LinkedIn / HubSpot / Slack / Notion 等）と **直接** 接続するための共通カタログです。

> **位置づけ**: Integrations は SARF の **Set（データ取り込み）** と **Release（本番反映）** の両方を加速するための I/O 層です。Set で外部から数字・アセットを pull し、Release で成果物を push する両方向をカバーします。
> knowledge 層のどこにも書かれていない揮発データは、ここに列挙された接続経由で取得します。allowlist 外のソースは使いません（hallucination 防止）。

## Integration Catalog

各行は「どのスキルが / どのサービスに / どの MCP サーバ or API 経由で / 何のために」繋ぐかを示します。
**Auth / 設定の実体は `.mcp.json`（project-scoped）または `.claude/settings.local.json`（個人）に置き、本ファイルには書きません**。

### Design / Creative

| Service | 接続経由 | 用途 | 主に使うスキル |
|---------|---------|------|---------------|
| **Figma** | Figma Dev Mode MCP（公式） or figma-context-mcp | デザインファイル読取、LP/広告クリエイティブのスペック抽出、コンポーネント→HTML 生成 | `/ui-design` `/creative-direction` `/optimize-page` `/landing-page` |
| **Canva** | Canva MCP（公式）| テンプレート生成・バナー量産 | `/creative-direction` `/contents-edit` |

### Advertising Platforms

| Service | 接続経由 | 用途 | 主に使うスキル |
|---------|---------|------|---------------|
| **Google Ads** | Google Ads API（MCP ラッパー or Google Ads MCP） | キャンペーン構造・入札・パフォーマンス取得、入稿 | `/ads-manager` `/data-analytics` |
| **Meta Marketing** | Meta Graph API（MCP ラッパー） | Ads Manager のキャンペーン/広告セット/広告の取得・作成、Insights 取得 | `/ads-manager` `/data-analytics` |
| **X Ads** | X Ads API | キャンペーン管理・Insights | `/ads-manager` |
| **LinkedIn Ads** | LinkedIn Marketing API | Sponsored Content / Lead Gen Forms 管理 | `/ads-manager` |
| **TikTok Ads** | TikTok Marketing API | キャンペーン管理・Insights | `/ads-manager` |
| **Yahoo!広告 / LINEヤフー** | 公式API（国内向け） | 検索・ディスプレイの入稿・取得 | `/ads-manager` |

### Analytics / Measurement

| Service | 接続経由 | 用途 | 主に使うスキル |
|---------|---------|------|---------------|
| **Google Analytics 4** | GA4 Data API（MCP ラッパー） | セッション・CV・ファネルデータ取得 | `/data-analytics` `/seo` `/optimize-*` |
| **Google Search Console** | Search Console API | 検索クエリ・掲載順位・CTR・カバレッジ | `/seo` `/data-analytics` |
| **Google Tag Manager** | GTM API | タグ・トリガー・変数の監査 | `/data-analytics` `/ads-manager` |
| **Google BigQuery** | BigQuery MCP（公式） | 大規模ログ・アトリビューション分析 | `/data-analytics` |
| **Amplitude / Mixpanel** | 各社 MCP or API | プロダクトアナリティクス、ファネル・リテンション | `/data-analytics` `/optimize-onboarding` `/churn-prevention` |
| **PostHog** | PostHog MCP | プロダクトアナリティクス・Session Replay | `/optimize-*` `/data-analytics` |

### CRM / Revenue Ops

| Service | 接続経由 | 用途 | 主に使うスキル |
|---------|---------|------|---------------|
| **HubSpot** | HubSpot MCP（公式） | Contacts / Deals / Campaigns / Workflows | `/data-analytics` `/churn-prevention` `/pricing-strategy` |
| **Salesforce** | Salesforce MCP | Leads / Opportunities / アトリビューション | `/data-analytics` `/cmo-review` |
| **Stripe** | Stripe MCP（公式） | 課金・MRR・Churn・プラン | `/pricing-strategy` `/churn-prevention` `/data-analytics` |

### Content / Social / Comms

| Service | 接続経由 | 用途 | 主に使うスキル |
|---------|---------|------|---------------|
| **Notion** | Notion MCP（公式） | コンテンツカレンダー・ブリーフ管理 | `/contents-edit` `/campaign-launch` |
| **Slack** | Slack MCP（公式） | 承認フロー・通知・FAQ 収集 | `/campaign-launch` `/weekly-retro` `/customer-research` |
| **Google Drive / Docs** | Google Drive MCP（公式） | ドキュメント・スプレッドシート | `/contents-edit` `/estimate` `/customer-research` |
| **WordPress / Ghost / Webflow** | 各 CMS の MCP or REST API | ブログ記事の公開 | `/contents-edit` `/seo` |
| **YouTube Data API** | Google MCP ファミリー | 動画パフォーマンス・チャンネル分析 | `/data-analytics` `/contents-edit` |
| **Mailchimp / SendGrid / Customer.io** | 各社 MCP or API | メール配信・シーケンス | `/contents-edit` `/churn-prevention` |

### Customer / Research

| Service | 接続経由 | 用途 | 主に使うスキル |
|---------|---------|------|---------------|
| **Intercom / Zendesk** | 各社 MCP | サポートチケット・会話ログ・NPS | `/customer-research` `/churn-prevention` |
| **Typeform / SurveyMonkey** | API | アンケート回収 | `/customer-research` |
| **Gong / Chorus** | API | セールスコール書き起こし（Win/Loss） | `/customer-research` |

### Dev / Infra

| Service | 接続経由 | 用途 | 主に使うスキル |
|---------|---------|------|---------------|
| **GitHub** | GitHub MCP（本環境で利用可能） | LP コード・ドキュメント管理 | `/ui-design` `/optimize-*` `/seo` |
| **Vercel / Netlify** | 各社 MCP | LP デプロイ・Preview URL | `/landing-page` `/optimize-page` |

## How Skills Declare Integrations

各 SKILL.md には以下のフォーマットで「使う可能性のある integration」を宣言します。接続がなければ従来通り手入力 CSV でフォールバックします（オプトイン方式）。

```markdown
## Integrations（optional）

| Service | 用途 | Fallback |
|---------|------|----------|
| Google Ads MCP | キャンペーン・Insights 取得 | ユーザーが CSV を貼る |
| Meta Graph API | 広告セット・Insights 取得 | ユーザーが CSV を貼る |

接続時は `.mcp.json` の該当サーバが有効であることを前提に動作。未接続ならフォールバックに切り替え、本文冒頭でその旨を明示する。
```

## Configuration

### プロジェクト共有の MCP 設定

- ルートの [`.mcp.json.example`](../../.mcp.json.example) をコピーして `.mcp.json` を作成
- 環境変数（API Key / Token）は `.mcp.json` に直書きせず、`${ENV_VAR}` 展開か `.claude/settings.local.json` 経由で注入
- `.mcp.json` は `.gitignore` 対象（シークレットが混入しがちなため）

### 個人設定の MCP 追加

個人固有のサーバ（例: 手元の Notion ワークスペース）は `.claude/settings.local.json` に入れる。リポジトリには入れない。

### 最小セット（推奨）

初回セットアップで最低限入れるべき 5 つ:

1. **Figma MCP** — クリエイティブの実体を AI が読めるようにする
2. **Google Ads MCP + GA4 MCP** — 最も使用頻度の高い数字を自動取得
3. **Meta Graph API MCP** — もう片方の広告主軸
4. **Slack MCP** — 承認・通知・FAQ 収集
5. **GitHub MCP** — LP/ドキュメント管理

追加は運用が回ってからで十分。入れすぎは Context Window を圧迫する（不要な server は disconnect）。

## Guardrails

- **Write 操作は必ず承認ゲート経由**: Ads の配信ON/OFF、請求が発生するキャンペーン作成、本番DB 書込は必ず Release Gate を通す（ユーザー承認 → 実行）
- **Read-only から始める**: 接続直後は read-only で数週間運用し、挙動が安定してから write を解禁
- **Scopes を最小に**: Figma は Dev Mode の read、Google Ads は `adwords.readonly` 等、必要最小限から
- **PII / 顧客データの取扱**: Intercom / Zendesk / HubSpot 経由で取得した会話・メアドは `memory/results/` に生のまま置かない（匿名化 or 集計値のみ）
- **Rate Limit 配慮**: 大量取得はスクリプト化して都度呼ばない。`memory/results/performance-data.md` にキャッシュする設計を優先
- **Allowlist 思想**: Set 段階の web fetch と同じく、ここに列挙されたサービスのみ接続する。新しい接続を追加する時はまずこのファイルを PR 更新

## Feedback Loop

接続したツールから取得した数値 / アセットは、最終的には `/feedback` を経由して `memory/results/` と `knowledge/update/` に蓄積される。
「MCP から直接取れる」= 「Set / Feedback の自動化ができる」。接続が増えるほど SARF サイクルの回転速度が上がる。

- Ads / Analytics 系 → `/data-analytics` → `/feedback` → `memory/results/performance-data.md`
- Platform 公式ブログ → `/set-update`（既存の allowlist を通す）→ `knowledge/update/platform-updates.md`
- Figma / Canva → 各クリエイティブスキルがその場で消費（永続化不要）
- CRM / Stripe → `/data-analytics` + `/pricing-strategy` + `/churn-prevention` で共有

## References

- SARF サイクル全体: [`sarf-framework.md`](sarf-framework.md)
- MarTech / RevOps 観点: [`martech-revops.md`](martech-revops.md)
- Set の手動更新: [`../../skills/set-update/SKILL.md`](../../skills/set-update/SKILL.md)
- Feedback の書き戻し: [`../../skills/feedback/SKILL.md`](../../skills/feedback/SKILL.md)
