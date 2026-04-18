# Results Knowledge Template — 企業固有の結果ログテンプレート

> **このディレクトリ（`knowledge/results.example/`）はテンプレートです。**
> 実際のパフォーマンス数値・学びは `knowledge/results/`（gitignore対象）に格納します。
> upstream への誤コミットを避けるため、企業固有のデータは本ディレクトリには書き込まないでください。

## この層の責務

SAAF の **Feedback** 段階で集まる、企業固有の結果データを記録します。

- 直近のパフォーマンスデータ（CVR・CPA・ROAS・LTV など実績値）
- 施策ごとの成功／失敗記録と検証途中の仮説
- まだ company 層に昇華していない学び（Nが足りない・再現性未確認のもの）

検証が済んで **普遍化できた** 学びは `/feedback` スキルが `knowledge/company/` に昇華します。
ここ（`results/`）は「生データ／途中段階の観測」の保管庫と考えてください。

## なぜ latest/ から分離しているか

- `latest/` — 外から入ってくる共有情報（プラットフォーム仕様・業界トレンド）。公開可能で upstream で共有されうる情報。
- `results/` — **中から出てくる企業固有の結果**。CVR や売上などの実数値は機密性が高く、gitignore で保護する。

これにより:
- 売上・CVR・CPAなどの機密数値が誤って public に漏れない
- `latest/` は全ユーザー共通の最新情報として素直に共有可能
- SAAFの4段階（S/A/A/F）と knowledge 4層（foundation / company / latest / results）が直接対応する

> 層の名前が `results/` でスキルの名前が `/feedback` と分かれているのは、SAAF の F 段階（Feedback）の **保管先** がこの層である、という役割分担を明確化するためです。

## セットアップ手順

### 1. テンプレートをコピー

```bash
cp -r knowledge/results.example knowledge/results
```

または `/feedback` を実行すると、未存在時に自動で同じコピーを行います。

### 2. 施策ごとに実績を書き戻す

- `performance-data.md` — 週次でのKPI実績を更新（CVR・CPA・ROAS 等）
- 施策終了時は `/feedback` スキルで一括記入
- 週次振り返りは `/flow-weekly-retro` が参照

## 注意事項

- **必ず `knowledge/results/` に書く**。`knowledge/results.example/` に書くと upstream に流れます。
- 検証済みで普遍化できる学びは **`knowledge/company/` に昇華**。ここ（results/）には生データを残す。
- トレンド・仕様変更など外部情報は `knowledge/latest/` 側。ここには書かない。
