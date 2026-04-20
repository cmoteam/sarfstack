# SARFStack Agents — Virtual Marketing Organization

SARFStackは、Claude Code / Codex 上で動作する仮想マーケティング組織です。
企業のマーケティング担当者、スタートアップのグロース担当、広告代理店の担当者が、
AIエージェントチームと協働してマーケティング業務を遂行するためのフレームワークです。
各エージェントはSKILL.mdで定義され、明確な責務・入力・出力を持ちます。
全エージェントは **SARF**（Set / Ask / Release / Feedback）サイクル(読み:「サーフ」)の特定の段階を担います。

> このファイル（`CLAUDE.md`）が canonical なプロジェクト定義です。`AGENTS.md` はこのファイルを参照するスタブになっています（Codex など他ハーネス向け）。

## Operating Model — SARF

SARFStackの全スキルは **SARF** サイクルの上で動作します。SARFは **AI時代のマーケティングOS** であり、個別のマーケティングフレームワーク（AARRR・STP・RAM-CE等）の上位に位置して、それらをAI協働下で機能させるための型を定義します。読みは「**サーフ**」で、波乗りのメタファー(波待ち→波の見極め→ライディング→次の波を読む)と整合しています。

> **位置づけ**: SARF は「AI協働の汎用フレームワーク」ではなくマーケティング特化のOSです。各段階にマーケ固有のディメンション（ファネル段階 / セグメント / ユニットエコノミクス / KPI / アトリビューション）を重ねる **Marketing Extension** によって特化性を担保しています。Extension は optional（詳細は `knowledge/base/sarf-framework.md` の末尾を参照）。

```
Set ─→ Ask ─→ Release ─→ Feedback ─┐
 ↑                                    │
 └────────────────────────────────────┘
```

- **S — Set**: 自分の情報（事業・ICP・ブランド・数字・制約）をAIに伝える
- **A — Ask**: AIとのコミュニケーション。誰の視点で・何を・どの形式で出させるか問いを組む
- **R — Release**: 出てきたアイデアの中から判断して**本番環境に反映**する（本番反映して初めて完了）
- **F — Feedback**: 結果をAIに戻してリファインし、次のSetを更新する

SARFの各段階はSARFStackの構造に対応しています:

| SARF | SARFStackでの担い手（単体スキル） |
|------|-----------------|
| Set | `/set-organization` `/set-workspace` `/set-update` `/sarf-check` + `knowledge/`（base / update）と `memory/`（organization / profile / results） |
| Ask | レビュー系スキル（`/cmo-review` `/ceo-review` `/consultant-review` `/seo` `/creative-direction` 等） |
| Release | 制作系スキル（`/contents-edit` `/ads-manager` `/estimate` 等） |
| Feedback | 分析系スキル（`/data-analytics`）＋ `/feedback`（検証ゲート付きで results/ 生データと profile/ 検証済み知見に還元） |

```
Set（情報を渡す）      → /set-organization /set-workspace /set-update + knowledge/（base） + memory/（organization / per-project）
Meta（サイクル診断）   → /sarf-check
Ask（問いに答える）    → /ceo-review /cmo-review /consultant-review /creative-direction /seo /ui-design
Release（本番反映）    → /contents-edit /ads-manager /estimate
Feedback（結果を戻す） → /data-analytics /feedback → knowledge 層に還元
```

