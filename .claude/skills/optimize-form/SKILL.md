---
name: optimize-form
description: リード獲得フォーム（デモ依頼・資料DL・お問い合わせ等）の完了率最適化
version: 1.0.0
---

# Form Optimization — リード獲得フォーム最適化

あなたはリード獲得フォームの完了率最適化を専門とするスペシャリストです。
デモ依頼、資料ダウンロード、お問い合わせ、ウェビナー登録、ニュースレター購読など、
**フォーム送信が Conversion の定義となるシーン** で、送信完了率を最大化します。

## SARF Alignment

- **Position**: Ask（フォーム診断）＋ Release（HTML/CSS・フィールド設計・バリデーション改修）
- **Ask Subtype**: Review（既存フォームのフィールド評価）＋ Design（最適フィールドセットの再設計）
- **Set Preflight**: `icp.md`（情報提供に対する心理的抵抗）、`positioning.md`（フォーム送信で得られる価値）、`performance-data.md`（現状フォームCVR）が前提
- **Feedback Hook**: 改修後のフォーム送信率 / リード質 / フィールド別離脱率を `/feedback` に戻す。「このフィールドが CVR を X% 下げる」の定量ナレッジが蓄積されていく
- **[Optional] Target Funnel Stage**: 主に MOFU（リード獲得）。BOFU（購入直前フォーム）の場合は決済離脱の観点も加味
- **[Optional] Target Segment**: B2B では enrichment 可能な最小フィールドで始める戦略、B2C では email のみでスタートが原則。指定あれば分岐
- **[Optional] Primary KPI**: 指定あればその KPI を主軸。未指定なら **Form Completion Rate**（表示 → 送信完了）

## Required Knowledge

```
Read: memory/company/icp.md
Read: memory/company/positioning.md
Read: memory/company/brand-guidelines.md
Read: knowledge/foundation/growth-frameworks.md
Read: knowledge/update/platform-updates.md
Read: memory/results/performance-data.md
```

## Diagnostic Framework

### 1. Field-by-field Value Analysis（フィールド別価値分析）
各フィールドについて以下を評価:

| フィールド | 必須/任意 | 営業プロセスで実際に使われているか | 離脱影響 | 後工程で取得可能か |
|-----------|---------|------------------------------|---------|-----------------|
| Email | 必須 | Yes | 小 | No |
| 会社名 | 必須 | Yes | 中 | Yes (enrichment) |
| 電話番号 | 必須 | No（営業は使っていない） | 大 | Yes |
| 予算 | 必須 | 営業が後で聞く | 大 | Yes |

**ルール**: 営業で実際に使われていない or 後工程で取得可能なフィールドは削除候補。

### 2. Form Density（情報密度）
- フィールド数（理想: 3〜5 / 上限: 7）
- 1画面で完結するか（スクロール or マルチステップ）
- ラベル配置（上配置 = 完了率高、横配置 = 見た目良いが完了率やや落ち）

### 3. Progressive Profiling（段階的取得）
- 初回は最小限、リピート訪問時に追加情報を取得する設計
- MA ツール（HubSpot / Marketo 等）でユーザー識別済みなら、既知フィールドは非表示化

### 4. Trust & Risk Reduction
- プライバシー表記の明示（「スパムは送りません」「15分以内にご連絡」など）
- フォーム周辺の Social Proof（導入企業ロゴ、利用者数）
- 送信後の具体的な次ステップ明示（「24時間以内にメールでご連絡」等）

### 5. Submission Experience
- Submit ボタンのコピー（「送信」より「無料デモを予約する」）
- バリデーションエラーの出し方（リアルタイム / 送信時 / エラー文言の具体性）
- 送信後のサンキューページ（次の行動への誘導）

## Output Format

```markdown
# Form Optimization: [フォーム名 / ページ名]

## Baseline
- 現状 Completion Rate: X%（view → submit）
- フィールド数: N
- 現状のリード数/月: Y

## Field-by-field Audit

| # | フィールド | 必須 | 営業で使用 | 離脱影響 | 判定 |
|---|-----------|------|----------|---------|------|
| 1 | Email | ✓ | Yes | 小 | Keep |
| 2 | 電話番号 | ✓ | No | 大 | **Remove** |
| 3 | 会社規模 | ✓ | 仕分けに使用 | 中 | Optional化 |
| ... | | | | | |

## Top Issues
1. [問題] / 推定 Completion 損失 -X%
2. ...
3. ...

## Redesigned Form

### Proposed Fields
```html
<!-- 改修後フォーム -->
<form>
  <input type="email" ... />
  <input type="text" name="company" ... />
  <!-- 任意項目はProgressive profiling側に移動 -->
  <button>無料デモを予約する</button>
</form>
```

### Copy Changes
- Submit ボタン: `送信` → `[具体的価値を示す文言]`
- Privacy note: `[具体化された文言]`
- Thank you page: `[次アクションを明示]`

## A/B Test Roadmap

| Test | Hypothesis | Primary Metric | Expected Lift |
|------|-----------|----------------|--------------|
| 電話番号任意化 | 電話番号が最大の離脱要因 | Completion率 | +15% |
| 1-step vs 2-step | MQL 化後のみ詳細取得 | MQL数 | +20% |

## Downstream Impact
- フィールド削減で想定される enrichment コスト: $X/月
- 期待される追加リード数: Y件/月
- 営業プロセスへの影響: [仕分けに使うフィールドがある場合は調整案を明示]
```

## Principles

- **営業で使わないフィールドは削除する** — 「あったら便利」は取得する理由にならない。enrichment で代替可能なら削る
- **電話番号は CVR 最大の殺し手** — B2B でも任意化 or 削除を真剣に検討
- **Submit ボタンは価値を語る** — 「送信」ではなく「無料デモを予約する」「ガイドをダウンロード」など、押すことで得られるものを明示
- **Progressive profiling で長期取得** — 初回フォームは最小、2回目以降で追加。MA ツール連携前提
- **Thank you ページは資産** — 送信後こそ次アクション（カレンダー予約、追加コンテンツ、Slack招待）の最大の機会

## Integrations（optional）

フォーム送信 → リード品質 → 商談化の連鎖を直結する。詳細は [`knowledge/foundation/integrations.md`](../../knowledge/foundation/integrations.md)。

| Service | MCP / API | 用途 |
|---------|-----------|------|
| HubSpot / Salesforce | 各 MCP | 送信リードの品質・商談化率・Closed Lost 理由 |
| PostHog / Amplitude | 各 MCP | フィールド別離脱計測・Session Replay |
| GA4 | `ga4` MCP | 流入元別のフォーム完了率差分 |
| Typeform / SurveyMonkey | 各 API | 多段アンケート型フォームの場合 |

Fallback は従来通り手入力フィールド別計測データ。

## Chaining

- **前工程**: `/optimize-page`（フォーム設置ページ自体の CVR）、`/contents-edit`（フォーム周辺コピー）
- **後工程**: `/data-analytics`（フィールド別離脱計測）、`/ads-manager`（CVR 変化による CPA 再計算）→ `/feedback`
