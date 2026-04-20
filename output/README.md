# output/ — Generated Artifacts

SARFStack の各スキルが生成した成果物（LP の HTML/CSS、広告コピー、分析レポート、キーワード一覧、見積書など）の出力先です。

- **このディレクトリは `.gitignore` 対象**です（`.gitkeep` と `README.md` のみ tracked）。upstream には流れないため、企業固有の数値・コピー・機密情報を安全に置けます。
- **成果物は必ず `output/<workspace>/` 配下に書き込む**こと。ルート直下や `.claude/skills/` 内に直接ファイルを作らないでください。
- 推奨ファイル名: `YYYYMMDD-{skill}-{slug}.{ext}`（例: `20260419-contents-edit-hero-copy.md`）。

## ディレクトリ構造（workspace 単位）

```
output/
├── <workspace-slug>/              # /workspace current と同じ slug
│   ├── ads/                       # /ads-manager の広告コピー・入稿データ
│   ├── content/                   # /contents-edit の原稿
│   ├── landing-page/              # /landing-page / /ui-design の HTML/CSS
│   ├── seo/                       # /seo のKWリスト・監査レポート
│   ├── analytics/                 # /data-analytics のレポート
│   ├── reviews/                   # /ceo-review /cmo-review /consultant-review /creative-direction
│   └── estimates/                 # /estimate の見積書
└── <another-workspace>/
    └── ...
```

workspace 単位に分けることで、代理店が複数クライアントを、または企業が複数事業部を並行で扱う際に、成果物の誤配・混在を防げます。各スキルは書き込み前に `readlink memory/profile | sed 's|workspaces/||; s|/profile||'` でアクティブ slug を取得し、`output/<slug>/...` に書き込みます。

## 知識ベースとの関係

| 目的 | 書き込み先 |
|------|-----------|
| 一次成果物（原稿・コード・レポート） | `output/<workspace>/` |
| 検証済み知見（ICP解像度、ブランド修正） | `memory/profile/` |
| 実績数値・生ログ | `memory/results/` |
| 業界・プラットフォームの外部情報 | `knowledge/update/` |

`output/` は「その瞬間の成果物」、`knowledge/` は「次サイクルの Set に効く蓄積」と役割が異なります。混同しないこと。
