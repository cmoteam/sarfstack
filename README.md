# SARFStack — Virtual Marketing Organization 

SARFStackは、コーディングエージェント上で動作する**仮想マーケティング組織**です。
AI時代の **マーケティングOS** である **SARF**（Set / Ask / Release / Feedback、読み:「サーフ」）をそのまま実装したもので、1コマンドでSetからFeedbackまでのサイクルを回せます。

---

## 🏄 迷ったら `/next`

「何をしたらいいかわからない」「前回どこまでやったか忘れた」「このプロジェクトでAIに何を頼めるんだっけ」——そういう時は **`/next`** を押してください。現在の workspace 状態（Set 充足率・直近の Release / Feedback）を見て、**次の一歩を1つだけ** 推薦します。

- `/next` = 迷った時の入口（ボタン1つ押す感覚）
- `/sarf-check` = 詳細な診断ダッシュボード（充足率・ブロッカーを多角的に見る）

---

> SARF は「AI協働の汎用フレームワーク」ではなく、マーケティング特化のOSです。ファネル段階・セグメント・ユニットエコノミクス・KPI・アトリビューションといったマーケ固有のディメンションを各段階に重ねる **Marketing Extension**（optional）により、マーケ文脈でAIが本気で機能するように設計されています。

## Who is this for?

- 企業のマーケティング担当者
- スタートアップのグロース担当
- 広告代理店の担当者
- 1人マーケ/1人広報

## The SARF Framework

SARFStackが前提とする、AI時代のマーケティングの基本サイクル（**マーケティングOS**）:

```
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│   Set    │ →  │   Ask    │ →  │ Release  │ →  │ Feedback │ ─┐
│ 情報を渡す│    │ 問いを組む│    │ 本番反映  │    │ 結果を戻す│  │
└──────────┘    └──────────┘    └──────────┘    └──────────┘  │
      ↑                                                           │
      └───────────────────────────────────────────────────────────┘
```

| SARF段階 | 人間がやること | SARFStackでの対応 |
|---------|---------------|---------------|
| **S**et | 事業・ICP・ブランド・制約を言語化してAIに渡す | `knowledge/`（base）と `memory/`（per-project）に記入 |
| **A**sk | 誰の視点で・何を・どの形式で出させるか問いを組む | レビュー系（`/cmo-review` `/ceo-review` `/consultant-review` 等） |
| **R**elease | 出てきたアイデアを判断して**本番環境に反映**する | 制作系スキル（`/contents-edit` `/ads-manager` `/ui-design` `/optimize` 等） |
| **F**eedback | 結果の数字と定性反応をAIに戻す | 分析系（`/data-analytics` `/feedback`） |

詳細は [`knowledge/base/sarf-framework.md`](knowledge/base/sarf-framework.md) を参照。マーケ固有のディメンション（Funnel Stage / Segment / Unit Economics / Measurement / Baseline KPI）を各段階に重ねる optional な **Marketing Extension** もそこに定義されています。

## Setup

### 1. Clone

```bash
git clone https://github.com/cmoteam/sarfstack.git
cd sarfstack
```

### 2. Bootstrap `private/`（企業ごとの別リポを clone）

`private/` 配下（`memory/` と `output/`）は **この upstream リポには含まれません**（gitignore）。企業ごとに実情報が変わるため、各社で **別の private リポジトリを用意し `private/` として clone** する運用を推奨しています。submodule 登録はあえてしていません（企業ごとに URL が異なり upstream に固定できないため）。

```bash
git clone <your-company-private-repo> private
```

private リポ側のレイアウトは以下を想定:

```
private/
├── memory/        # organization / workspaces / results（実データ）
└── output/        # 生成成果物（workspace slug で分離）
```

初回で private リポがまだ無い場合は、空ディレクトリのまま進めても `/set-organization` `/workspace new <slug>` `/feedback` などがテンプレートから自動生成します。あとで `cd private && git init && git remote add origin ...` で切り出せます。

### 3. Bootstrap Company Knowledge（企業情報ディレクトリを作成）

企業固有情報は `private/memory/` 配下に置きますが、このディレクトリは **gitignore 対象**（upstream には含まれない）です。リポジトリにはテンプレート `templates/memory/` のみが入っているので、初回にコピーしてください（`bin/init-private` が自動化してくれます）:

```bash
/workspace new <slug>     # 新規 workspace を作成（事業部・プロダクト・クライアント単位）
/set-organization         # 組織情報（ミッション・ビジョン・ブランド）を memory/organization/ に埋める
/set-workspace            # workspace 固有情報（ICP・Positioning・競合・事業概要）を memory/profile/ に埋める
```

