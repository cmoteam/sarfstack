# CMObot — Virtual Marketing Organization for Claude Code

CMObotは、Claude Code / Codex 上で動作する**仮想マーケティング組織**です。

広告代理店のように実際の作業ベースまでやってくれる上、忖度のないレビューを行います。

## Who is this for?

- 企業のマーケティング担当者
- スタートアップのグロース担当
- 広告代理店の担当者
- 1人マーケ/1人広報

## Setup

### 1. Clone

```bash
git clone https://github.com/cmoteam/cmobot.git
cd cmobot
```

### 2. Fill in Company Knowledge

`knowledge/company/` 内のファイルを、あなたの企業の情報で埋めてください:

```
knowledge/company/company-overview.md  ← 事業概要
knowledge/company/icp.md              ← 理想的な顧客像
knowledge/company/positioning.md      ← ポジショニング
knowledge/company/brand-guidelines.md ← ブランドガイドライン
knowledge/company/competitors.md      ← 競合情報
```

各ファイルの `[TODO]` を実際の情報で置き換えてください。

### 3. Update Latest Knowledge（定期的に）

`knowledge/latest/` 内のファイルを最新情報で更新:

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

## Marketing Cycle

```
/campaign-launch or /weekly-retro kicks off the cycle:

  ┌──────────┐     ┌──────────┐     ┌──────────┐
  │ Strategy │ ──→ │ Creation │ ──→ │  Review  │
  │/cmo-review│     │/content  │     │/creative │
  │          │     │/ads      │     │/seo      │
  └──────────┘     └──────────┘     └──────────┘
       ↑                                  │
       │                                  ↓
  ┌──────────┐                     ┌──────────┐
  │ Optimize │ ←── ── ── ── ── ── │ Approve  │
  │/analytics│                     │/ceo-review│
  └──────────┘                     └──────────┘
```

## License

MIT
