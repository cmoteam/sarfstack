# SARFStack Agents — Virtual Marketing Organization

SARFStackは Claude Code / Codex 上で動作する仮想マーケティング組織。各エージェントは SKILL.md で定義され、全員が **SARF**（Set / Ask / Release / Feedback、読み:「サーフ」）サイクルの特定段階を担います。`CLAUDE.md` が canonical、`AGENTS.md` はこのファイルを参照するスタブ（Codex 他ハーネス向け）。

## Operating Model — SARF

**AI時代のマーケティングOS**。個別フレームワーク（AARRR・STP・RAM-CE等）の上位に位置し、それらをAI協働下で機能させる型を定義します。マーケ固有ディメンション（ファネル段階 / セグメント / ユニットエコノミクス / KPI / アトリビューション）を重ねる **Marketing Extension** で特化性を担保（optional）。詳細は `knowledge/base/sarf-framework.md`。

```
Set ─→ Ask ─→ Release ─→ Feedback ─┐
 ↑                                    │
 └────────────────────────────────────┘
```

- **S — Set**: 自分の情報（事業・ICP・ブランド・数字・制約）をAIに伝える
- **A — Ask**: AIとのコミュニケーション。誰の視点で・何を・どの形式で出させるか問いを組む
- **R — Release**: 出てきたアイデアの中から判断して**本番環境に反映**する（本番反映して初めて完了）
- **F — Feedback**: 結果をAIに戻してリファインし、次のSetを更新する

| SARF | 担い手 |
|------|-------|
| Set | `/set-organization` `/set-brand` `/set-workspace` `/set-update` + `knowledge/` + `private/memory/` |
| Meta | `/sarf-check` `/next` |
| Ask | `/ceo-review` `/cmo-review` `/consultant-review` `/seo` `/creative-direction` `/ui-design` ほか |
| Release | `/contents-edit` `/ads-manager` `/estimate` `/optimize <target>` ほか |
| Feedback | `/data-analytics` + `/feedback`（検証ゲート付きで results/ と profile/ に還元） |

Workflows（`campaign-launch` / `content-review` / `landing-page` / `weekly-retro`）は複数段階を横断する束ね役。`.claude/workflows/` 配下、**現状未実装**。

全 SKILL.md 冒頭に `SARF Alignment` セクション（Position / Set Preflight / Feedback Hook）あり。Ask系・Release系には optional な `Target Funnel Stage` / `Target Segment` / `Primary KPI` フィールドがある（記入すれば解像度が上がる、空欄でも動作する）。

## Available Skills

自動検出されたスキル一覧は会話開始時のシステムリマインダー参照。カテゴリ別詳細は `knowledge/base/agent-catalog.md`。

### 迷ったら
- **`/next`** — 現在の workspace 状態を見て次の一歩を**1つだけ**推薦（workspace 未作成もここで検出）
- `/sarf-check` — `/next` の詳細モード（充足率・ブロッカー・Marketing Extension を可視化）

### Workspace / SARF Ops
- `/workspace` — list / current / new / switch / remove
- `/set-organization` / `/set-brand` / `/set-workspace` / `/set-update` — Set 段階の各層
- `/feedback` — Feedback 段階

### Executive / Specialist / Optimization
- Executive: `/ceo-review` `/cmo-review` `/consultant-review`
- Specialist: `/seo` `/creative-direction` `/ui-design` `/ads-manager` `/contents-edit` `/data-analytics` `/customer-research` `/pricing-strategy` `/churn-prevention` `/estimate`
- Optimization: **`/optimize <target>`** — target = `page` / `signup-flow` / `onboarding` / `form` / `popup` / `paywall`

## Knowledge Architecture

```
knowledge/           — shared base (tracked, upstream に流れる)
  base/                 不変フレームワーク・マインドセット
  update/               外部揮発情報（プラットフォーム仕様・業界トレンド）

templates/memory/    — memory 層のテンプレート (tracked)
  organization/         private/memory/organization/ のテンプレ
  profile/              private/memory/workspaces/<slug>/profile/ のテンプレ
  results/              private/memory/workspaces/<slug>/results/ のテンプレ

private/memory/      — per-workspace memory (gitignored)
  organization/         組織全体（単一インスタンス）
  workspaces/<slug>/profile/  事業プロフィール（ICP / Positioning / Competitors 等）
  workspaces/<slug>/results/  実績数値・施策検証ログ
  workspaces/active  → <slug>  アクティブ symlink（全スキルが参照）
```