> **なぜ分離しているか**: ICP・競合情報・ブランドガイドラインなどの機密情報を upstream に誤って push する事故を防ぎ、`git pull` でフレームワーク本体のアップデートを素直に取り込めるようにするためです。

### 4. Fill in Company Knowledge（= SARFのSet）

SARFの **Set** 段階。ここを埋めないとAIは汎用回答しか返せません。成果物の質の9割がここで決まります。

memory は **2層** に分かれます:

| 層 | パス | スコープ | 担当スキル |
|---|---|---|---|
| Organization | `memory/organization/` | 組織全体（全 workspace 共通） | `/set-organization` |
| Workspace | `memory/profile/`（workspace symlink） | 単一 workspace（事業部 / プロダクト / クライアント） | `/set-workspace` |

**推奨**: まず `/set-organization` で組織情報を埋め、次に `/set-workspace` で workspace 固有情報を埋めます。未存在時は自動でテンプレートから作成します。

手動で編集する場合は、それぞれのディレクトリのファイルを開き `[TODO]` を置き換えてください:

```
memory/organization/organization-overview.md ← 組織全体の概要・ミッション・事業ポートフォリオ
memory/organization/brand-guidelines.md      ← 組織共通のブランドガイドライン

memory/profile/business-overview.md          ← この workspace の事業概要
memory/profile/icp.md                        ← 理想的な顧客像
memory/profile/positioning.md                ← ポジショニング
memory/profile/competitors.md                ← 競合情報
```

⚠️ **`templates/memory/` 配下には実情報を書き込まないでください**。こちらは upstream に push される共通テンプレートです。実データは必ず gitignore 側（`private/memory/organization/` / `private/memory/workspaces/<slug>/profile/`）に書きます。

充足率は `/sarf-check` で確認できます。

### 5. Bootstrap Results Knowledge（企業固有の結果ログ）

自社の実績数値（CVR・CPA・売上 等）は `private/memory/workspaces/<slug>/results/` に置きます。こちらも **gitignore 対象** なので、初回に `templates/memory/results/` からコピーしてください（`bin/workspace new <slug>` または `bin/workspace new <slug>` が自動化）:

```bash
cp -r templates/memory/results private/memory/workspaces/<slug>/results
```

`/feedback` を初回実行した際に未存在なら自動で同じコピーが行われます。

### 6. Refresh Update Knowledge（外部揮発情報）

`knowledge/update/` は外部観測・公開情報（プラットフォーム仕様変更、業界トレンド）の最新化レイヤーです。自社数値は対象外（`results/` 側）。

**推奨**: `/set-update` で対話的に書き戻し、自社の KPI 実績は `/feedback` で `memory/results/` に書き込みます。検証済みの学びは `/feedback` が company 層に昇華します。

```
knowledge/update/platform-updates.md    ← プラットフォーム仕様変更（共有可）
knowledge/update/industry-trends.md     ← 業界トレンド（共有可）
memory/results/performance-data.md   ← 直近のパフォーマンスデータ（gitignore）
```

### 7. Connect Integrations（外部ツール直結・optional）

Figma / Google Ads / GA4 / Search Console / Meta / X / LinkedIn / TikTok / HubSpot / Salesforce / Stripe / Notion / Slack / BigQuery / PostHog / Amplitude / Intercom などと **MCP サーバ経由で直接繋ぐ** ことができます。接続があれば CSV 手入力をスキップして SARF サイクルが一段速く回ります（未接続でも従来通り動作します）。

```bash
cp .mcp.json.example .mcp.json
# .mcp.json を編集し、使うサーバを残して API Key / Token を環境変数で注入
```

- 詳細カタログ: [`knowledge/base/integrations.md`](knowledge/base/integrations.md)
- `.mcp.json` と `.claude/settings.local.json` は gitignore 済み（シークレット保護）
- Write 操作は必ずユーザー承認ゲート経由 / Read-only から始めるのが既定
- 最小推奨セット: Figma + Google Ads + GA4 + Meta + Slack + GitHub

## Available Skills

### SARF Ops（サイクル運用）
| Command | Phase | Description |
|---------|-------|-------------|
| `/next` | Meta | 迷ったらこれ。現在の workspace 状態から次の一歩を **1つだけ** 推薦 |
| `/sarf-check` | Meta | `/next` の詳細モード（充足率・ブロッカー・Marketing Extension を可視化） |
| `/workspace` | Meta | workspace の list / current / new / switch / remove |
| `/set-organization` | Set | 組織全体の情報（ミッション・ビジョン・ブランド・事業ポートフォリオ）を対話で一括ヒアリング |
| `/set-brand` | Set | ブランドガイドラインを対話で一括ヒアリング |
| `/set-workspace` | Set | workspace 単位の情報（事業概要・ICP・Positioning・競合）を対話で一括ヒアリング |
| `/set-update` | Set | 業界トレンド・プラットフォーム仕様変更を `knowledge/update/` に書き戻す |
| `/feedback` | Feedback | 施策結果を検証ゲート付きで `results/` と `profile/` に反映 |

