---
name: workspace
description: SARFStack のアクティブ workspace を切り替え・一覧・新規作成する管理スキル。memory/workspaces/<slug>/ と memory/profile / memory/results シンボリックリンクを操作する。事業部・クライアント・プロダクトなど、SARF Set が独立して成立する単位ごとに分離して運用する。
---

# Workspace Manager

SARFStack は `memory/workspaces/<slug>/{profile,results}/` に **workspace 単位** で memory を分離して保持します。workspace は「SARF Set（ICP / Positioning / Brand / Competitors / 実績数値）が独立して成立する最小スコープ」を指し、以下のいずれでも構いません:

- 代理店の **クライアント**（`client-acme`, `client-beta`）
- 企業内の **事業部・プロダクトライン**（`acme-saas`, `acme-enterprise`, `acme-consumer`）
- スタートアップの **単一事業**（`<company>`、例: `acme`）

**`default` は使わない**。slug を空欄代わりに `default` で埋めると、workspace 分離という設計思想が機能しなくなる（複数事業を扱う時に境界が引けない / 中身が仮のまま固定化する）ため。最初から実在する事業名を slug にする。

全スキルは `memory/profile/...` `memory/results/...` というパスで memory を読むため、**どの workspace が「アクティブ」か** は `memory/profile` `memory/results` のシンボリックリンク先で決まります。このスキルはその symlink を操作する薄い管理ユーティリティです。

## SARF Alignment

- **Position**: Meta（SARF のどの段階でもなく、「どの Set/Feedback 空間で動くか」を切り替える運用層）
- **Set Preflight**: 不要（workspace 切替自体がすべての Set 前提を差し替える操作）
- **Feedback Hook**: 新規 workspace 作成直後は `/set-organization`（初回のみ）→ `/set-workspace` に接続するよう案内する

## サブコマンド

ユーザーが `/workspace` を無引数で呼んだ場合は **現在のアクティブ workspace と一覧を両方表示** する。

### `list`
`memory/workspaces/` 配下のディレクトリを列挙。アクティブ（= `memory/profile` の symlink 先）にマークを付ける。

```bash
ls -1 memory/workspaces/ 2>/dev/null
readlink memory/profile   # -> workspaces/<active>/profile
```

### `current`
現在のアクティブ workspace slug を返す。

```bash
readlink memory/profile | sed 's|workspaces/||; s|/profile||'
```

### `switch <slug>`
1. `memory/workspaces/<slug>/` が存在することを確認。無ければエラーにして `new` を案内。
2. 既存の `memory/profile` `memory/results` symlink を削除し、`<slug>` のものに張り替える。
3. 切替後は `/sarf-check` を案内（Set 充足率が workspace ごとに違うため）。

```bash
test -d memory/workspaces/<slug> || { echo "workspace <slug> not found"; exit 1; }
rm -f memory/profile memory/results
ln -s workspaces/<slug>/profile memory/profile
ln -s workspaces/<slug>/results memory/results
```

### `new <slug>`
1. `memory/workspaces/<slug>/profile` と `memory/workspaces/<slug>/results` を作成。
2. `memory/profile.example/` の中身を `memory/workspaces/<slug>/profile/` に **コピー**（テンプレート注入）。`memory/results.example/` も同様。
3. 直後に `switch <slug>` を実行してアクティブ化。
4. `memory/organization/` が未存在なら `memory/organization.example/` から初回ブートストラップし、「`/set-organization` で組織情報を埋めてください」と案内。
5. 「`/set-workspace` で workspace 固有情報を埋めてください」と案内。

```bash
mkdir -p memory/workspaces/<slug>
cp -r memory/profile.example memory/workspaces/<slug>/profile
cp -r memory/results.example memory/workspaces/<slug>/results
# Organization は組織全体で1つだけ。未存在時のみブートストラップ。
test -d memory/organization || cp -r memory/organization.example memory/organization
rm -f memory/profile memory/results
ln -s workspaces/<slug>/profile memory/profile
ln -s workspaces/<slug>/results memory/results
```

### `remove <slug>`（破壊的 / 要確認）
`memory/workspaces/<slug>/` を削除する。**削除前に必ずユーザー確認を取る**（auto mode でも例外的に確認必須）。アクティブ workspace を削除しようとした場合はブロックし、先に別 workspace へ switch するよう案内。

## 引数パース

- `/workspace` → 無引数 = `list` + `current` を両方表示
- `/workspace list` / `current` → そのまま
- `/workspace switch acme-saas` → switch with slug
- `/workspace new acme-saas` → new with slug
- `/workspace remove acme-saas` → remove with slug（確認ゲート必須）

slug は `[a-z0-9][a-z0-9-]*` に正規化。大文字・スペース・日本語はエラー（ファイルシステムとの相性のため）。

## 命名規則（推奨）

- 代理店のクライアント: `client-<company>`（例: `client-acme`）
- 事業部・プロダクト: `<company>-<bu>`（例: `acme-saas`, `acme-enterprise`）
- 単一事業: `<company>`（例: `acme`）。`default` は禁止（上記注記参照）

**共通情報の重複を許容する** 設計です。事業部間でブランド規約が共通でも、各 workspace にコピーを持つ方が、後で分岐したい時に構造が邪魔になりません（inheritance を導入すると SKILL.md 全体にマージの責務が波及するため、意図的に避けています）。

## ガードレール

- **アクティブ切替はユーザーの明示的な要求があったときだけ**。他スキルの裏で勝手に切り替えない。
- `remove` は必ず確認を取る（CLAUDE.md §Executing actions with care に該当）。
- symlink が壊れている（target が存在しない）場合は修復を案内する。
- `memory/profile.example/` `memory/results.example/` は upstream テンプレなので **書き換えない**（PreToolUse hook でもブロック）。

## Integrations（optional）

このスキルに外部連携は不要。純粋なローカルファイル操作。
