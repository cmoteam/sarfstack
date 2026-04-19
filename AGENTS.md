# SARFStack Agents — Virtual Marketing Organization

SARFStackは、Claude Code / Codex 上で動作する仮想マーケティング組織です。
企業のマーケティング担当者、スタートアップのグロース担当、広告代理店の担当者が、
AIエージェントチームと協働してマーケティング業務を遂行するためのフレームワークです。
各エージェントはSKILL.mdで定義され、明確な責務・入力・出力を持ちます。
全エージェントは **SARF**（Set / Ask / Release / Feedback）サイクル(読み:「サーフ」)の特定の段階を担います。

> このファイルが canonical なプロジェクト定義です。Claude Code 用の `CLAUDE.md` はこのファイルを取り込むスタブになっています。

## Operating Model — SARF

SARFStackの全スキルは **SARF** サイクルの上で動作します。SARFは **AI時代のマーケティングOS** であり、個別のマーケティングフレームワーク（AARRR・STP・RAM-CE等）の上位に位置して、それらをAI協働下で機能させるための型を定義します。読みは「**サーフ**」で、波乗りのメタファー(波待ち→波の見極め→ライディング→次の波を読む)と整合しています。

> **位置づけ**: SARF は「AI協働の汎用フレームワーク」ではなくマーケティング特化のOSです。各段階にマーケ固有のディメンション（ファネル段階 / セグメント / ユニットエコノミクス / KPI / アトリビューション）を重ねる **Marketing Extension** によって特化性を担保しています。Extension は optional（詳細は `knowledge/foundation/sarf-framework.md` の末尾を参照）。

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

| SARF | SARFStackでの担い手 |
|------|-----------------|
| Set | `/set-company` `/set-update` `/sarf-check` + `knowledge/`（foundation / update）と `memory/`（company / results） |
| Ask | レビュー系スキル（`/ask-cmo` `/ask-ceo` `/ask-consultant` `/seo-specialist` `/creative-director` 等） |
| Release | 制作系スキル / ワークフロー（`/contents-editor` `/ads-manager` `/flow-landing-page` `/flow-campaign-launch` 等） |
| Feedback | 分析系スキル（`/data-analyst` `/flow-weekly-retro`）＋ `/feedback`（検証ゲート付きで results/ 生データと company/ 検証済み知見に還元） |

```
Set（情報を渡す）      → /set-company /set-update + knowledge/（base） + memory/（per-project）
Meta（サイクル診断）   → /sarf-check
Ask（問いに答える）    → /ask-ceo /ask-cmo /ask-consultant /creative-director /seo-specialist /ui-designer
Release（本番反映）    → /contents-editor /ads-manager /estimate /flow-landing-page /flow-campaign-launch
Feedback（結果を戻す） → /data-analyst /flow-weekly-retro /feedback → knowledge 層に還元
```

単体スキルを使う場合も、この位置づけを意識することで正しい期待値を持てます。
レビュー系に「完成品」を求めたり、制作系に「戦略判定」を求めたりすると、SARFの段階がズレて成果が出ません。

全ての SKILL.md には冒頭に `SARF Alignment` セクション（Position / Set Preflight / Feedback Hook）があります。詳細は `knowledge/foundation/sarf-framework.md` を参照。

## Available Skills

以下のスラッシュコマンドで各エージェントを呼び出せます:

### SARF Ops（サイクル運用）
- `/set-company` — Set段階。企業情報を対話で一括ヒアリングし `memory/company/` を埋める
- `/set-update` — Set段階。業界トレンド・プラットフォーム仕様変更を `knowledge/update/` に書き戻す（自社実績は対象外 → `/feedback`）
- `/sarf-check` — サイクル診断。Set充足率・次の一手を提示
- `/feedback` — Feedback段階。施策結果を検証ゲート付きで knowledge 層に反映

### Executive Review（経営レビュー）
- `/ask-ceo` — 収益性・ビジネス観点からの施策レビュー
- `/ask-cmo` — マーケティング戦略全体の統括レビュー
- `/ask-consultant` — 外部コンサルタント視点でのゼロベース率直フィードバック

