# Organization Memory Template — 組織レベル情報テンプレート

> **このディレクトリ（`memory/organization.example/`）はテンプレートです。**
> 実際の組織情報は `memory/organization/`（gitignore対象）に格納します。
> upstream への誤コミットを避けるため、組織固有情報は本ディレクトリには書き込まないでください。

## 位置づけ

SARFStack の memory は **2層** で構成されています:

| 層 | パス | スコープ | 担当スキル | 典型的な内容 |
|---|---|---|---|---|
| **Organization** | `memory/organization/` | 組織全体（全 workspace 共通） | `/set-organization` | ミッション / ビジョン / 組織ブランド / 事業ポートフォリオ |
| **Workspace (Profile)** | `memory/profile/`（`workspaces/<active>/profile/` への symlink） | 単一 workspace（事業部・プロダクト・クライアント） | `/set-workspace` | 事業概要 / ICP / Positioning / 競合 |

**使い分けの原則**: 全 workspace に共通する情報は organization 層へ。workspace ごとに異なる情報は workspace 層へ。

## セットアップ手順

### 1. テンプレートをコピー

```bash
cp -r memory/organization.example memory/organization
```

または `/set-organization` を実行すると、未存在時に自動で同じコピーを行います。

### 2. 以下のファイルを、あなたの組織の情報で埋める

1. **organization-overview.md** — 組織全体のミッション・ビジョン・事業ポートフォリオ
2. **brand-guidelines.md** — 組織として共有するブランドガイドライン・トーン&マナー

`[TODO]` マーカーを実際の情報で置き換えてください。対話でまとめて埋めるには `/set-organization` を使います。

## 注意事項

- 組織は1つなので `memory/organization/` は **単一インスタンス**（workspace のような複数持ちはしない）
- 機密情報を書き込む先は **必ず `memory/organization/`**（gitignore対象）側です。`memory/organization.example/` に書き込むと upstream に push されうるので注意してください
- 組織ブランドと workspace ブランドに差分が出てきた場合は、workspace 固有の brand-guidelines を `memory/profile/` 側に追加して **override** する運用を推奨（inheritance は導入しない）
