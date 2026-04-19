# output/ — Generated Artifacts

SARFStack の各スキルが生成した成果物（LP の HTML/CSS、広告コピー、分析レポート、キーワード一覧、見積書など）の出力先です。

- **このディレクトリは `.gitignore` 対象**です（`.gitkeep` と `README.md` のみ tracked）。upstream には流れないため、企業固有の数値・コピー・機密情報を安全に置けます。
- **各スキルは必ず `output/` 配下に書き込む**こと。プロジェクトルートや `skills/` 内に直接ファイルを作らないでください。
- 生成ファイルのファイル名は原則 `YYYYMMDD-{skill}-{slug}.{ext}` を推奨（例: `20260419-contents-editor-hero-copy.md`）。

## 推奨サブディレクトリ

スキルごと、または成果物タイプごとに自由に切って構いません。目安:

```
output/
├── ads/                  # /ads-manager の広告コピー・入稿データ
├── content/              # /contents-editor の原稿
├── landing-page/         # /flow-landing-page / /ui-designer のHTML/CSS
├── seo/                  # /seo-specialist のKWリスト・監査レポート
├── analytics/            # /data-analyst のレポート
├── reviews/              # /ask-ceo /ask-cmo /ask-consultant /creative-director のレビュー
└── estimates/            # /estimate の見積書
```

## 知識ベースとの関係

| 目的 | 書き込み先 |
|------|-----------|
| 一次成果物（原稿・コード・レポート） | `output/` |
| 検証済み知見（ICP解像度、ブランド修正） | `memory/company/` |
| 実績数値・生ログ | `memory/results/` |
| 業界・プラットフォームの外部情報 | `knowledge/update/` |

`output/` は「その瞬間の成果物」、`knowledge/` は「次サイクルの Set に効く蓄積」と役割が異なります。混同しないこと。
