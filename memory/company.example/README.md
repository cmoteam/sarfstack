# Company Memory Template — 企業固有情報テンプレート

> **このディレクトリ（`memory/company.example/`）はテンプレートです。**
> 実際の企業情報は `memory/company/`（gitignore対象）に格納します。
> upstream への誤コミットを避けるため、企業固有情報は本ディレクトリには書き込まないでください。

## なぜ分離しているか

- `company.example/` — upstream（このリポジトリ）で管理するテンプレート。全ユーザー共通。
- `company/` — あなたの企業の実情報。**gitignore** されており、upstream に push されません。

これにより:
- `git pull` で upstream のテンプレート更新を素直に取り込める
- ICP・競合情報・ブランドガイドラインなどの機密情報が誤って public に漏れない
- 同じ `sarfstack` クローンを複数プロジェクトで使い分けやすい（`company/` だけ差し替え）

## セットアップ手順

### 1. テンプレートをコピー

```bash
cp -r memory/company.example memory/company
```

または `/set-company` を実行すると、未存在時に自動で同じコピーを行います。

### 2. 以下のファイルを、あなたの企業の情報で埋める

1. **company-overview.md** — 事業概要、ミッション、主要プロダクト
2. **icp.md** — 理想的な顧客像（Ideal Customer Profile）
3. **positioning.md** — 市場ポジショニング、競合との差別化
4. **brand-guidelines.md** — ブランドガイドライン、トーン&マナー
5. **competitors.md** — 競合情報、競合との比較

`[TODO]` マーカーを実際の情報で置き換えてください。対話でまとめて埋めるには `/set-company` を使います。

## 注意事項

- 情報が不十分でも SARFStack は動作しますが、レビューの精度が下がります。
- 機密情報を書き込む先は **必ず `memory/company/`**（gitignore対象）側です。`memory/company.example/` に書き込むと upstream に push されうるので注意してください。
- 定期的に情報を更新してください（特に競合情報とポジショニング）。
