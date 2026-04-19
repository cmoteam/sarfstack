# Measurement & Incrementality — 計測と増分効果の科学

「ROASが3.0ある」— それは本当に広告が売った結果か、**広告がなくても起きた売上**ではないか？
**Attribution（誰が売ったか）** と **Incrementality（広告のおかげでどれだけ増えたか）** は別物。
クッキーレス時代・プライバシー規制強化の中、アトリビューションの仮定は崩れ、**因果推論的な計測**が必須になっている。

## アトリビューションの限界

従来のアトリビューションモデル：

| モデル | 考え方 | 問題点 |
|--------|-------|--------|
| **Last Click** | 最後のクリックに全振り | 初期接点を過小評価 |
| **First Click** | 最初のクリックに全振り | 刈り取り段階を過小評価 |
| **Linear** | 全接点に均等配分 | 重要度を反映しない |
| **Time Decay** | 直前接点ほど重く | 理論的根拠が薄い |
| **Position Based** | 最初と最後を重く | 任意の重み付け |
| **Data-Driven（GA4）** | 機械学習で推定 | ブラックボックス、計測漏れに弱い |

**根本問題**：アトリビューションは「広告Aと広告Bのどちらがより寄与したか」は議論できても、
**「そもそも広告Aがなかったら売上はどうなっていたか」**という**反事実（Counterfactual）**を測れない。

## クッキーレスショック

### 何が起きているか
- **Safari ITP**（2017〜）— 3rd Party Cookieほぼ全滅、1st Party Cookieも7日制限
- **iOS 14.5 ATT**（2021〜）— Metaが$10B売上影響と公表
- **Chrome Cookie削除**（段階的、Privacy Sandboxへ移行）
- **GDPR / CCPA / 改正個人情報保護法** — 同意ベースへ
- **Apple Mail Privacy Protection** — メール開封率が虚構化

### 結果
- ユーザー単位のクロスデバイス追跡が崩壊
- Meta / Google広告の最適化が劣化
- コンバージョン計測漏れ 10〜40%

### 対応策
- **Server-Side Tagging**（sGTM） — ブラウザでなくサーバー経由で計測
- **Conversion API（CAPI）** — Meta・TikTokなどにサーバーサイドで送信
- **Enhanced Conversions**（Google） — ハッシュ化メールで補完
- **Modeled Conversions** — 計測漏れをML推定で補完
- **Data Clean Room** — プライバシー保護下でのデータ突合（AWS Clean Room / Google Ads Data Hub / Meta Advanced Analytics）

## Incrementality Testing — 増分効果の測定

**因果推論的アプローチ**で「広告のおかげで増えた分」を測る。

### ① Conversion Lift / Holdout Test

```
Test群     ─ 広告配信 ─→ CV率 X%
Control群  ─ 非配信  ─→ CV率 Y%
Lift = X - Y = 増分
```

- Meta/Googleが公式機能として提供（Conversion Lift Study）
- 2〜4週間、一定予算が必要（$50K〜）
- 最もピュアな因果測定

### ② Geo Lift Test（地理分割）

全ユーザーをHoldoutせず、**地域単位**で分割：
- Test地域（例: 関東）で広告ON
- Control地域（例: 関西）でOFF
- 売上差分から増分を推定

- プラットフォーム非依存（TV / OOH / PR も測定可）
- 難易度: 地域の類似性、季節性調整（**Synthetic Control法**）
- ツール: Meta Robyn GeoLift、Google Meridian、Recast

### ③ Matched Market Test
類似市場ペアを作り、片方で施策実施。伝統的TV広告測定の派生。

### ④ Interrupted Time Series / Switchback
同じ地域で**時期をずらしてON/OFF**を繰り返す。
（例: 奇数週ON / 偶数週OFF）

## Marketing Mix Modeling（MMM）の復権

- **ユーザー単位の計測に頼らない統計モデル**
- 売上 = f(チャネル別支出, 季節性, 外部要因, トレンド)
- 回帰分析で各チャネルの貢献度を推定
- **1st Party Data不要 / Cookieless耐性あり**

### オープンソースMMMの登場
クッキーレスでGAFAがMMMを一般開放した：
- **Meta Robyn**（R / Python）— 2021年公開
- **Google Meridian**（Python、2024年公開）— 後継。TensorFlow Probability使用
- **LightweightMMM**（Google、Bayesian MMM）

### MMMの強みと弱み

