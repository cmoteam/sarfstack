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

### 2. Fill in Company Knowledge（= SAAFのSet）

SAAFの **Set** 段階。ここを埋めないとAIは汎用回答しか返せません。成果物の質の9割がここで決まります。
`knowledge/company/` 内のファイルを、あなたの企業の情報で埋めてください:

```
knowledge/company/company-overview.md  ← 事業概要
knowledge/company/icp.md              ← 理想的な顧客像
knowledge/company/positioning.md      ← ポジショニング
knowledge/company/brand-guidelines.md ← ブランドガイドライン
knowledge/company/competitors.md      ← 競合情報
```

各ファイルの `[TODO]` を実際の情報で置き換えてください。

### 3. Update Latest Knowledge（= SAAFのFeedbackをSetに還元）

SAAFの **Feedback** を次の **Set** に反映する層。施策を回すたびに、ここに数字と学びを書き戻してください:

```
knowledge/latest/platform-updates.md  ← プラットフォーム仕様変更
knowledge/latest/industry-trends.md   ← 業界トレンド
knowledge/latest/performance-data.md  ← 直近のパフォーマンスデータ
```

## Available Skills

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
├── knowledge/                   # 3-tier knowledge base
│   ├── foundation/              # Stable: frameworks, mindset
│   ├── company/                 # Company-specific: ICP, brand
│   └── latest/                  # Volatile: trends, data
│
├── skills/                      # Individual agents & workflows
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
│ Foundation (stable)                                  │
│ marketing-mindset, growth-frameworks,                │
│ brand-strategy, metrics-glossary                     │
├─────────────────────────────────────────────────────┤
│ Company (semi-stable)                                │
│ company-overview, icp, positioning,                  │
│ brand-guidelines, competitors                        │
├─────────────────────────────────────────────────────┤
│ Latest (volatile)                                    │
│ platform-updates, industry-trends,                   │
│ performance-data                                     │
└─────────────────────────────────────────────────────┘

Executive agents   → foundation + company
Specialist agents  → foundation + company + latest
Workflow agents    → delegates to sub-agents
```

## Marketing Cycle = SAAF Cycle

CMObotのマーケティングサイクルは、そのままSAAFのサイクルです:

```
            SAAF:  Set ──→ Ask ──→ Action ──→ Feedback ──→ (Setに還元)

/campaign-launch or /weekly-retro kicks off the cycle:

  ┌──────────┐     ┌──────────┐     ┌──────────┐     ┌──────────┐
  │   Set    │ ──→ │   Ask    │ ──→ │  Action  │ ──→ │ Feedback │
  │knowledge/│     │/cmo-review│     │/content  │     │/analytics│
  │  company │     │/ceo-review│     │/ads      │     │/weekly-  │
  │  latest  │     │/seo /ui- │     │/landing- │     │  retro   │
  │foundation│     │  review  │     │  page    │     │          │
  └──────────┘     └──────────┘     └──────────┘     └──────────┘
       ↑                                                   │
       └── knowledge/latest/ と knowledge/company/ に還元 ──┘
```

## License

MIT
