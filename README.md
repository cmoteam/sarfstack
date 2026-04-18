# CMObot — Virtual Marketing Organization for Claude Code

CMObotは、Claude Code / Codex 上で動作する**仮想マーケティング組織**です。
AI時代のマーケティングフレームワーク **SAAF**（Set / Ask / Action / Feedback）をそのまま実装したもので、1コマンドでSetからFeedbackまでのサイクルを回せます。

## Who is this for?

- 企業のマーケティング担当者
- スタートアップのグロース担当
- 広告代理店の担当者
- 1人マーケ/1人広報

## The SAAF Framework

CMObotが前提とする、AI時代のマーケティングの基本サイクル:

```
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│   Set    │ →  │   Ask    │ →  │  Action  │ →  │ Feedback │ ─┐
│ 情報を渡す│    │ 問いを組む│    │ 判断・実装│    │ 結果を戻す│  │
└──────────┘    └──────────┘    └──────────┘    └──────────┘  │
      ↑                                                           │
      └───────────────────────────────────────────────────────────┘
```

| SAAF段階 | 人間がやること | CMObotでの対応 |
|---------|---------------|---------------|
| **S**et | 事業・ICP・ブランド・制約を言語化してAIに渡す | `knowledge/` 3層に記入 |
| **A**sk | 誰の視点で・何を・どの形式で出させるか問いを組む | レビュー系スキル（`/cmo-review` 等） |
| **A**ction | 出てきたアイデアを判断して実装する | 制作系スキル・ワークフロー（`/content` `/landing-page` 等） |
| **F**eedback | 結果の数字と定性反応をAIに戻す | 分析系スキル（`/analytics` `/weekly-retro`） |

詳細は [`knowledge/foundation/saaf-framework.md`](knowledge/foundation/saaf-framework.md) を参照。

## Setup

### 1. Clone

```bash
git clone https://github.com/cmoteam/cmobot.git
cd cmobot
```

### 2. Bootstrap Company Knowledge（企業情報ディレクトリを作成）

企業固有情報は `knowledge/company/` に置きますが、このディレクトリは **gitignore 対象**（upstream には含まれない）です。リポジトリにはテンプレート `knowledge/company.example/` のみが入っているので、初回にコピーしてください:

```bash
cp -r knowledge/company.example knowledge/company
```

> **なぜ分離しているか**: ICP・競合情報・ブランドガイドラインなどの機密情報を upstream に誤って push する事故を防ぎ、`git pull` でフレームワーク本体のアップデートを素直に取り込めるようにするためです。

### 3. Fill in Company Knowledge（= SAAFのSet）

SAAFの **Set** 段階。ここを埋めないとAIは汎用回答しか返せません。成果物の質の9割がここで決まります。

**推奨**: `/set-company` を実行すると、`knowledge/company/` が無ければ自動でテンプレートから作成し、対話で必要な情報を一括ヒアリングして以下のファイルを埋めます。

手動で編集する場合は `knowledge/company/` 内のファイルを開き、`[TODO]` を実際の情報で置き換えてください:

```
knowledge/company/company-overview.md  ← 事業概要
knowledge/company/icp.md              ← 理想的な顧客像
knowledge/company/positioning.md      ← ポジショニング
knowledge/company/brand-guidelines.md ← ブランドガイドライン
knowledge/company/competitors.md      ← 競合情報
```

⚠️ **`knowledge/company.example/` には実情報を書き込まないでください**。こちらは upstream に push される共通テンプレートです。実データは必ず `knowledge/company/`（gitignore側）に書きます。

充足率は `/saaf-check` で確認できます。

### 4. Bootstrap Results Knowledge（企業固有の結果ログ）

自社の実績数値（CVR・CPA・売上 等）は `knowledge/results/` に置きます。こちらも **gitignore 対象** なので、初回に `knowledge/results.example/` からコピーしてください:

```bash
cp -r knowledge/results.example knowledge/results
```

`/feedback` を初回実行した際に未存在なら自動で同じコピーが行われます。

### 5. Update Latest Knowledge（外部揮発情報）

`knowledge/latest/` は外部観測・公開情報（プラットフォーム仕様変更、業界トレンド）の最新化レイヤーです。自社数値は対象外（`results/` 側）。

**推奨**: `/set-latest` で対話的に書き戻し、自社の KPI 実績は `/feedback` で `knowledge/results/` に書き込みます。検証済みの学びは `/feedback` が company 層に昇華します。

```
knowledge/latest/platform-updates.md    ← プラットフォーム仕様変更（共有可）
knowledge/latest/industry-trends.md     ← 業界トレンド（共有可）
knowledge/results/performance-data.md   ← 直近のパフォーマンスデータ（gitignore）
```

## Available Skills

### SAAF Ops（サイクル運用）
| Command | Phase | Description |
|---------|-------|-------------|
| `/set-company` | Set | 企業情報（ICP・ポジショニング等）を対話で一括ヒアリング |
| `/set-latest` | Set | 業界トレンド・プラットフォーム仕様変更を `knowledge/latest/` に書き戻す |
| `/saaf-check` | Meta | Set充足率・次の一手を診断 |
| `/feedback` | Feedback | 施策結果を検証ゲート付きで `knowledge/results/` と `knowledge/company/` に反映 |

