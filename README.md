# SARFStack — Virtual Marketing Organization 

SARFStackは、コーディングエージェント上で動作する**仮想マーケティング組織**です。
AI時代の **マーケティングOS** である **SARF**（Set / Ask / Release / Feedback、読み:「サーフ」）をそのまま実装したもので、1コマンドでSetからFeedbackまでのサイクルを回せます。

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
| **A**sk | 誰の視点で・何を・どの形式で出させるか問いを組む | レビュー系スキル（`/ask-cmo` 等） |
| **R**elease | 出てきたアイデアを判断して**本番環境に反映**する | 制作系スキル・ワークフロー（`/contents-editor` `/flow-landing-page` 等） |
| **F**eedback | 結果の数字と定性反応をAIに戻す | 分析系スキル（`/data-analyst` `/flow-weekly-retro`） |

詳細は [`knowledge/foundation/sarf-framework.md`](knowledge/foundation/sarf-framework.md) を参照。マーケ固有のディメンション（Funnel Stage / Segment / Unit Economics / Measurement / Baseline KPI）を各段階に重ねる optional な **Marketing Extension** もそこに定義されています。

## Setup

### 1. Clone

```bash
git clone https://github.com/cmoteam/sarfstack.git
cd sarfstack
```

### 2. Bootstrap Company Knowledge（企業情報ディレクトリを作成）

企業固有情報は `memory/company/` に置きますが、このディレクトリは **gitignore 対象**（upstream には含まれない）です。リポジトリにはテンプレート `memory/company.example/` のみが入っているので、初回にコピーしてください:

```bash
cp -r memory/company.example memory/company
```

> **なぜ分離しているか**: ICP・競合情報・ブランドガイドラインなどの機密情報を upstream に誤って push する事故を防ぎ、`git pull` でフレームワーク本体のアップデートを素直に取り込めるようにするためです。

### 3. Fill in Company Knowledge（= SARFのSet）

SARFの **Set** 段階。ここを埋めないとAIは汎用回答しか返せません。成果物の質の9割がここで決まります。

**推奨**: `/set-company` を実行すると、`memory/company/` が無ければ自動でテンプレートから作成し、対話で必要な情報を一括ヒアリングして以下のファイルを埋めます。

手動で編集する場合は `memory/company/` 内のファイルを開き、`[TODO]` を実際の情報で置き換えてください:

```
memory/company/company-overview.md  ← 事業概要
memory/company/icp.md              ← 理想的な顧客像
memory/company/positioning.md      ← ポジショニング
memory/company/brand-guidelines.md ← ブランドガイドライン
memory/company/competitors.md      ← 競合情報
```

⚠️ **`memory/company.example/` には実情報を書き込まないでください**。こちらは upstream に push される共通テンプレートです。実データは必ず `memory/company/`（gitignore側）に書きます。

充足率は `/sarf-check` で確認できます。

### 4. Bootstrap Results Knowledge（企業固有の結果ログ）

自社の実績数値（CVR・CPA・売上 等）は `memory/results/` に置きます。こちらも **gitignore 対象** なので、初回に `memory/results.example/` からコピーしてください:

```bash
cp -r memory/results.example memory/results
```

`/feedback` を初回実行した際に未存在なら自動で同じコピーが行われます。

### 5. Refresh Update Knowledge（外部揮発情報）

`knowledge/update/` は外部観測・公開情報（プラットフォーム仕様変更、業界トレンド）の最新化レイヤーです。自社数値は対象外（`results/` 側）。

**推奨**: `/set-update` で対話的に書き戻し、自社の KPI 実績は `/feedback` で `memory/results/` に書き込みます。検証済みの学びは `/feedback` が company 層に昇華します。

```
knowledge/update/platform-updates.md    ← プラットフォーム仕様変更（共有可）
knowledge/update/industry-trends.md     ← 業界トレンド（共有可）
memory/results/performance-data.md   ← 直近のパフォーマンスデータ（gitignore）
```

## Available Skills