| ○ Pros | ✕ Cons |
|--------|--------|
| Cookieless耐性 | 過去データ2年以上必要 |
| 全チャネル統合（TV / デジタル / OOH / PR） | モデラーのスキル依存 |
| 飽和曲線（Adstock / Saturation）を考慮 | 短期の個別最適には弱い |
| 因果的解釈がしやすい | 新規チャネルの推定が弱い |

### MMM + Incrementality + Attribution = Unified Measurement

最新トレンド：3層を組み合わせる
```
MMM                       ─ 戦略レベル（予算配分）
Incrementality Testing    ─ 戦術レベル（個別施策検証）
Attribution / Last Click  ─ 運用レベル（日々の最適化）
```

## Brand Lift Study — ブランド指標の測定

認知・好意度・購入意向は**売上に出る前に動く**。

### 測定手法
- **Meta / Google Brand Lift Survey** — 広告配信ユーザーへのアンケート
- **独自パネル調査**（Nielsen / Kantar / ネオマーケティング等）
- **指名検索量（Google Trends / Search Console）**
- **SOV（Share of Voice）/ SOM（Share of Market）**

### ベンチマーク（Binet & Field）
**ブランディング：刈り取り = 60:40** が長期ROI最大化の黄金比。

## Data Clean Room — プライバシー時代の突合基盤

- 広告主 × プラットフォームのデータを**個人特定せず**に突合
- 1st Party DataをCookieなしで活用
- 代表例: Google Ads Data Hub、Meta Advanced Analytics、Amazon Marketing Cloud、AWS Clean Room、Snowflake Clean Room

### ユースケース
- 広告接触者 × 自社CRMでLTV分析
- 未CV接触者のクロスチャネル動向
- 顧客セグメント別のCPAリアル測定

## 実務でのMeasurement Stack（2026年現在の推奨）

```
ガバナンス層:
  ├ CDP（Segment / Treasure Data）
  ├ Data Warehouse（Snowflake / BigQuery）
  └ Reverse ETL（Hightouch / Census）

計測層:
  ├ Server-Side GTM + CAPI
  ├ Enhanced Conversions
  └ Consent Management Platform（OneTrust等）

分析層:
  ├ MMM（Meridian / Robyn）
  ├ Incrementality（GeoLift / Conversion Lift）
  ├ Attribution（GA4 / Adobe Data-Driven）
  └ BI（Looker / Tableau）
```

## ダッシュボード設計の原則

1. **指標は"意思決定"につながるものだけ** — 見る指標 > 飾る指標
2. **Leading（先行）とLagging（遅行）を分ける** — CPC/CTR（先行）とLTV/NRR（遅行）
3. **North Star Metric → Key Driver → Operational** の3層構造
4. **比較対象を必ず付ける** — 前週比 / 前年比 / 目標比
5. **Segment別に見る** — 全体の平均は嘘をつく

## よくある計測の誤り

| 誤り | 実態 |
|------|------|
| 「Last ClickでROAS 3.0」 | Last Clickは貢献度を歪める |
| 「Facebookの効果が落ちた」 | iOS 14.5以降の計測漏れの可能性 |
| 「SEOでCV増えた」 | ブランド広告の波及効果の可能性 |
| 「ブランド広告は測れないから止める」 | 長期では指名検索・NRRが下がる |
| 「全部Incrementality Testingで測る」 | コストと期間で現実的でない、MMMと併用 |
| 「ダッシュボードで自動化」 | **数字の解釈**こそ人間の仕事 |

## 参考文献

- *Hacking Growth* — Sean Ellis（計測章）
- *The Long and the Short of It* — Les Binet & Peter Field
- *How Brands Grow* — Byron Sharp
- Meta Robyn公式ドキュメント / Google Meridian公式
- Recast "Incrementality Testing" ブログシリーズ
- Analytic Edge / Analytics Demystified
- Measured.com / Haus / INCRMNTAL（Incrementality SaaS）ブログ
- Avinash Kaushik *Web Analytics 2.0*
- IAB / MMA 公式ガイドライン

## SAAFとの接続

- **Set**: 現状の計測スタック、主要KPIツリー、計測の既知の穴を `memory/company/` に書く
- **Ask**: 「このチャネルでIncrementality Testを設計して」「このMMM結果を解釈して」
- **Action**: GeoLift実装、Conversion Lift発注、MMMモデル構築、ダッシュボード改修
- **Feedback**: Test結果から得た「真のROAS / 増分係数」を `memory/results/performance-data.md` に記録、予算配分の根拠に
