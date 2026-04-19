# MarTech & RevOps — マーケティングテクノロジーとレベニューオペレーション

現代マーケティングは**データとツールの総体**で動く。
ツール選定・データ統合・運用体制がボトルネックになれば、どんな戦略も失敗する。
**MarTech**はマーケ単体のツールスタック、**RevOps**はマーケ・営業・CS を**共通のオペレーションで統一**する組織/技術戦略。

## MarTechスタックの全体像

```
┌────────────────── Experience Layer ──────────────────┐
│  Web / App / Email / Ads / Chat / SNS / Events       │
└───────────────────────────────────────────────────────┘
                        ↕
┌────────────────── Orchestration Layer ───────────────┐
│  Marketing Automation / CDP / CRM / Chatbot          │
└───────────────────────────────────────────────────────┘
                        ↕
┌────────────────── Data Layer ────────────────────────┐
│  Data Warehouse / CDP / Customer Data Database       │
│  Reverse ETL / Data Clean Room                       │
└───────────────────────────────────────────────────────┘
                        ↕
┌────────────────── Infrastructure Layer ──────────────┐
│  Consent / Identity / Analytics / BI / AI            │
└───────────────────────────────────────────────────────┘
```

**Scott Brinker (chiefmartec.com)** によると、2024年時点でMarTechソリューションは **14,000+ 社**。全て使うのは不可能で、**スタック設計**が核心。

## 代表的なツール分類と選択肢

### CRM（顧客情報の中心）
- **HubSpot** — SMB〜中堅、マーケ・営業・CS統合
- **Salesforce** — 中堅〜Enterprise、拡張性最強
- **Pipedrive** — 小規模営業組織
- **Zoho / Freshsales** — コスパ志向
- **Attio** — 新世代、API-First

### Marketing Automation（MA）
- **HubSpot / Marketo / Pardot** — B2B王道
- **Customer.io / Braze / Iterable** — 行動ベースライフサイクル
- **Klaviyo** — EC特化
- **ActiveCampaign / Mailchimp** — 中小企業
- **Ortoo / SATORI / b→dash** — 国内B2B

### Customer Data Platform（CDP）
- **Segment（Twilio）** — デベロッパー向け、イベント収集
- **mParticle** — モバイル強い
- **Treasure Data** — 日本国内・Enterprise
- **RudderStack** — OSS / Warehouse-Native
- **Hightouch / Census（Reverse ETL）** — Warehouse-Nativeアプローチ

### Data Warehouse
- **Snowflake** — マルチクラウド対応、Clean Room
- **BigQuery** — Google広告と親和性、GA4連携
- **Redshift** — AWS環境
- **Databricks** — ML / データサイエンス統合

### Analytics / BI
- **GA4** — Webアクセス解析、Free
- **Amplitude / Mixpanel** — プロダクト分析
- **Looker / Tableau / Power BI** — BI汎用
- **Hex / Omni / Mode** — 新世代BI、SQL+Notebook

### Ads Management
- **Google Ads / Meta Ads Manager** — 直接
- **Skai / Madgicx / Trapica** — マルチチャネル管理
- **Smartly / Pencil** — Creative Automation

### SEO
- **Ahrefs / SEMrush / Sistrix** — 被リンク・競合分析
- **Screaming Frog** — テクニカルSEO
- **Search Console / Bing Webmaster** — 公式

### Email
- **Postmark / SendGrid / Mailgun** — Transactional
- **Customer.io / Braze / Klaviyo** — マーケ用（上記MA重複）

### Landing Page / CMS
- **Webflow / Framer** — デザイン×コード
- **WordPress** — 汎用
- **Unbounce / Instapage** — LP特化
- **Studio / STUDIO** — 日本国内

### Chat / Conversational
- **Intercom / Drift / Front** — 会話型マーケ
- **Zendesk** — サポート統合
- **ChatPlus / KARTE** — 日本国内

## Composable MarTech — 合成可能なスタック