### SARF Ops（サイクル運用）
| Command | Phase | Description |
|---------|-------|-------------|
| `/set-company` | Set | 企業情報（ICP・ポジショニング等）を対話で一括ヒアリング |
| `/set-update` | Set | 業界トレンド・プラットフォーム仕様変更を `knowledge/update/` に書き戻す |
| `/sarf-check` | Meta | Set充足率・次の一手を診断 |
| `/feedback` | Feedback | 施策結果を検証ゲート付きで `memory/results/` と `memory/company/` に反映 |

### Executive Review（経営レビュー）
| Command | Role | Description |
|---------|------|-------------|
| `/ask-ceo` | CEO | 収益性・ROI・事業インパクト評価 |
| `/ask-cmo` | CMO | マーケティング戦略全体の統括レビュー |
| `/ask-consultant` | Consultant | 外部コンサル視点でゼロベースの率直フィードバック |

### Specialist Agents（専門エージェント）
| Command | Role | Description |
|---------|------|-------------|
| `/seo-specialist` | SEO | SEO分析・KW戦略・技術SEO |
| `/creative-director` | CD | クリエイティブ品質・ブランド一貫性 |
| `/ui-designer` | UI/UX | LP/WebページのUI・CVR最適化 |
| `/ads-manager` | Ads | Google/Meta/X広告の設計・最適化 |
| `/contents-editor` | Content | ブログ・SNS・メールの企画・制作 |
| `/data-analyst` | Analytics | KPI分析・レポート・改善提案 |
| `/customer-research` | Research | 顧客インタビュー・JTBD・Win/Loss分析（ICPをデータで鍛える） |
| `/pricing-strategy` | Pricing | 価格設定・プラン設計・パッケージング戦略 |
| `/churn-prevention` | Retention | 解約防止・リテンション改善・Save Offer設計 |

### Optimization Agents（最適化スペシャリスト）
各ファネル段階でのユーザー行動完了率（CVR）を数字で上げる診断・改修を専門とする。`/ui-designer` が UI/UX 全般を見るのに対し、最適化系はファネル段階別に特化。

| Command | Target | Description |
|---------|--------|-------------|
| `/optimize-page` | Marketing Pages | LP/Product/Feature/Pricing等のCVR最適化 |
| `/optimize-signup-flow` | Signup | 登録〜初回ログインの完了率最適化 |
| `/optimize-onboarding` | Activation | Aha Moment 到達・Activation 最適化 |
| `/optimize-form` | Lead Forms | デモ/資料DL/問い合わせフォームの完了率最適化 |
| `/optimize-popup` | Popups/Modals | Exit intent・Newsletter・告知系の設計と最適化 |
| `/optimize-paywall` | Paywall/Upsell | Free→Paid・アプリ内アップセルのCVR最適化 |

### Workflows（統合ワークフロー）
| Command | Description |
|---------|-------------|
| `/flow-campaign-launch` | キャンペーンの全工程（企画→制作→レビュー→ローンチ） |
| `/flow-content-review` | コンテンツの制作→多角的レビューサイクル |
| `/flow-landing-page` | LP設計→制作→最適化 |
| `/flow-weekly-retro` | 週次マーケティング振り返り |

## Architecture

