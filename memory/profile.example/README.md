# Workspace Profile Template — workspace 固有情報テンプレート

> **このディレクトリ（`memory/profile.example/`）はテンプレートです。**
> 実際の workspace 情報は `memory/workspaces/<slug>/profile/`（gitignore対象）に格納され、
> `memory/profile/` はアクティブ workspace への symlink として機能します。
> upstream への誤コミットを避けるため、固有情報は本ディレクトリには書き込まないでください。

## 位置づけ

SARFStack の memory は **2層** で構成されています:

| 層 | パス | スコープ | 担当スキル | 典型的な内容 |
|---|---|---|---|---|
| **Organization** | `memory/organization/` | 組織全体（全 workspace 共通） | `/set-organization` | ミッション / ビジョン / 組織ブランド / 事業ポートフォリオ |
| **Workspace (Profile)** | `memory/profile/`（`workspaces/<active>/profile/` への symlink） | 単一 workspace（事業部・プロダクト・クライアント） | `/set-workspace` | 事業概要 / ICP / Positioning / 競合 |

**使い分けの原則**: 全 workspace に共通する情報は organization 層へ。workspace ごとに異なる情報は workspace 層へ。

## なぜ分離しているか

- `profile.example/` — upstream（このリポジトリ）で管理するテンプレート。全ユーザー共通。
- `workspaces/<slug>/profile/` — あなたの workspace の実情報。**gitignore** されており、upstream に push されません。

これにより:
- `git pull` で upstream のテンプレート更新を素直に取り込める
- ICP・競合情報などの機密情報が誤って public に漏れない
- 同じ `sarfstack` クローンを複数 workspaceで使い分けやすい

## セットアップ手順

新規 workspace は `/workspace new <slug>` で作成します。内部で `memory/profile.example/` の中身が `memory/workspaces/<slug>/profile/` にコピーされ、symlink が張り替わります。

### 以下のファイルを、workspace の情報で埋める

1. **business-overview.md** — この workspace の事業概要
2. **icp.md** — 理想的な顧客像（Ideal Customer Profile）
3. **positioning.md** — 市場ポジショニング、競合との差別化
4. **competitors.md** — 競合情報、競合との比較

`[TODO]` マーカーを実際の情報で置き換えてください。対話でまとめて埋めるには `/set-workspace` を使います。

> **ブランドガイドライン** は組織層（`memory/organization/brand-guidelines.md`）に集約されました。
> workspace 固有のブランド差分が必要になったら、このディレクトリに `brand-guidelines.md` を追加して **override** する運用を推奨。

## 注意事項

- 情報が不十分でも SARFStack は動作しますが、レビューの精度が下がります
- 機密情報を書き込む先は **必ず `memory/workspaces/<slug>/profile/`**（gitignore対象）側です。`memory/profile.example/` に書き込むと upstream に push されうるので注意
- 定期的に情報を更新してください（特に競合情報とポジショニング）