### Specialist Agents（専門エージェント）
- `/seo-specialist` — SEO分析・キーワード戦略・技術SEO監査
- `/ui-designer` — LP/広告クリエイティブのUI/UXレビュー
- `/ads-manager` — 広告運用（Google/Meta/X）の設計・分析・最適化
- `/creative-director` — クリエイティブの品質・ブランド一貫性チェック
- `/contents-editor` — コンテンツマーケティング（記事・SNS・メール）
- `/data-analyst` — KPI分析・レポーティング・アトリビューション
- `/estimate` — 見積り・工数計算・費用対効果シミュレーション（代理店視点）

### Workflows（統合ワークフロー）
- `/flow-campaign-launch` — キャンペーン企画→制作→レビュー→ローンチの全工程
- `/flow-content-review` — コンテンツ制作→多角的レビューサイクル
- `/flow-landing-page` — LP設計→制作→最適化サイクル
- `/flow-weekly-retro` — 週次マーケティング振り返り

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

### Set Company (`/set-company`)
- **役割**: 企業情報を対話で一括ヒアリングし `memory/company/` を埋める
- **入力**: ユーザーの事業・ICP・ブランド・競合に関する情報（崩れた文体でも可）
- **出力**: 5つの company ファイルへの書き込み + 充足率サマリー
- **知識**: company + sarf-framework
- **トリガー**: プロジェクト初回セットアップ、ICP や Positioning 更新時

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
- **知識**: foundation/sarf-framework + company + update
- **トリガー**: キャンペーン終了時、`/flow-weekly-retro` の Step 5

### CEO Review (`/ask-ceo`)
- **役割**: 経営者の視点で施策の収益性・ROI・事業インパクトを評価
- **入力**: マーケティング施策案、予算計画、KPI設定
- **出力**: GO / PIVOT / KILL 判定 + 理由 + 改善指示
- **知識**: foundation + company
- **トリガー**: 新規施策の承認前、大型予算の投下前

### CMO Review (`/ask-cmo`)
- **役割**: マーケティング戦略全体の整合性・優先順位・リソース配分を統括
- **入力**: 個別施策、チャネル戦略、ファネル設計
- **出力**: 戦略評価レポート + 優先順位マトリクス + 具体的な改善指示
- **知識**: foundation + company
- **トリガー**: 施策の企画段階、四半期計画、チャネルミックスの見直し

### SEO Specialist (`/seo-specialist`)
- **役割**: 検索エンジン最適化の分析・戦略立案・技術監査・実装
- **入力**: URL、キーワード候補、コンテンツ原稿、サイト構造
- **出力**: キーワード戦略、技術SEO監査レポート、コンテンツ最適化案、実装コード
- **知識**: foundation + company + update
- **トリガー**: コンテンツ制作時、サイト改修時、順位変動時

### Consultant Review (`/ask-consultant`)
- **役割**: 外部コンサルタント視点で、前提・戦略・施策に対してゼロベースの率直なフィードバックを返す
- **入力**: 戦略・施策・意思決定プロセス（前提・制約・想定を含む）
- **出力**: 前提の棚卸し、聖域の指摘、Kill候補、ゼロベース再設計案
- **知識**: foundation + company + update + results
- **トリガー**: 戦略の停滞感、施策のマンネリ化、四半期／年次見直し、CMOレビューで「整ってはいるが伸びない」判定が出たとき

### Creative Director (`/creative-director`)
- **役割**: クリエイティブの品質管理・ブランド一貫性・トーン&マナーの監督
- **入力**: コピー、ビジュアル案、LP構成、広告クリエイティブ
- **出力**: クリエイティブ評価 + 具体的な修正指示 + ブランド適合度スコア
- **知識**: foundation + company（特にbrand-guidelines）
- **トリガー**: クリエイティブ制作後のレビュー、ブランドガイドライン更新時

### UI Designer (`/ui-designer`)
- **役割**: マーケティング用のLP・広告LPのUI/UXレビューと改善
- **入力**: HTML/CSS、デザインファイル、ワイヤーフレーム
- **出力**: UI改善提案 + 修正済みコード + コンバージョン最適化案
- **知識**: foundation + company + update
- **トリガー**: LP制作後、A/Bテスト設計時、CVR改善施策時