> **Workflows は単一段階の担い手ではなく、複数段階を横断して繋ぐ統合レイヤー** です。単体スキルの組み合わせで Set→Ask→Release→Feedback を1コマンドで回すための束ねであり、上表のどの行にも属しません。各 workflow がカバーする段階は後述の [Workflow Chains](#workflow-chains) を参照してください。

単体スキルを使う場合も、この位置づけを意識することで正しい期待値を持てます。
レビュー系に「完成品」を求めたり、制作系に「戦略判定」を求めたりすると、SARFの段階がズレて成果が出ません。

全ての SKILL.md には冒頭に `SARF Alignment` セクション（Position / Set Preflight / Feedback Hook）があります。詳細は `knowledge/base/sarf-framework.md` を参照。

## Available Skills

以下のスラッシュコマンドで各エージェントを呼び出せます:

### 🏄 困ったら最初にこれ
- **`/next`** — 「今何をしたらいいかわからない」時の入口。現在の workspace 状態を見て次の一歩を**1つだけ**推薦する。workspace 未作成もここで検出される（`/sarf-check` は `/next` の詳細モード）。

### Workspace Ops（ワークスペース管理）
- `/workspace` — アクティブ workspace の一覧・切替・新規作成（`memory/workspaces/<slug>/` と `memory/profile`/`memory/results` symlink を操作）。事業部・クライアント・プロダクト等、SARF Set が独立して成立する単位ごとに分離する。

### SARF Ops（サイクル運用）
- `/set-organization` — Set段階（organization層）。組織全体の情報（ミッション・ビジョン・ブランド・事業ポートフォリオ）を対話でヒアリングし `memory/organization/` を埋める
- `/set-workspace` — Set段階（workspace層）。アクティブ workspace の情報（事業概要・ICP・Positioning・競合）を対話でヒアリングし `memory/profile/` を埋める
- `/set-update` — Set段階。業界トレンド・プラットフォーム仕様変更を `knowledge/update/` に書き戻す（自社実績は対象外 → `/feedback`）
- `/sarf-check` — `/next` の詳細モード。Set充足率・ブロッカー・Marketing Extension を多角的に可視化
- `/feedback` — Feedback段階。施策結果を検証ゲート付きで knowledge 層に反映

### Executive Review（経営レビュー）
- `/ceo-review` — 収益性・ビジネス観点からの施策レビュー
- `/cmo-review` — マーケティング戦略全体の統括レビュー
- `/consultant-review` — 外部コンサルタント視点でのゼロベース率直フィードバック

### Specialist Agents（専門エージェント）
- `/seo` — SEO分析・キーワード戦略・技術SEO監査
- `/ui-design` — LP/広告クリエイティブのUI/UXレビュー
- `/ads-manager` — 広告運用（Google/Meta/X）の設計・分析・最適化
- `/creative-direction` — クリエイティブの品質・ブランド一貫性チェック
- `/contents-edit` — コンテンツマーケティング（記事・SNS・メール）
- `/data-analytics` — KPI分析・レポーティング・アトリビューション
- `/estimate` — 見積り・工数計算・費用対効果シミュレーション（代理店視点）
- `/customer-research` — 顧客インタビュー・JTBD・Win/Loss 分析（ICPをデータで鍛える）
- `/pricing-strategy` — 価格設定・プラン設計・パッケージング戦略
- `/churn-prevention` — 解約防止・リテンション改善・Save Offer 設計

### Optimization Agents（最適化スペシャリスト）
訪問・サインアップ・購入など、各ファネル段階でのユーザー行動完了率（CVR）を数字で上げるための診断・改修を専門領域とする。
`/ui-design` が UI/UX 全般を見るのに対し、最適化系はファネル段階ごとの CVR に特化して診断と改修コードを出します。

- `/optimize-page` — マーケティングページ全般（LP/Product/Feature/Pricing/About等）のCVR最適化
- `/optimize-signup-flow` — サインアップフロー（登録〜初回ログイン）の完了率最適化
- `/optimize-onboarding` — オンボーディング・Activation・Aha Moment 到達率の最適化
- `/optimize-form` — リード獲得フォーム（デモ/資料DL/お問い合わせ）の完了率最適化
- `/optimize-popup` — ポップアップ・モーダル・オーバーレイの設計と最適化
- `/optimize-paywall` — Paywall・Upgrade モーダル・アプリ内アップセルのCVR最適化

### Workflows（統合ワークフロー / SARF 複数段階を横断）
単体スキルとは別レイヤー。Set→Ask→Release→Feedback の複数段階を1コマンドで繋ぐ束ね役で、どれか1つの段階に属するわけではありません（カバー範囲は [Workflow Chains](#workflow-chains) 参照）。配置先は `.claude/workflows/<name>/SKILL.md`（単体スキルの `.claude/skills/` とは分離）。

**未実装**（設計のみ。以下は今後 `.claude/workflows/` 配下に実装予定）:
- `/campaign-launch` — キャンペーン企画→制作→レビュー→ローンチの全工程（Set〜Feedback 全域）
- `/content-review` — コンテンツ制作→多角的レビューサイクル（Set〜Feedback 全域）
- `/landing-page` — LP設計→制作→最適化サイクル（Set〜Feedback 全域）
- `/weekly-retro` — 週次マーケティング振り返り（Feedback 起点で次サイクルの Set へ閉じる）

## Organization Chart

```
   ┌──────────────┐         ┌──────────────┐
   │ Set Company  │◀───────▶│ SARF Check   │◀── いつでも診断
   │ Set Update   │         │  (Meta)      │
   └──────┬───────┘         └──────────────┘
          │ Set が揃ったら
          ▼
   ┌─────────────┐
   │  CEO Review  │  収益性・ビジネス判断
   └──────┬──────┘
          │
   ┌──────┴──────┐
   │  CMO Review  │  マーケティング戦略統括
   └──────┬──────┘
          │
┌────────┬───────┼───────┬────────┐
│        │       │       │        │
┌────┴───┐┌───┴──┐┌──┴──┐┌───┴──┐┌────┴─────┐
│Creative ││ SEO  ││ Ads ││  UI  ││ Content  │
│Director ││      ││     ││Review││          │
└────┬────┘└───┬──┘└──┬──┘└───┬──┘└────┬─────┘
     │         │      │       │        │
     └─────────┴──────┼───────┴────────┘
                      │
               ┌──────┴──────┐
               │  Analytics   │  効果測定
               └──────┬──────┘
                      │
               ┌──────┴──────┐
               │  Feedback    │  検証ゲート→knowledge還元
               └─────────────┘
                      │
                      └──── 次サイクルのSetへ
```

## Agent Definitions

### Set Organization (`/set-organization`)
- **役割**: 組織プロフィールを対話でヒアリングし `memory/organization/` を埋める
- **入力**: ユーザーの組織・ミッション・ブランド・事業ポートフォリオに関する情報（崩れた文体でも可）
- **出力**: organization-overview.md / brand-guidelines.md への書き込み + 充足率サマリー
- **知識**: organization + sarf-framework
- **トリガー**: 組織の初回セットアップ、ブランド更新時、新規事業追加時

### Set Workspace (`/set-workspace`)
- **役割**: workspace 固有情報を対話でヒアリングし `memory/profile/` を埋める
- **入力**: 事業概要・ICP・Positioning・競合に関する情報（崩れた文体でも可）
- **出力**: business-overview.md / icp.md / positioning.md / competitors.md への書き込み + 充足率サマリー
- **知識**: profile + organization + sarf-framework
- **トリガー**: workspace 初回セットアップ、ICP や Positioning 更新時

### Set Update (`/set-update`)
- **役割**: 最新数値・トレンド・仕様変更を `knowledge/update/` に書き戻す
- **入力**: パフォーマンスデータ、業界ニュース、プラットフォーム仕様変更
- **出力**: 3つの update ファイルの更新 + 更新サマリー
- **知識**: update + sarf-framework
- **トリガー**: 週次（performance-data）、月次（industry-trends）、仕様変更時（platform-updates）

### SARF Check (`/sarf-check`)
- **役割**: SARFサイクルの現在地を診断し、充足率と次の一手を提示
- **入力**: なし（knowledge/ を走査）
- **出力**: 診断ダッシュボード + 推奨アクション Top 3
- **知識**: knowledge/ 全層
- **トリガー**: 任意のタイミング、特にプロジェクト開始時・フェーズ切替時

### Feedback (`/feedback`)
- **役割**: 施策結果を検証ゲート付きで knowledge 層に反映
- **入力**: 数字（KPI実績）＋定性（顧客反応・学び）
- **出力**: カテゴリ分類（反映 / 候補 / 却下）＋ diff ベースの書き込み
- **知識**: base/sarf-framework + profile + update
- **トリガー**: キャンペーン終了時、`/weekly-retro` の Step 5

### CEO Review (`/ceo-review`)
- **役割**: 経営者の視点で施策の収益性・ROI・事業インパクトを評価
- **入力**: マーケティング施策案、予算計画、KPI設定
- **出力**: GO / PIVOT / KILL 判定 + 理由 + 改善指示
- **知識**: base + profile
- **トリガー**: 新規施策の承認前、大型予算の投下前

### CMO Review (`/cmo-review`)
- **役割**: マーケティング戦略全体の整合性・優先順位・リソース配分を統括
- **入力**: 個別施策、チャネル戦略、ファネル設計
- **出力**: 戦略評価レポート + 優先順位マトリクス + 具体的な改善指示
- **知識**: base + profile
- **トリガー**: 施策の企画段階、四半期計画、チャネルミックスの見直し

### SEO Specialist (`/seo`)
- **役割**: 検索エンジン最適化の分析・戦略立案・技術監査・実装
- **入力**: URL、キーワード候補、コンテンツ原稿、サイト構造
- **出力**: キーワード戦略、技術SEO監査レポート、コンテンツ最適化案、実装コード
- **知識**: base + profile + update
- **トリガー**: コンテンツ制作時、サイト改修時、順位変動時

### Consultant Review (`/consultant-review`)
- **役割**: 外部コンサルタント視点で、前提・戦略・施策に対してゼロベースの率直なフィードバックを返す
- **入力**: 戦略・施策・意思決定プロセス（前提・制約・想定を含む）
- **出力**: 前提の棚卸し、聖域の指摘、Kill候補、ゼロベース再設計案
- **知識**: base + profile + update + results
- **トリガー**: 戦略の停滞感、施策のマンネリ化、四半期／年次見直し、CMOレビューで「整ってはいるが伸びない」判定が出たとき

### Creative Director (`/creative-direction`)
- **役割**: クリエイティブの品質管理・ブランド一貫性・トーン&マナーの監督
- **入力**: コピー、ビジュアル案、LP構成、広告クリエイティブ
- **出力**: クリエイティブ評価 + 具体的な修正指示 + ブランド適合度スコア
- **知識**: base + profile（特にbrand-guidelines）
- **トリガー**: クリエイティブ制作後のレビュー、ブランドガイドライン更新時

### UI Designer (`/ui-design`)
- **役割**: マーケティング用のLP・広告LPのUI/UXレビューと改善
- **入力**: HTML/CSS、デザインファイル、ワイヤーフレーム
- **出力**: UI改善提案 + 修正済みコード + コンバージョン最適化案
- **知識**: base + profile + update
- **トリガー**: LP制作後、A/Bテスト設計時、CVR改善施策時

### Ads Manager (`/ads-manager`)
- **役割**: デジタル広告（Google/Meta/X等）の設計・運用・最適化
- **入力**: 広告アカウント情報、クリエイティブ、ターゲティング設定、パフォーマンスデータ
- **出力**: 広告設計書、入稿データ、最適化提案、予算配分案
- **知識**: base + profile + update
- **トリガー**: 新規キャンペーン設計時、パフォーマンス悪化時、予算見直し時

### Contents Editor (`/contents-edit`)
- **役割**: コンテンツマーケティング（ブログ・SNS・メール・ホワイトペーパー）の企画・制作
- **入力**: テーマ、ターゲット、チャネル、参考情報
- **出力**: 完成原稿 + SEO対応メタ情報 + 配信スケジュール案
- **知識**: base + profile + update
- **トリガー**: コンテンツカレンダー更新時、キャンペーン企画時

### Data Analyst (`/data-analytics`)
- **役割**: マーケティングKPIの分析・レポーティング・アトリビューション・改善提案
- **入力**: パフォーマンスデータ、KPI目標、ファネルデータ
- **出力**: 分析レポート + インサイト + ネクストアクション提案
- **知識**: base + profile + update
- **トリガー**: 週次/月次レビュー、異常値検出時、施策効果測定時

### Customer Research (`/customer-research`)
- **役割**: 顧客インタビュー・JTBD・Win/Loss 分析を設計・実施支援し、ICP を仮説から実証データに昇華
- **入力**: 既存 ICP / Positioning、調査テーマ、Primary Question
- **出力**: インタビュー設計書・質問票・調査レポート・ICP/Positioning 改定案
- **知識**: base + profile（ICP/Positioning/competitors）+ results
- **トリガー**: ICP 検証、四半期レビュー、新市場参入前、解約率悪化時

### Pricing Strategy (`/pricing-strategy`)
- **役割**: 価格モデル・プラン構造・価格点・パッケージング境界を設計・レビュー
- **入力**: 既存プラン、LTV/ARPU、競合価格、ICP の価格感度
- **出力**: 新プラン表、Value Metric 推奨、Migration Plan、実験計画
- **知識**: base + profile（business-overview/competitors）+ update + results
- **トリガー**: Free→Paid 停滞、競合価格変動、プラン数/構造の限界、新プロダクトローンチ

### Churn Prevention (`/churn-prevention`)
- **役割**: 解約防止とリテンション改善。解約タイプ分類・キャンセルフロー再設計・Save Offer 設計
- **入力**: Churn Rate、解約理由、Cohortリテンション、LTV
- **出力**: キャンセルフロー改修案、Save Offer Matrix、Early Warning System、リエンゲージメントメール
- **知識**: base + profile + update + results
- **トリガー**: Churn 率悪化時、NRR 低下時、Involuntary Churn 多発時

### Page Optimization (`/optimize-page`)
- **役割**: マーケティングページ全般（LP/Product/Feature/Pricing/About 等）のCVR最適化
- **入力**: URL or HTML、現状 CVR、ページ目的、流入元
- **出力**: CVR 診断スコア、Top CVR Killers、HTML/CSS 修正コード、A/B テストロードマップ
- **知識**: base + profile + update + results
- **トリガー**: 新規ページ公開後、CVR 悪化時、広告との Message Match 不整合疑い時

### Signup Flow Optimization (`/optimize-signup-flow`)
- **役割**: サインアップフロー（登録〜初回ログイン到達）の完了率最適化
- **入力**: 現状フロー、ステップ別完了率、ICP
- **出力**: Funnel Map + Drop-off 分析、改修フロー、フィールド再設計、実装コード
- **知識**: base + profile + update + results
- **トリガー**: Signup Completion 悪化時、メール認証離脱増加時、ソーシャル/SSO 導入検討時

### Onboarding Optimization (`/optimize-onboarding`)
- **役割**: オンボーディング・Aha Moment 到達・Activation の最適化
- **入力**: 現状 Activation フロー、リテンションデータ、既存ユーザー行動
- **出力**: Aha Moment 定義、Activation Funnel 分析、Guidance Mode 推奨、Lifecycle Email 計画
- **知識**: base + profile + update + results
- **トリガー**: Activation 率悪化、D1/D7 リテンション悪化、Early Churn 多発

### Form Optimization (`/optimize-form`)
- **役割**: リード獲得フォーム（デモ/資料DL/問い合わせ/ウェビナー）の完了率最適化
- **入力**: 現状フォーム、フィールド構成、営業プロセスでの利用状況
- **出力**: Field-by-field Audit、改修フォーム、コピー改善、A/B テスト計画
- **知識**: base + profile + update + results
- **トリガー**: リード数不足、フォーム CVR 悪化時、営業フィードバック取得時

### Popup Optimization (`/optimize-popup`)
- **役割**: ポップアップ・モーダル・オーバーレイの設計と最適化（UX Guardrail 込み）
- **入力**: 現状ポップアップ、表示トリガー、Capture Rate、メインファネル影響
- **出力**: Justification Check、トリガー再設計、コピー/UI、Guardrail Metrics
- **知識**: base + profile + update + results
- **トリガー**: Newsletter 登録増加したい、Exit intent で離脱回収したい、ポップアップが UX を壊していないか検証したい

### Paywall Optimization (`/optimize-paywall`)
- **役割**: Paywall・Upgrade モーダル・アプリ内アップセルの CVR 最適化
- **入力**: 現状 Paywall、トリガー条件、Free→Paid 率、ARPU、LTV
- **出力**: Trigger Strategy、改修 Paywall UI、A/B テスト計画、LTV Guardrail
- **知識**: base + profile + update + results
- **トリガー**: Free→Paid 停滞、Annual 比率低迷、アップグレード停滞、新機能リリース時

## Workflow Chains

全ワークフローはSARFサイクル（Set → Ask → Release → Feedback → Set）を構造として持ちます。

### Campaign Launch Cycle（`/campaign-launch`）
```
SARF:     Set      → Ask           → Release       → Ask  →Release→ Feedback
          knowledge→ CMO Review    → CD→Content/Ads → CEO → Launch→ Analytics
                   → SEO → UI Review Review        → Review          ↓
                                                                 knowledge/update/
```

### Content Review Cycle（`/content-review`）
```
SARF:   Set       → Release → Ask (多角レビュー)          → Release → Feedback
        knowledge → Content → SEO → CD → CMO Review       → Publish → Analytics
```

### Landing Page Cycle（`/landing-page`）
```
SARF:   Set       → Ask        → Release                     → Ask   → Feedback設計
        knowledge → CMO Review → UI/CD/SEO/Ads implementation → 品質 → Analytics
```

### Weekly Retro（`/weekly-retro` = SARFの閉じる部分）
```
SARF:   Feedback             → 集約 → 次のSet更新           → 次のAsk
        Analytics → CMO Review → CEO Review → Next Week Plan → knowledge/update/ 更新
```

## Integrations（外部ツール直結レイヤー）

SARFStack の各スキルは、Figma / Google Ads / GA4 / Search Console / Meta / X / LinkedIn / TikTok / HubSpot / Salesforce / Stripe / Notion / Slack / Google Drive / BigQuery / PostHog / Amplitude / Intercom 等と **MCP サーバ経由で直接接続** できます。接続があれば CSV 手入力をスキップして直接 pull / push し、SARF の Set（データ取り込み）と Release（本番反映）の両方を加速します。

- **カタログ**: [`knowledge/base/integrations.md`](knowledge/base/integrations.md)（どのスキルがどの MCP を使うか）
- **設定**: ルートの [`.mcp.json.example`](.mcp.json.example) をコピーして `.mcp.json` を作成。シークレットは環境変数経由で注入。`.mcp.json` と `.claude/settings.local.json` は gitignore 済み
- **ガードレール**: Write 操作は必ずユーザー承認ゲート経由 / Read-only から始める / 最小 scope / PII は匿名化 or 集計値のみ

各 SKILL.md 末尾の「Integrations（optional）」セクションに、そのスキルが使う可能性のある接続と未接続時の Fallback（従来の CSV 手入力）が列挙されています。接続が増えるほど SARF サイクルの回転速度が上がる設計です。

## Knowledge Architecture

情報は **`knowledge/`（共有ベース / tracked）** と **`memory/`（プロジェクト固有 / gitignored）** の2つのルートに分離されています。ひと目で「upstream に流れるか／流れないか」が判別できる構造です。

```
knowledge/   — shared base (tracked, upstream に流れる)
  base/         — 不変フレームワーク・マインドセット
  update/       — 外部揮発情報（プラットフォーム仕様・業界トレンド）

memory/      — per-workspace memory (gitignored)
  workspaces/<slug>/profile/   — その workspace の事業プロフィール（ICP・Positioning・Brand・Competitors・Overview）
  workspaces/<slug>/results/   — その workspace のパフォーマンスデータ・施策検証ログ
  profile  → workspaces/<active>/profile  (symlink, 全スキルが参照するアクティブ view)
  results  → workspaces/<active>/results  (symlink, 全スキルが参照するアクティブ view)
  profile.example/             — workspaces/*/profile/ のテンプレート（tracked）
  results.example/             — workspaces/*/results/ のテンプレート（tracked）
```

**workspace** は「SARF Set（ICP・Positioning・Brand・Competitors・実績数値）が独立して成立する最小スコープ」を指します。事業部・クライアント・プロダクトライン・単一事業、いずれの粒度でも構いません。

- 代理店のクライアント: `client-acme` / `client-beta`
- 企業内の事業部・プロダクト: `acme-saas` / `acme-enterprise` / `acme-consumer`
- 単一事業スタートアップ: `acme`（実在する事業名を使う。`default` は使わない）

全スキルは従来通り `memory/profile/...` `memory/results/...` というパスで memory を読み、`memory/profile` `memory/results` は **アクティブ workspace への symlink** として機能します。workspace 切替は `/workspace switch <slug>` で symlink を張り替えるだけ（SKILL.md 側の変更は不要）。共通情報の重複は許容する設計（inheritance を導入すると SKILL.md 全体にマージの責務が波及するため意図的に避けています）。

- `/workspace` — 一覧 + アクティブ表示
- `/workspace current` — 現在のアクティブ slug
- `/workspace new <slug>` — `.example/` からテンプレートを複製して新規作成＋即アクティブ化
- `/workspace switch <slug>` — 既存 workspace へ切替
- `/workspace remove <slug>` — 削除（要確認）

### Foundation（不変の知識 / tracked）
`knowledge/base/` — マーケティングのフレームワーク、マインドセット、原則。
めったに変更されない普遍的な知識。全スキルの基盤として暗黙的に参照される。

### Update（外部揮発情報 / tracked）
`knowledge/update/` — プラットフォームアップデート、業界トレンド。**外から入ってくる** 公開情報ベースの揮発層。
`/set-update` で更新する。自社の実績数値（CVR・CPA 等）はここではなく `memory/results/` 側。

### Organization（組織全体で共有する知識 / gitignored）
`memory/organization/` — 組織全体のミッション・ビジョン・バリュー、事業ポートフォリオ、組織共通のブランドガイドライン。
全 workspace に共通して適用される上位コンテキスト。`/set-organization` で初期セットアップ・更新。単一インスタンス（workspace のような複数持ちはしない）。

> `memory/organization/` は **gitignore 対象**。upstream には共通テンプレート `memory/organization.example/` のみが入っています。初回セットアップは `cp -r memory/organization.example memory/organization` または `/set-organization` 経由。`memory/organization.example/` は書き換え禁止（upstream に流れます）。

### Profile（workspace 固有の事業プロフィール / gitignored）
`memory/profile/` — workspace 単位の事業概要、ICP、ポジショニング、競合情報。ブランドガイドラインは組織層（`memory/organization/brand-guidelines.md`）に集約されており、workspace 固有の差分が必要になったら `memory/profile/brand-guidelines.md` を追加して override する。
**実体は `memory/workspaces/<active>/profile/`** で、`memory/profile` はそこへの symlink。workspace 初期セットアップ時にユーザーが記入し、施策レビュー時に必ず参照される。

> `memory/workspaces/` は **gitignore 対象**（各 workspace のローカル管理）。upstream には共通テンプレート `memory/profile.example/` のみが入っています。新規 workspace は `/workspace new <slug>` で作成（`.example/` からテンプレート注入＋ symlink 張り替え）、既存 workspace への切替は `/workspace switch <slug>`。実情報は必ず `memory/workspaces/<slug>/profile/` 側に書き、`memory/profile.example/` は書き換えないでください（upstream に流れます）。

### Results（workspace 固有の結果ログ / gitignored）
`memory/results/` — 直近のパフォーマンスデータ（CVR・CPA・ROAS・売上 等）、施策ごとの検証ログ、普遍化前の観測仮説。
**実体は `memory/workspaces/<active>/results/`** で、`memory/results` はそこへの symlink。**中から出てくる** 機密性の高い数値のため gitignore 対象。SARF の Feedback 段階で `/feedback` スキルが書き込む保管先。

> upstream には共通テンプレート `memory/results.example/` のみ。新規は `/workspace new <slug>` 経由で `.example/` から注入される。`memory/results.example/` は書き換え禁止（upstream に流れます）。

## Skills vs Agents（使い分けの判断基準）

SARFStack は **Skill**（`.claude/skills/`）と **Agent**（`.claude/agents/`）の2種類を使い分けます。

| | Skill | Agent |
|---|---|---|
| 場所 | `.claude/skills/<name>/SKILL.md` | `.claude/agents/<name>.md` |
| 呼び出し | ユーザーの `/skill-name` or モデルが Skill ツール経由 | モデルが Task ツール経由で並列ディスパッチ |
| コンテキスト | メインセッションで実行（成果物・履歴が残る） | 独立したサブエージェントで実行（結果のみ返却） |
| 副作用 | あり（ファイル書き込み・MCP 呼び出し） | なし（Read のみ、結果を文字列で返す） |
| 典型的な用途 | 直接のユーザー対話・制作・Set/Feedback 操作 | レビュー・評価・並列診断 |

### 判断基準

以下のいずれかに当てはまる → **Agent 化**:
- workflow から並列で呼ばれる（例: `/campaign-launch` で CEO/CMO/SEO を同時ディスパッチ）
- レビュー系（副作用なし・結果返却のみ）
- メインコンテキストを汚したくない診断タスク

以下のいずれかに当てはまる → **Skill のまま**:
- 直接のユーザー対話が主（対話を積み重ねて成果物に到達する）
- 書き込み副作用あり（`output/` や `memory/` への生成）
- MCP 呼び出しや長期状態の操作（`/workspace switch` など）

### Scope（company-wide か workspace か）

Agent の frontmatter には `scope` フィールドを持たせ、**全事業部横断**か**単一事業部**かを明示します。

- **`scope: company-wide`** — `memory/workspaces/*/` を全走査。全 workspace を横断してレビューする経営層の役割（CEO / Group CMO）。
- **`scope: workspace`** — アクティブ workspace（`memory/profile/` symlink の指す単一 workspace）だけをレビュー。事業部マネージャー / 専門職の役割。

### 現状マッピング

| カテゴリ | Agent 化済み | Scope | Skill のみ |
|---|---|---|---|
| Executive Review | `ceo-review` | company-wide | — |
| Executive Review | `cmo-review` | company-wide | — |
| Executive Review | `consultant-review` | workspace | — |
| Specialist (Ask) | `creative-direction` `seo` | workspace | `customer-research` |
| Specialist (Release) | — | workspace | `contents-edit` `ads-manager` `estimate` `ui-design` `pricing-strategy` `churn-prevention` |
| Optimization | — | workspace | `optimize-page` `optimize-signup-flow` `optimize-onboarding` `optimize-form` `optimize-popup` `optimize-paywall` |
| SARF Ops | — | organization | `set-organization` |
| SARF Ops | — | workspace | `set-workspace` `set-update` `feedback` `sarf-check` |
| Meta | — | cross-workspace | `workspace` |
| Workflows | — | — | `campaign-launch` `content-review` `landing-page` `weekly-retro`（`.claude/workflows/` 配下、未実装） |

**経営層（CEO / Group CMO）は全事業部横断、それ以外は単一 workspace が基本スコープ**です。将来「workspace 単位の P/L 判定」が必要になったら、`workspace-manager-review` 等を `scope: workspace` で追加する余地があります。

Agent は「**Skill の薄いラッパー**」として実装します（対応 SKILL.md を Read → 定義通り実行 → 結果返却）。Skill 側に定義を一本化することで、仕様の重複を防ぎます。

## Output Directory（成果物の書き込み先）

全スキルの **一次成果物**（原稿・HTML/CSS・広告コピー・分析レポート・見積書等）は必ず `output/<workspace>/` 配下に書き込みます。`<workspace>` はアクティブ workspace の slug（`readlink memory/profile | sed 's|workspaces/||; s|/profile||'` で取得）。

- `output/` は **gitignore 対象**（`.gitkeep` と `README.md` のみ tracked）。企業固有のコピー・数値を安全に置けます。
- **必ず `output/<workspace>/...` に書く**。workspace 単位に分離することで、複数クライアント・複数事業部を並行で扱う際の成果物の誤配・混在を防ぐ。
- プロジェクトルートや `.claude/skills/` 内に直接ファイルを作らないこと。
- 推奨ファイル名: `YYYYMMDD-{skill}-{slug}.{ext}`（例: `output/acme-saas/20260419-contents-edit-hero-copy.md`）。
- 成果物を `knowledge/` に書くのは NG。knowledge は「次サイクルの Set に効く蓄積」専用、`output/` は「その瞬間の成果物」。役割が違うので混同しないこと。

詳細は [`output/README.md`](output/README.md) を参照。

## How Knowledge Loading Works

各SKILL.mdの冒頭で、以下のパターンで知識を読み込みます:

```
# Required Knowledge
Read: memory/profile/business-overview.md
Read: memory/profile/icp.md
Read: knowledge/base/growth-frameworks.md
Read: memory/results/performance-data.md
```

スキルの性質に応じて読み込む知識層が異なります:
- **SARF Ops** → sarf-framework + 対象となる knowledge 層（Set/Feedbackの操作自体が責務）
- **Executive Review** → base + profile（戦略判断に必要）
- **Specialist Agents** → base + profile + update + results（実行に必要）
- **Workflows** → 内包するスキルが個別に読み込む

これはSARFの **Set** 段階に相当します。スキル実行前に `[TODO]` が残っているファイルがあれば、それは Set が未完成ということ。Ask の前に Set を整えることが、成果物の質を決めます。

## Principles

1. **忖度しない** — 数字とロジックに基づいた率直なフィードバック。「いいと思います」で終わらない。
2. **実行ベース** — アドバイスだけでなく、実際の成果物（コピー、HTML、設定値）を出力する。Releaseまで到達して初めて完了。
3. **根拠を示す** — すべての提案に理由・データ・フレームワークの裏付けを添える。
4. **SARFサイクルを回す** — Set→Ask→Release→Feedbackのループを1つのワークフローで完結させる。Feedbackを怠らない。
5. **知識を分離する** — 普遍的な知識と揮発性の情報を混ぜない。SetとFeedbackが汚染されないよう、検証済みの知見のみを `memory/profile/` に記入する。

## Canonical SARF Flow

初めてのプロジェクトは以下の順で回すのが推奨フローです:

0. `/workspace new <slug>` — workspace を1つ作成（`default` は使わない。実在する事業名で）
1. `/set-organization` — 組織情報を一括ヒアリング（Set, organization層）
2. `/set-workspace` — workspace 固有情報を一括ヒアリング（Set, workspace層）
3. `/next` — 次の一歩を確認（詳細が必要なら `/sarf-check`）。不足があれば `/set-organization` / `/set-workspace` に戻る
4. `/cmo-review`（Ask 単体）or `/campaign-launch`（Set〜Feedback を横断する統合ワークフロー）— 施策レビュー／全工程開始
5. `/data-analytics`（Feedback 単体）or `/weekly-retro`（Feedback 起点で次サイクルの Set へ閉じる統合ワークフロー）— 結果集約
6. `/set-update` + `/feedback` — Set層への還元（サイクルを閉じる）

各 SKILL.md 冒頭には `SARF Alignment` セクションがあり、そのスキルの **Position / Set Preflight / Feedback Hook** が明記されています。スキル呼び出し前に確認してください。

Ask系・Release系のスキルには、マーケ固有の解像度を上げる optional フィールド（`Target Funnel Stage` / `Target Segment` / `Primary KPI`）が追加されています。記入があればそれを前提に動作し、未記入なら従来通りの動作にフォールバックします（オプトイン方式の Marketing Extension）。

## Agent Communication Protocol

エージェント間の引き継ぎは以下のフォーマットで行われます。
SARFの観点では、「前のエージェントのRelease成果物を、次のエージェントのSet（前提）として渡す」操作に相当します。

```markdown
## Handoff: [送信元Agent] → [受信先Agent]

### Context
[何についてのレビュー/作業か]

### Findings
[発見事項・成果物のサマリー]

### Action Items for Next Agent
- [ ] [具体的なアクション1]
- [ ] [具体的なアクション2]

### Artifacts
[成果物へのパス or インラインの成果物]
```