従来：**Suite Marketing Platform**（Salesforce / HubSpot が全部提供）
現在：**Best-of-Breed Composable Stack**（個別最高を組み合わせる）

### Composableの前提
- **Data Warehouse中心設計**（Snowflake / BigQueryがSSOT）
- **Reverse ETL**でWarehouse → 各ツールへデータ送信（Hightouch / Census）
- **API / Webhook前提**のツール選定
- 個別ツールの置き換えコストが低い

### メリット
- ベストオブブリード選択
- ベンダーロックイン回避
- 機能アップデート速度が早い

### デメリット
- 統合・運用コスト増
- データモデリング・ガバナンスが必須
- 人材の専門性依存

## Reverse ETL — 現代MarTechの核心

**Data Warehouse → SaaSツール**へデータを戻す仕組み。

```
従来ETL:        SaaS → Warehouse（分析用）
Reverse ETL:   Warehouse → SaaS（運用用）
```

### ユースケース
- BigQueryの**セグメント定義 → Metaカスタムオーディエンス**
- Snowflakeの**解約予兆モデル → Customer.io のWin-Backメール**
- WarehouseのLTV計算 → Salesforceに戻し営業優先度に反映
- 複数ソースの購買履歴 → 広告配信除外リスト

**Single Source of Truth（SSOT）**がWarehouseで実現する鍵。

## Identity Resolution — 顧客統合

同一人物が複数デバイス・複数チャネルでどう繋がるかを解決する。

### 手法
- **Deterministic（決定論的）** — ログインID・メール・電話番号でマッチ
- **Probabilistic（確率論的）** — デバイス情報・行動パターンで推定（精度低）
- **Clean Room** — プライバシー保護下での突合

### クッキーレス時代のIdentity
- **UID 2.0 / ID5 / RampID** — 広告業界の共通IDソリューション
- **Customer 360** — 自社で統合するCDP機能
- **Google Privacy Sandbox** — Chromeネイティブ

## Consent Management Platform（CMP）

GDPR / CCPA / 改正個人情報保護法対応：

- **OneTrust** — Enterprise標準
- **Cookiebot / Usercentrics** — 欧州系
- **Trustarc** — 北米系
- **PrivacyTools / Axeptio / CustomerIO Consent** — 新興

**Consent-Mode**（Google）でConsent状態に応じて計測方式を変える実装が標準化。

## RevOps（Revenue Operations）とは

**Marketing / Sales / Customer Success の3部門を統合した運用組織・システム**。

### 背景
- 従来：各部門が**別々のツール・別々のKPI・別々のレポーティング**で運用
- 問題：リードの受け渡し遅延、二重計上、戦略の不整合、Customer Journey分断
- RevOpsで**一つの収益パイプラインとして全段階を設計**

### RevOpsの責務
1. **Tech Stack Consolidation** — 重複ツール整理、統合設計
2. **Data Governance** — ソースの真実、定義統一
3. **Process Design** — リード受け渡し、Deal Review、Forecast
4. **Analytics / Insights** — 統合ダッシュボード、Funnel Conversion
5. **Enablement** — ツール教育、プロセス変更支援

### RevOps組織モデル
- **Centralized（中央集権）** — 独立部門が全体設計
- **Embedded（埋込）** — 各部門内にOpsメンバー
- **Hybrid** — 中央戦略＋各部門実行

**従業員50〜200名規模で専任化**されることが多い。

## KPIの統合定義

RevOps導入で最初に揉めるのは**用語と定義**。

| 指標 | マーケ定義 | 営業定義 | RevOps統一定義 |
|------|----------|---------|---------------|
| **Qualified Lead** | Form入力者 | Call成立者 | 明文化する |
| **Pipeline** | 見込み売上 | 確度70%+ | Stage定義で明文化 |
| **Churn** | 月次解約 | 契約未更新 | Gross/Net, Logo/Revenue分離 |
| **CAC** | マーケ支出/新規 | マーケ＋セールス/新規 | Fully Loaded CAC |