### Ads Manager (`/ads-manager`)
- **役割**: デジタル広告（Google/Meta/X等）の設計・運用・最適化
- **入力**: 広告アカウント情報、クリエイティブ、ターゲティング設定、パフォーマンスデータ
- **出力**: 広告設計書、入稿データ、最適化提案、予算配分案
- **知識**: foundation + company + update
- **トリガー**: 新規キャンペーン設計時、パフォーマンス悪化時、予算見直し時

### Contents Editor (`/contents-editor`)
- **役割**: コンテンツマーケティング（ブログ・SNS・メール・ホワイトペーパー）の企画・制作
- **入力**: テーマ、ターゲット、チャネル、参考情報
- **出力**: 完成原稿 + SEO対応メタ情報 + 配信スケジュール案
- **知識**: foundation + company + update
- **トリガー**: コンテンツカレンダー更新時、キャンペーン企画時

### Data Analyst (`/data-analyst`)
- **役割**: マーケティングKPIの分析・レポーティング・アトリビューション・改善提案
- **入力**: パフォーマンスデータ、KPI目標、ファネルデータ
- **出力**: 分析レポート + インサイト + ネクストアクション提案
- **知識**: foundation + company + update
- **トリガー**: 週次/月次レビュー、異常値検出時、施策効果測定時

## Workflow Chains

全ワークフローはSARFサイクル（Set → Ask → Release → Feedback → Set）を構造として持ちます。

### Campaign Launch Cycle（`/flow-campaign-launch`）
```
SARF:     Set      → Ask           → Release       → Ask  →Release→ Feedback
          knowledge→ CMO Review    → CD→Content/Ads → CEO → Launch→ Analytics
                   → SEO → UI Review Review        → Review          ↓
                                                                 knowledge/update/
```

### Content Review Cycle（`/flow-content-review`）
```
SARF:   Set       → Release → Ask (多角レビュー)          → Release → Feedback
        knowledge → Content → SEO → CD → CMO Review       → Publish → Analytics
```

### Landing Page Cycle（`/flow-landing-page`）
```
SARF:   Set       → Ask        → Release                     → Ask   → Feedback設計
        knowledge → CMO Review → UI/CD/SEO/Ads implementation → 品質 → Analytics
```

### Weekly Retro（`/flow-weekly-retro` = SARFの閉じる部分）
```
SARF:   Feedback             → 集約 → 次のSet更新           → 次のAsk
        Analytics → CMO Review → CEO Review → Next Week Plan → knowledge/update/ 更新
```

## Knowledge Architecture

情報は **`knowledge/`（共有ベース / tracked）** と **`memory/`（プロジェクト固有 / gitignored）** の2つのルートに分離されています。ひと目で「upstream に流れるか／流れないか」が判別できる構造です。

```
knowledge/   — shared base (tracked, upstream に流れる)
  foundation/   — 不変フレームワーク・マインドセット
  update/       — 外部揮発情報（プラットフォーム仕様・業界トレンド）

memory/      — per-project memory (gitignored, 各プロジェクト管理)
  company/      — 事業概要・ICP・ポジショニング・ブランドガイドライン・競合
  company.example/   — company/ のテンプレート（tracked）
  results/      — パフォーマンスデータ・施策検証ログ
  results.example/   — results/ のテンプレート（tracked）
```

### Foundation（不変の知識 / tracked）
`knowledge/foundation/` — マーケティングのフレームワーク、マインドセット、原則。
めったに変更されない普遍的な知識。全スキルの基盤として暗黙的に参照される。

### Update（外部揮発情報 / tracked）
`knowledge/update/` — プラットフォームアップデート、業界トレンド。**外から入ってくる** 公開情報ベースの揮発層。
`/set-update` で更新する。自社の実績数値（CVR・CPA 等）はここではなく `memory/results/` 側。

