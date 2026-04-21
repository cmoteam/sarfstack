# private/ — SARFStack Private Data

SARFStack の **会社ごとのプライベートリポジトリ**。`sarfstack/private/` にクローンして使う。upstream（sarfstack 本体）からは gitignore されているため、ここに書いたものは流出しない。

## なぜ別リポジトリか

`private/` は会社ごとに中身が違う（組織情報・workspace・実績数値）。submodule にすると URL を upstream に pin することになるので、**独立したプライベートリポジトリをクローンする**運用にしている。

## ディレクトリ構成

```
private/
├── memory/                     — SARF の Set 層の実体（全スキルが参照）
│   ├── organization/           組織全体（ミッション / ポートフォリオ / ブランド）
│   └── workspaces/
│       ├── active → <slug>     現在のアクティブ workspace（symlink）
│       └── <slug>/
│           ├── profile/        ICP / Positioning / Competitors
│           └── results/        実績数値・施策検証ログ（/feedback が書く）
└── output/                     — 全スキルの一次成果物（YYYYMMDD-{skill}-{slug}.{ext}）
    └── <workspace>/
```

テンプレートは upstream の `templates/memory/` にある。

## Setup

```bash
# 1. 本体を clone
git clone <sarfstack-upstream> sarfstack
cd sarfstack

# 2. この private リポを clone
git clone <your-company-private-repo> private

# 3. organization 層を初期化（未作成なら）
bin/init-private

# 4. workspace を作成
bin/workspace new <slug>
```

## 運用ルール

- **コミットは private リポに対して行う**（upstream には流れない）
- `memory/workspaces/active` は symlink。`bin/workspace switch <slug>` で張り替え
- `output/` は成果物置き場。必要なら `.gitignore` で除外しても良い
- シークレット（API キー等）は memory/ に書かず、環境変数 or `.mcp.json` に置く

詳細は upstream の `CLAUDE.md` と `knowledge/base/sarf-framework.md` を参照。