### Executive Review（経営レビュー）
| Command | Role | Description |
|---------|------|-------------|
| `/ceo-review` | CEO | 収益性・ROI・事業インパクト評価 |
| `/cmo-review` | CMO | マーケティング戦略全体の統括レビュー |

### Specialist Agents（専門エージェント）
| Command | Role | Description |
|---------|------|-------------|
| `/seo` | SEO | SEO分析・KW戦略・技術SEO |
| `/creative-director` | CD | クリエイティブ品質・ブランド一貫性 |
| `/ui-review` | UI/UX | LP/WebページのUI・CVR最適化 |
| `/ads` | Ads | Google/Meta/X広告の設計・最適化 |
| `/content` | Content | ブログ・SNS・メールの企画・制作 |
| `/analytics` | Analytics | KPI分析・レポート・改善提案 |

### Workflows（統合ワークフロー）
| Command | Description |
|---------|-------------|
| `/campaign-launch` | キャンペーンの全工程（企画→制作→レビュー→ローンチ） |
| `/content-review` | コンテンツの制作→多角的レビューサイクル |
| `/landing-page` | LP設計→制作→最適化 |
| `/weekly-retro` | 週次マーケティング振り返り |

## Architecture

```
cmobot/
├── CLAUDE.md                    # Main orchestration
├── AGENTS.md                    # Agent definitions & org chart
├── .claude/settings.json        # Skill definitions
│
├── knowledge/                   # 4-tier knowledge base
│   ├── foundation/              # Stable: frameworks, mindset (tracked)
│   ├── company.example/         # Template for company/ (tracked)
│   ├── company/                 # Company-specific: ICP, brand (gitignored — per-project)
│   ├── latest/                  # External volatile: platform updates, industry trends (tracked)
│   ├── results.example/         # Template for results/ (tracked)
│   └── results/                 # Company-specific: performance data (gitignored — per-project)
│
├── skills/                      # Individual agents & workflows
│   ├── set-company/SKILL.md     # SAAF: Set
│   ├── set-latest/SKILL.md      # SAAF: Set
│   ├── saaf-check/SKILL.md      # SAAF: Meta (diagnostic)
│   ├── feedback/SKILL.md        # SAAF: Feedback
│   ├── ceo-review/SKILL.md
│   ├── cmo-review/SKILL.md
│   ├── seo/SKILL.md
│   ├── creative-director/SKILL.md
│   ├── ui-review/SKILL.md
│   ├── ads/SKILL.md
│   ├── content/SKILL.md
│   ├── analytics/SKILL.md
│   ├── campaign-launch/SKILL.md
│   ├── content-review/SKILL.md
│   ├── landing-page/SKILL.md
│   └── weekly-retro/SKILL.md
│
├── templates/                   # Reusable content templates
│   ├── ad-copy.md
│   ├── landing-page.md
│   ├── email-sequence.md
│   ├── blog-post.md
│   └── social-media.md
│
└── lib/                         # Shared components
    ├── preamble.md
    ├── review-format.md
    └── scoring-rubric.md
```

## Knowledge Architecture

```
┌─────────────────────────────────────────────────────┐
│ Foundation (stable, tracked)                         │
│ marketing-mindset, growth-frameworks,                │
│ brand-strategy, metrics-glossary                     │
├─────────────────────────────────────────────────────┤
│ Company (semi-stable, gitignored — per-project)      │
│ company-overview, icp, positioning,                  │
│ brand-guidelines, competitors                        │
├─────────────────────────────────────────────────────┤
│ Latest (external volatile, tracked)                  │
│ platform-updates, industry-trends                    │
├─────────────────────────────────────────────────────┤
│ Results (company-specific results, gitignored)       │
│ performance-data                                     │
└─────────────────────────────────────────────────────┘

Executive agents   → foundation + company
Specialist agents  → foundation + company + latest + results
Workflow agents    → delegates to sub-agents

Write targets:
  /set-company  → company/
  /set-latest   → latest/
  /feedback     → results/ (raw numbers) + company/ (verified learnings)
```

## Marketing Cycle = SAAF Cycle

CMObotのマーケティングサイクルは、そのままSAAFのサイクルです:

```
            SAAF:  Set ──→ Ask ──→ Action ──→ Feedback ──→ (Setに還元)

/campaign-launch or /weekly-retro kicks off the cycle:

  ┌──────────┐     ┌──────────┐     ┌──────────┐     ┌──────────┐
  │   Set    │ ──→ │   Ask    │ ──→ │  Action  │ ──→ │ Feedback │
  │/set-     │     │/cmo-review│     │/content  │     │/analytics│
  │ company  │     │/ceo-review│     │/ads      │     │/weekly-  │
  │/set-     │     │/seo /ui- │     │/landing- │     │  retro   │
  │ latest   │     │  review  │     │  page    │     │/feedback │
  │/saaf-    │     │/creative-│     │/estimate │     │          │
  │  check   │     │  director│     │          │     │          │
  └──────────┘     └──────────┘     └──────────┘     └──────────┘
       ↑                                                   │
       └── /feedback + /set-latest で knowledge 層に還元 ──┘
```

## License

MIT