### Review 系（thin dispatcher + agent パターン）

レビュー系 5 つは **agent** として `.claude/agents/` に canonical 定義を持ち、`.claude/skills/*/SKILL.md` は slash エントリ用の thin dispatcher。slash で叩くと Task tool 経由でサブエージェントに委譲され、メインコンテキストを汚さずレビューを回せます。

| Command | Role | Scope | Description |
|---------|------|-------|-------------|
| `/ceo-review` | CEO | company-wide | 収益性・ROI・事業インパクト評価。GO/PIVOT/KILL 判定 |
| `/cmo-review` | Group CMO | company-wide | 全 workspace 横断のマーケティング戦略整合性・予算配分 |
| `/consultant-review` | Consultant | workspace | 外部コンサル視点でゼロベースの率直フィードバック（Phase 0 で率直質問から入る） |
| `/seo` | SEO | workspace | KW 戦略・技術 SEO 監査・コンテンツ最適化・実装案 |
| `/creative-direction` | CD | workspace | クリエイティブ品質・ブランド一貫性・トーン&マナー |

### Specialist Skills（専門スキル）
| Command | Role | Description |
|---------|------|-------------|
| `/ui-design` | UI/UX | LP/WebページのUI・CVR最適化 |
| `/ads-manager` | Ads | Google/Meta/X広告の設計・最適化 |
| `/contents-edit` | Content | ブログ・SNS・メールの企画・制作 |
| `/data-analytics` | Analytics | KPI分析・レポート・改善提案 |
| `/customer-research` | Research | 顧客インタビュー・JTBD・Win/Loss分析（ICPをデータで鍛える） |
| `/pricing-strategy` | Pricing | 価格設定・プラン設計・パッケージング戦略 |
| `/churn-prevention` | Retention | 解約防止・リテンション改善・Save Offer設計 |
| `/estimate` | Agency | 広告代理店視点での見積り・工数計算・費用概算 |

レビュー系（`/ceo-review` `/cmo-review` `/consultant-review` `/seo` `/creative-direction`）は agent 化済（`.claude/agents/`）、上記は skill のみ。判断基準は [`knowledge/base/skills-vs-agents.md`](knowledge/base/skills-vs-agents.md)。

### Optimization Agent（`/optimize <target>`）
各ファネル段階でのユーザー行動完了率（CVR）を数字で上げる診断・改修を専門とする。`/ui-design` が UI/UX 全般を見るのに対し、`/optimize` はファネル段階別に特化（1つのスキルが 6 target に対応）。

| target | Scope | Primary KPI |
|---|---|---|
| `page` | LP/Product/Feature/Pricing 等 | CVR |
| `signup-flow` | 登録〜初回ログイン | Signup Completion |
| `onboarding` | Aha Moment 到達〜Activation | Activation Rate |
| `form` | デモ/資料DL/問い合わせ | Form Completion |
| `popup` | Exit intent / Newsletter / 告知系 | Capture Rate + Guardrail |
| `paywall` | Free→Paid / アプリ内アップセル | Paywall CVR + LTV |

### Workflows（統合ワークフロー）

> ⚠️ **現状未実装**。`.claude/workflows/` 配下に配置予定。以下は設計中のラインナップです。

| Command | Description |
|---------|-------------|
| `/campaign-launch` | キャンペーンの全工程（企画→制作→レビュー→ローンチ） |
| `/content-review` | コンテンツの制作→多角的レビューサイクル |
| `/landing-page` | LP設計→制作→最適化 |
| `/weekly-retro` | 週次マーケティング振り返り |

## Architecture

