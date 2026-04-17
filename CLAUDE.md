# CMObot — Virtual Marketing Organization

CMObotは、Claude Code / Codex 上で動作する仮想マーケティング組織です。
企業のマーケティング担当者、スタートアップのグロース担当、広告代理店の担当者が、
AIエージェントチームと協働してマーケティング業務を遂行するためのフレームワークです。

## Operating Model — SAAF

CMObotの全スキルは **SAAF** サイクルの上で動作します。SAAFはAI時代のマーケティングの基本OSであり、個別のフレームワーク（AARRR・STP・RAM-CE等）の上位に位置する「AIとの関わり方の型」です。

```
Set ─→ Ask ─→ Action ─→ Feedback ─┐
 ↑                                  │
 └──────────────────────────────────┘
```

- **S — Set**: 自分の情報（事業・ICP・ブランド・数字・制約）をAIに伝える
- **A — Ask**: AIとのコミュニケーション。誰の視点で・何を・どの形式で出させるか問いを組む
- **A — Action**: 出てきたアイデアの中から判断して実装する（本番反映して初めて完了）
- **F — Feedback**: 結果をAIに戻してリファインし、次のSetを更新する

SAAFの各段階はCMObotの構造に対応しています:

| SAAF | CMObotでの担い手 |
|------|-----------------|
| Set | `knowledge/` 3層（foundation / company / latest） |
| Ask | レビュー系スキル（`/cmo-review` `/ceo-review` `/seo` `/creative-director` 等） |
| Action | 制作系スキル / ワークフロー（`/content` `/ads` `/landing-page` `/campaign-launch` 等） |
| Feedback | 分析系スキル（`/analytics` `/weekly-retro`）→ 知識ベースに還元 |

詳細は `knowledge/foundation/saaf-framework.md` を参照。

## Available Skills

以下のスラッシュコマンドで各エージェントを呼び出せます:

### Executive Review（経営レビュー）
- `/ceo-review` — 収益性・ビジネス観点からの施策レビュー
- `/cmo-review` — マーケティング戦略全体の統括レビュー

### Specialist Agents（専門エージェント）
- `/seo` — SEO分析・キーワード戦略・技術SEO監査
- `/ui-review` — LP/広告クリエイティブのUI/UXレビュー
- `/ads` — 広告運用（Google/Meta/X）の設計・分析・最適化
- `/creative-director` — クリエイティブの品質・ブランド一貫性チェック
- `/content` — コンテンツマーケティング（記事・SNS・メール）
- `/analytics` — KPI分析・レポーティング・アトリビューション
- `/estimate` — 見積り・工数計算・費用対効果シミュレーション（代理店視点）

### Workflows（統合ワークフロー）
- `/campaign-launch` — キャンペーン企画→制作→レビュー→ローンチの全工程
- `/content-review` — コンテンツ制作→多角的レビューサイクル
- `/landing-page` — LP設計→制作→最適化サイクル
- `/weekly-retro` — 週次マーケティング振り返り

## Knowledge Architecture

知識ベースは3層に分離されています。各スキルは必要に応じて適切な層を読み込みます。

### Foundation（不変の知識）
`knowledge/foundation/` — マーケティングのフレームワーク、マインドセット、原則。
めったに変更されない普遍的な知識。全スキルの基盤として暗黙的に参照される。

### Company（企業固有情報）
`knowledge/company/` — 事業概要、ICP、ポジショニング、ブランドガイドライン、競合情報。
プロジェクト開始時にユーザーが記入する。施策レビュー時に必ず参照される。

### Latest（最新情報）
`knowledge/latest/` — プラットフォームアップデート、業界トレンド、直近のパフォーマンスデータ。
頻繁に更新される揮発性の情報。実行系スキルが参照する。

## Principles

1. **忖度しない** — 数字とロジックに基づいた率直なフィードバック。「いいと思います」で終わらない。
2. **実行ベース** — アドバイスだけでなく、実際の成果物（コピー、HTML、設定値）を出力する。Actionまで到達して初めて完了。
3. **根拠を示す** — すべての提案に理由・データ・フレームワークの裏付けを添える。
4. **SAAFサイクルを回す** — Set→Ask→Action→Feedbackのループを1つのワークフローで完結させる。Feedbackを怠らない。
5. **知識を分離する** — 普遍的な知識と揮発性の情報を混ぜない。SetとFeedbackが汚染されないよう、検証済みの知見のみをknowledge/companyに記入する。

## How Knowledge Loading Works

各SKILL.mdの冒頭で、以下のパターンで知識を読み込みます:

```
# Required Knowledge
Read: knowledge/company/company-overview.md
Read: knowledge/company/icp.md
Read: knowledge/foundation/growth-frameworks.md
Read: knowledge/latest/performance-data.md
```

スキルの性質に応じて読み込む知識層が異なります:
- **Executive Review** → foundation + company（戦略判断に必要）
- **Specialist Agents** → foundation + company + latest（実行に必要）
- **Workflows** → 内包するスキルが個別に読み込む

これはSAAFの **Set** 段階に相当します。スキル実行前に `[TODO]` が残っているファイルがあれば、それは Set が未完成ということ。Ask の前に Set を整えることが、成果物の質を決めます。