## Data Governance — データガバナンス

### 必須の整備項目
1. **Schema Design** — イベント命名、プロパティ定義
2. **Tracking Plan** — 何を計測するかの設計書
3. **Data Dictionary** — 全指標の定義集
4. **Ownership** — 各データの責任者
5. **Quality Monitoring** — データ欠損・異常検知（Monte Carlo / Datafold）

### Tracking Plan例
```
Event Name: signup_completed
Properties:
  - user_id (string, required)
  - plan (enum: free|pro|enterprise, required)
  - signup_method (enum: email|google|sso, required)
  - utm_source, utm_medium, utm_campaign (string, optional)
  - referrer (string, optional)
  - timestamp (ISO8601, required)
```

**命名規則・命令形/過去形・スネークケース統一**などを最初に決める。後で変更すると全歴史データが不整合になる。

## AIマーケティング層（2025〜）

MarTechの新層として**AI Automation**が台頭：

- **AI Copy / Content**: Jasper / Copy.ai / Writer / Claude / ChatGPT
- **AI Video**: Runway / HeyGen / Synthesia / Veo / Sora
- **AI Voice**: ElevenLabs / Descript
- **AI Image**: Midjourney / Flux / Stable Diffusion / Adobe Firefly
- **AI Customer Service**: Ada / Intercom Fin / Decagon
- **AI SDR**: 11x.ai / Regie.ai / Clay
- **AI Analyst**: Hex Magic / Julius / ThoughtSpot Sage
- **Agent Framework / Workflow**: Claude Agent SDK / LangChain / n8n / Zapier

**CMObotもこの層に位置する。** AIが各機能を横断して"オペレーションの接着剤"になる。

## ツール選定の原則

1. **Jobs to be Doneで選ぶ** — 機能リストではなく、解決したい仕事
2. **既存スタックとの統合可能性** — API / Webhook / ネイティブ連携
3. **データの所有権** — 退出時にエクスポートできるか
4. **Time to Value** — 導入から価値出まで（90日が目安）
5. **TCO（総保有コスト）** — ライセンス＋実装＋運用＋教育
6. **ベンダーのロードマップ** — 今後3年生存できるか
7. **コミュニティ・エコシステム** — SI / 代理店 / 外部エキスパート人材

## スタック肥大化の罠

- ツール導入はほぼ全て**採択より廃止が難しい**
- 年に一度は**スタック監査**（使用率、重複、ROI）を実施
- 「使ってない機能の80%」で年間数百万〜数億円のムダが発生
- **Shadow IT**（各チームが勝手に導入するSaaS）の管理

### Consolidation（統合）のトレンド
- 2020年代前半：Best-of-Breed万能
- 2020年代後半：コスト圧縮 → Suite回帰の流れ（HubSpot・Salesforceの拡大）
- AI統合で**中堅ツールがAI機能で一気に機能拡大**（競争激化）

## 参考文献

- *Hacking Marketing* — Scott Brinker（MarTech論の古典）
- *Marketing Technology Landscape* — chiefmartec.com 年次
- *The Revenue Acceleration Rules* — Seth Marrs & Craig Rosenberg
- *Composable CDP* — Hightouch ホワイトペーパー
- *Revenue Operations* — Stephen Diorio & Chris Hummel
- Gartner Magic Quadrant: MA / CRM / CDP
- Forrester Wave: RevOps
- MarTech.org / Chief Martec ブログ
- Reforge: "Marketing Architecture" コース

## SAAFとの接続

- **Set**: 現状のツールスタック、データソース、データ定義、既知のデータギャップを `memory/company/` に書く
- **Ask**: 「このスタックで重複・ギャップを洗い出して」「Reverse ETLで接続すべきデータセットは？」
- **Action**: ツール選定・導入・データモデリング・Tracking Plan実装・ダッシュボード構築
- **Feedback**: データ品質スコア、ツールROI、Time to Insightを `knowledge/latest/` に記録
