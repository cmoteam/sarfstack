# CMObot Agents

CMObotは以下のエージェントで構成される仮想マーケティング組織です。
各エージェントはSKILL.mdで定義され、明確な責務・入力・出力を持ちます。
全エージェントは **SAAF**（Set / Ask / Action / Feedback）サイクルの特定の段階を担います。

## SAAF上の役割分担

```
Set（情報を渡す）      → knowledge/ 3層 + ユーザーからの追加情報
Ask（問いに答える）    → /ceo-review /cmo-review /creative-director /seo /ui-review
Action（実装する）     → /content /ads /landing-page /campaign-launch
Feedback（結果を戻す） → /analytics /weekly-retro → knowledge/latest/ に還元
```

単体スキルを使う場合も、この位置づけを意識することで正しい期待値を持てます。
レビュー系に「完成品」を求めたり、制作系に「戦略判定」を求めたりすると、SAAFの段階がズレて成果が出ません。

## Organization Chart

```
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
                    │  Analytics   │  効果測定・改善提案
                    └─────────────┘
```

## Agent Definitions

### CEO Review (`/ceo-review`)
- **役割**: 経営者の視点で施策の収益性・ROI・事業インパクトを評価
- **入力**: マーケティング施策案、予算計画、KPI設定
- **出力**: GO / PIVOT / KILL 判定 + 理由 + 改善指示
- **知識**: foundation + company
- **トリガー**: 新規施策の承認前、大型予算の投下前

### CMO Review (`/cmo-review`)
- **役割**: マーケティング戦略全体の整合性・優先順位・リソース配分を統括
- **入力**: 個別施策、チャネル戦略、ファネル設計
- **出力**: 戦略評価レポート + 優先順位マトリクス + 具体的な改善指示
- **知識**: foundation + company
- **トリガー**: 施策の企画段階、四半期計画、チャネルミックスの見直し

### SEO Specialist (`/seo`)
- **役割**: 検索エンジン最適化の分析・戦略立案・技術監査・実装
- **入力**: URL、キーワード候補、コンテンツ原稿、サイト構造
- **出力**: キーワード戦略、技術SEO監査レポート、コンテンツ最適化案、実装コード
- **知識**: foundation + company + latest
- **トリガー**: コンテンツ制作時、サイト改修時、順位変動時

### Creative Director (`/creative-director`)
- **役割**: クリエイティブの品質管理・ブランド一貫性・トーン&マナーの監督
- **入力**: コピー、ビジュアル案、LP構成、広告クリエイティブ
- **出力**: クリエイティブ評価 + 具体的な修正指示 + ブランド適合度スコア
- **知識**: foundation + company（特にbrand-guidelines）
- **トリガー**: クリエイティブ制作後のレビュー、ブランドガイドライン更新時

### UI Review (`/ui-review`)
- **役割**: マーケティング用のLP・広告LPのUI/UXレビューと改善
- **入力**: HTML/CSS、デザインファイル、ワイヤーフレーム
- **出力**: UI改善提案 + 修正済みコード + コンバージョン最適化案
- **知識**: foundation + company + latest
- **トリガー**: LP制作後、A/Bテスト設計時、CVR改善施策時

### Ads Specialist (`/ads`)
- **役割**: デジタル広告（Google/Meta/X等）の設計・運用・最適化
- **入力**: 広告アカウント情報、クリエイティブ、ターゲティング設定、パフォーマンスデータ
- **出力**: 広告設計書、入稿データ、最適化提案、予算配分案
- **知識**: foundation + company + latest
- **トリガー**: 新規キャンペーン設計時、パフォーマンス悪化時、予算見直し時

### Content Specialist (`/content`)
- **役割**: コンテンツマーケティング（ブログ・SNS・メール・ホワイトペーパー）の企画・制作
- **入力**: テーマ、ターゲット、チャネル、参考情報
- **出力**: 完成原稿 + SEO対応メタ情報 + 配信スケジュール案
- **知識**: foundation + company + latest
- **トリガー**: コンテンツカレンダー更新時、キャンペーン企画時

### Analytics (`/analytics`)
- **役割**: マーケティングKPIの分析・レポーティング・アトリビューション・改善提案
- **入力**: パフォーマンスデータ、KPI目標、ファネルデータ
- **出力**: 分析レポート + インサイト + ネクストアクション提案
- **知識**: foundation + company + latest
- **トリガー**: 週次/月次レビュー、異常値検出時、施策効果測定時

## Workflow Chains

全ワークフローはSAAFサイクル（Set → Ask → Action → Feedback → Set）を構造として持ちます。

### Campaign Launch Cycle（キャンペーンローンチ）
```
SAAF:     Set      → Ask           → Action        → Ask  →Action→ Feedback
          knowledge→ CMO Review    → CD→Content/Ads → CEO → Launch→ Analytics
                   → SEO → UI Review Review        → Review          ↓
                                                                 knowledge/latest/
```

### Content Review Cycle（コンテンツレビュー）
```
SAAF:   Set       → Action  → Ask (多角レビュー)          → Action  → Feedback
        knowledge → Content → SEO → CD → CMO Review       → Publish → Analytics
```

### Landing Page Cycle（LP制作）
```
SAAF:   Set       → Ask        → Action                      → Ask   → Feedback設計
        knowledge → CMO Review → UI/CD/SEO/Ads implementation → 品質 → Analytics
```

### Weekly Retro（週次振り返り = SAAFの閉じる部分）
```
SAAF:   Feedback             → 集約 → 次のSet更新           → 次のAsk
        Analytics → CMO Review → CEO Review → Next Week Plan → knowledge/latest/ 更新
```

## Agent Communication Protocol

エージェント間の引き継ぎは以下のフォーマットで行われます。
SAAFの観点では、「前のエージェントのAction成果物を、次のエージェントのSet（前提）として渡す」操作に相当します。

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