初回セットアップ: `bin/init-private` で organization 層を作成、`bin/workspace new <slug>` で workspace を追加。

**workspace** は「SARF Set（ICP・Positioning・Brand・Competitors・実績）が独立して成立する最小スコープ」。事業部 / クライアント / プロダクトラインなど。`default` は使わない。

### 各層の責務

- **`knowledge/base/`** — 普遍的フレームワーク（めったに変更しない）
- **`knowledge/update/`** — 外部揮発情報。`/set-update` で更新。自社実績は対象外
- **`private/memory/organization/`** — 組織全体共通。ミッション / ビジョン / 事業ポートフォリオ / ブランドガイドライン
- **`private/memory/workspaces/<slug>/profile/`** — workspace 固有。ICP / Positioning / 競合。ブランド差分が必要なら `brand-guidelines.md` を追加して override
- **`private/memory/workspaces/<slug>/results/`** — workspace 固有の実績数値・検証ログ。`/feedback` が書き込む

**inheritance は導入しない**。共通情報が workspace に重複するのは許容（SKILL.md にマージ責務を波及させない設計）。

## Output Directory

全スキルの一次成果物は `private/output/<workspace>/` に書き込みます（`<workspace>` は `readlink private/memory/workspaces/active` で取得）。

- `private/output/` は gitignore 対象
- プロジェクトルートや `.claude/skills/` 内に直接ファイルを作らない
- 推奨ファイル名: `YYYYMMDD-{skill}-{slug}.{ext}`
- `knowledge/` に成果物を書くのは NG（knowledge は「次サイクルの Set に効く蓄積」専用）

## Skills vs Agents

Skill（`.claude/skills/`）と Agent（`.claude/agents/`）の2種類。レビュー系（CEO / CMO / Consultant / SEO / Creative Direction）は agent 化済（skill は thin dispatcher）、それ以外は基本 skill。詳細は `knowledge/base/skills-vs-agents.md`。

## Integrations

各スキルは Figma / GA4 / Google Ads / Meta / HubSpot / Salesforce / Stripe / Slack / Notion / BigQuery / PostHog / Amplitude 他と MCP 経由で直結可能。

- **カタログ**: `knowledge/base/integrations.md`
- **設定**: `.mcp.json.example` を `.mcp.json` にコピー（gitignored）。シークレットは環境変数
- **ガードレール**: Write は必ず承認ゲート / Read-only から開始 / 最小 scope / PII は匿名化

未接続時は従来の CSV 手入力にフォールバック。

## Principles

1. **忖度しない** — 数字とロジックに基づいた率直なフィードバック
2. **実行ベース** — アドバイスで終わらず成果物（コピー・HTML・設定値）まで出す。Release まで到達して完了
3. **根拠を示す** — すべての提案に理由・データ・フレームワーク裏付けを添える
4. **SARFサイクルを回す** — Feedback を怠らない。1つのワークフローで Set→Ask→Release→Feedback を完結
5. **知識を分離する** — 普遍知識と揮発情報を混ぜない。検証済みの知見のみ `private/memory/workspaces/active/profile/` に書く

## Canonical SARF Flow

初回プロジェクトの推奨順:

0. `/workspace new <slug>` — workspace を1つ作成（実在する事業名で）
1. `/set-organization` — 組織情報
2. `/set-brand` — ブランドガイドライン
3. `/set-workspace` — workspace 固有情報
4. `/next` — 次の一歩確認（詳細は `/sarf-check`）。不足があれば 1〜3 に戻る
5. `/cmo-review`（Ask 単体）or `/campaign-launch`（Set〜Feedback 横断ワークフロー）
6. `/data-analytics` or `/weekly-retro` — 結果集約
7. `/set-update` + `/feedback` — Set 層への還元（サイクルを閉じる）

## Agent Communication Protocol

エージェント間の引き継ぎは以下のフォーマット（前のエージェントの Release 成果物を次のエージェントの Set として渡す操作）:

```markdown
## Handoff: [送信元Agent] → [受信先Agent]

### Context
[何についてのレビュー/作業か]

### Findings
[発見事項・成果物のサマリー]

### Action Items for Next Agent
- [ ] [具体的なアクション1]

### Artifacts
[成果物へのパス or インラインの成果物]
```