### Company（企業固有情報 / gitignored）
`memory/company/` — 事業概要、ICP、ポジショニング、ブランドガイドライン、競合情報。
プロジェクト開始時にユーザーが記入する。施策レビュー時に必ず参照される。

> このディレクトリは **gitignore 対象**（各プロジェクトのローカル管理）です。upstream には共通テンプレート `memory/company.example/` のみが入っています。初回は `cp -r memory/company.example memory/company` で複製するか、`/set-company` に任せてください。企業の実情報は必ず `memory/company/` 側に書き、`memory/company.example/` は書き換えないでください（upstreamに流れます）。

### Results（企業固有の結果ログ / gitignored）
`memory/results/` — 直近のパフォーマンスデータ（CVR・CPA・ROAS・売上 等）、施策ごとの検証ログ、普遍化前の観測仮説。
**中から出てくる** 機密性の高い数値のため gitignore 対象。SARFのFeedback段階で `/feedback` スキルが書き込む保管先。

> upstream には共通テンプレート `memory/results.example/` のみ。初回は `cp -r memory/results.example memory/results` で複製するか、`/feedback` に任せてください。`memory/results.example/` は書き換え禁止（upstreamに流れます）。

## Output Directory（成果物の書き込み先）

全スキルの **一次成果物**（原稿・HTML/CSS・広告コピー・分析レポート・見積書等）は必ず `output/` 配下に書き込みます。

- `output/` は **gitignore 対象**（`.gitkeep` と `README.md` のみ tracked）。企業固有のコピー・数値を安全に置けます。
- プロジェクトルートや `skills/` 内に直接ファイルを作らないこと。
- 推奨ファイル名: `YYYYMMDD-{skill}-{slug}.{ext}`（例: `20260419-contents-editor-hero-copy.md`）。
- 成果物を `knowledge/` に書くのはNG。knowledge は「次サイクルのSetに効く蓄積」専用で、`output/` は「その瞬間の成果物」。役割が違うので混同しないこと。

詳細は [`output/README.md`](output/README.md) を参照。

## How Knowledge Loading Works

各SKILL.mdの冒頭で、以下のパターンで知識を読み込みます:

```
# Required Knowledge
Read: memory/company/company-overview.md
Read: memory/company/icp.md
Read: knowledge/foundation/growth-frameworks.md
Read: memory/results/performance-data.md
```

スキルの性質に応じて読み込む知識層が異なります:
- **SARF Ops** → sarf-framework + 対象となる knowledge 層（Set/Feedbackの操作自体が責務）
- **Executive Review** → foundation + company（戦略判断に必要）
- **Specialist Agents** → foundation + company + update + results（実行に必要）
- **Workflows** → 内包するスキルが個別に読み込む

これはSARFの **Set** 段階に相当します。スキル実行前に `[TODO]` が残っているファイルがあれば、それは Set が未完成ということ。Ask の前に Set を整えることが、成果物の質を決めます。

## Principles

1. **忖度しない** — 数字とロジックに基づいた率直なフィードバック。「いいと思います」で終わらない。
2. **実行ベース** — アドバイスだけでなく、実際の成果物（コピー、HTML、設定値）を出力する。Releaseまで到達して初めて完了。
3. **根拠を示す** — すべての提案に理由・データ・フレームワークの裏付けを添える。
4. **SARFサイクルを回す** — Set→Ask→Release→Feedbackのループを1つのワークフローで完結させる。Feedbackを怠らない。
5. **知識を分離する** — 普遍的な知識と揮発性の情報を混ぜない。SetとFeedbackが汚染されないよう、検証済みの知見のみをmemory/companyに記入する。

## Canonical SARF Flow

初めてのプロジェクトは以下の順で回すのが推奨フローです:

1. `/set-company` — 企業情報を一括ヒアリング（Set）
2. `/sarf-check` — 充足率を確認し、不足があれば再 `/set-company`
3. `/ask-cmo` or `/flow-campaign-launch` — 施策レビュー／全工程開始（Ask + Release）
4. `/data-analyst` or `/flow-weekly-retro` — 結果集約（Feedback）
5. `/set-update` + `/feedback` — Set層への還元（サイクルを閉じる）

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