```
sarfstack/
├── AGENTS.md                    # Canonical: agents, SARF, knowledge, workflows
├── CLAUDE.md                    # Stub importing AGENTS.md (for Claude Code)
├── .claude/settings.json        # Skill definitions
│
├── knowledge/                   # Base: shared, tracked
│   ├── foundation/              # Stable: frameworks, mindset
│   └── update/                  # External volatile: platform updates, industry trends
│
├── memory/                      # Per-project memory: company-specific
│   ├── company.example/         # Template for company/ (tracked)
│   ├── company/                 # Company-specific: ICP, brand (gitignored — per-project)
│   ├── results.example/         # Template for results/ (tracked)
│   └── results/                 # Company-specific: performance data (gitignored — per-project)
│
├── skills/                      # Individual agents & workflows
│   ├── set-company/SKILL.md     # SARF: Set
│   ├── set-update/SKILL.md      # SARF: Set
│   ├── sarf-check/SKILL.md      # SARF: Meta (diagnostic)
│   ├── feedback/SKILL.md        # SARF: Feedback
│   ├── ask-ceo/SKILL.md
│   ├── ask-cmo/SKILL.md
│   ├── ask-consultant/SKILL.md
│   ├── seo-specialist/SKILL.md
│   ├── creative-director/SKILL.md
│   ├── ui-designer/SKILL.md
│   ├── ads-manager/SKILL.md
│   ├── contents-editor/SKILL.md
│   ├── data-analyst/SKILL.md
│   ├── customer-research/SKILL.md
│   ├── pricing-strategy/SKILL.md
│   ├── churn-prevention/SKILL.md
│   ├── optimize-page/SKILL.md
│   ├── optimize-signup-flow/SKILL.md
│   ├── optimize-onboarding/SKILL.md
│   ├── optimize-form/SKILL.md
│   ├── optimize-popup/SKILL.md
│   ├── optimize-paywall/SKILL.md
│   ├── flow-campaign-launch/SKILL.md
│   ├── flow-content-review/SKILL.md
│   ├── flow-landing-page/SKILL.md
│   └── flow-weekly-retro/SKILL.md
│
├── templates/                   # Reusable content templates
│   ├── ad-copy.md
│   ├── landing-page.md
│   ├── email-sequence.md
│   ├── blog-post.md
│   └── social-media.md
│
├── output/                      # Generated artifacts (gitignored — per-project)
│   └── README.md                # Convention docs (tracked)
│
└── lib/                         # Shared components
    ├── preamble.md
    ├── review-format.md
    └── scoring-rubric.md
```

## Knowledge vs Memory

ベースの `knowledge/`（tracked、共有可）と per-project の `memory/`（gitignored）を分離しています。

```
knowledge/                                     memory/
(shared base — tracked)                        (per-project — gitignored)
┌─────────────────────────────────────┐        ┌─────────────────────────────────────┐
│ foundation/                         │        │ company/                            │
│  marketing-mindset, growth-        │        │  company-overview, icp,             │
│  frameworks, brand-strategy,       │        │  positioning, brand-guidelines,     │
│  metrics-glossary                  │        │  competitors                        │
├─────────────────────────────────────┤        ├─────────────────────────────────────┤
│ update/                             │        │ results/                            │
│  platform-updates,                 │        │  performance-data                   │
│  industry-trends                   │        │                                     │
└─────────────────────────────────────┘        └─────────────────────────────────────┘
                                                (templates: company.example/,
                                                 results.example/ are tracked)

Executive agents   → knowledge/foundation + memory/company
Specialist agents  → knowledge/foundation + memory/company + knowledge/update + memory/results
Workflow agents    → delegates to sub-agents

Write targets:
  /set-company  → memory/company/
  /set-update   → knowledge/update/
  /feedback     → memory/results/ (raw numbers) + memory/company/ (verified learnings)
```

## Marketing Cycle = SARF Cycle

SARFStackのマーケティングサイクルは、そのままSARFのサイクルです:

```
            SARF:  Set ──→ Ask ──→ Release ──→ Feedback ──→ (Setに還元)

/flow-campaign-launch or /flow-weekly-retro kicks off the cycle:

  ┌──────────┐     ┌───────────┐     ┌───────────┐     ┌───────────┐
  │   Set    │ ──→ │   Ask     │ ──→ │  Release  │ ──→ │ Feedback  │
  │/set-     │     │/cmo-      │     │/contents- │     │/data-     │
  │ company  │     │  review   │     │  editor   │     │  analyst  │
  │/set-     │     │/ceo-      │     │/ads-      │     │/flow-     │
  │ update   │     │  review   │     │  manager  │     │  weekly-  │
  │/sarf-    │     │/seo-      │     │/flow-     │     │  retro    │
  │  check   │     │ specialist│     │  landing- │     │/feedback  │
  │          │     │/ui-       │     │  page     │     │           │
  │          │     │  designer │     │/estimate  │     │           │
  │          │     │/creative- │     │           │     │           │
  │          │     │  director │     │           │     │           │
  └──────────┘     └───────────┘     └───────────┘     └───────────┘
       ↑                                                   │
       └── /feedback + /set-update で knowledge 層に還元 ──┘
```

## License

MIT