```
sarfstack/
├── CLAUDE.md                    # Canonical: agents, SARF, knowledge
├── AGENTS.md                    # Stub pointing to CLAUDE.md (for Codex 他)
├── .claude/
│   ├── skills/                  # Skills: slash entry points（ユーザー対話・制作・Set/Feedback）
│   │   ├── next/                #   /next — 次の一歩を1つ推薦
│   │   ├── sarf-check/          #   /sarf-check — 詳細診断
│   │   ├── workspace/           #   /workspace list|new|switch|remove
│   │   ├── set-{organization,brand,workspace,update}/
│   │   ├── feedback/
│   │   ├── {ceo,cmo,consultant}-review/ seo/ creative-direction/  # thin dispatcher → agents/
│   │   ├── {ui-design,ads-manager,contents-edit,data-analytics,
│   │   │   customer-research,pricing-strategy,churn-prevention,estimate}/
│   │   └── optimize/            #   /optimize <page|signup-flow|onboarding|form|popup|paywall>
│   │       └── targets/*.md
│   └── agents/                  # Agents: Task tool 経由（レビュー系で context 分離）
│       ├── ceo-review.md
│       ├── cmo-review.md
│       ├── consultant-review.md
│       ├── creative-direction.md
│       └── seo.md
│
├── bin/                         # Shell ヘルパー（init-private, workspace, set-* の委譲先）
├── .mcp.json.example            # MCP サーバテンプレ（copy to .mcp.json, gitignored）
│
├── knowledge/                   # Base: shared, tracked
│   ├── base/                    # 不変フレームワーク（marketing-mindset, sarf-framework, etc.）
│   └── update/                  # 外部揮発情報（platform-updates, industry-trends）
│
├── templates/
│   ├── memory/                  # memory 層のテンプレ（private/memory を生成する元）
│   │   ├── organization/
│   │   ├── profile/
│   │   └── results/
│   └── content/                 # 成果物テンプレ（ad-copy 等の雛形、将来拡張）
│
├── private/                     # Per-project data (gitignored)
│   ├── memory/
│   │   ├── organization/        # Organization-wide: mission, brand, portfolio
│   │   └── workspaces/
│   │       ├── <slug>/profile/  # ICP, positioning, competitors
│   │       ├── <slug>/results/  # 実績数値・検証ログ
│   │       └── active → <slug>  # アクティブ symlink
│   └── output/<slug>/           # 生成成果物（workspace ごと）
│
└── lib/                         # 共通部品
    ├── preamble.md
    ├── review-format.md
    └── scoring-rubric.md
```

## Knowledge vs Memory

ベースの `knowledge/`（tracked、共有可）と per-project の `private/memory/`（gitignored）を分離しています。`templates/memory/` はその private/memory/ を生成するためのテンプレート。

```
knowledge/                            templates/memory/            private/memory/
(shared base — tracked)               (templates — tracked)        (per-project — gitignored)
┌──────────────────────────┐         ┌──────────────────────┐     ┌──────────────────────────────┐
│ base/                    │         │ organization/        │ ──▶ │ organization/                │
│  marketing-mindset,      │         │ profile/             │ ──▶ │ workspaces/<slug>/profile/   │
│  growth-frameworks, ...  │         │ results/             │ ──▶ │ workspaces/<slug>/results/   │
├──────────────────────────┤         └──────────────────────┘     └──────────────────────────────┘
│ update/                  │         テンプレから private/ を生成: bin/init-private
│  platform-updates,       │
│  industry-trends         │
└──────────────────────────┘

Executive agents   → knowledge/base + private/memory/organization + profile
Specialist agents  → knowledge/base + private/memory/ 全層 + knowledge/update
Workflow agents    → delegates to sub-agents

Write targets:
  /set-organization → memory/organization/
  /set-workspace    → memory/profile/ (workspace symlink)
  /set-update       → knowledge/update/
  /feedback         → memory/results/ (raw numbers) + memory/profile/ (verified learnings)
```

## Marketing Cycle = SARF Cycle

SARFStackのマーケティングサイクルは、そのままSARFのサイクルです:

```
            SARF:  Set ──→ Ask ──→ Release ──→ Feedback ──→ (Setに還元)

スキル単体でも各段階を回せます（workflows 統合版は将来実装）:

  ┌──────────┐     ┌───────────┐     ┌───────────┐     ┌───────────┐
  │   Set    │ ──→ │   Ask     │ ──→ │  Release  │ ──→ │ Feedback  │
  │/set-     │     │/cmo-      │     │/contents- │     │/data-     │
  │ organiz- │     │  review   │     │  edit     │     │ analytics │
  │ ation    │     │/ceo-      │     │/ads-      │     │/feedback  │
  │/set-     │     │  review   │     │  manager  │     │           │
  │ brand    │     │/consult-  │     │/ui-design │     │           │
  │/set-     │     │  ant-rev. │     │/optimize  │     │           │
  │ workspace│     │/seo       │     │ <target>  │     │           │
  │/set-     │     │/ui-design │     │/estimate  │     │           │
  │ update   │     │/creative- │     │           │     │           │
  │/sarf-    │     │ direction │     │           │     │           │
  │  check   │     │           │     │           │     │           │
  └──────────┘     └───────────┘     └───────────┘     └───────────┘
       ↑                                                   │
       └── /feedback + /set-update で knowledge 層に還元 ──┘
```

## License

MIT
