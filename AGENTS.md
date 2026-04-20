# SARFStack

このファイルは互換性のためのスタブです。**canonical なプロジェクト定義・エージェント仕様は [`CLAUDE.md`](CLAUDE.md)** に統合されています。

Codex など AGENTS.md を参照するハーネスはこのファイル経由で CLAUDE.md を読み込んでください。Claude Code は CLAUDE.md を自動で読み込みます。

## ⚠️ Skills に関する注意（重要）

**SARFStack の各スキル（`/set-profile` `/cmo-review` `/ads-manager` 等）はレポジトリ単位では動作しません。**

Claude Code / Codex は現時点で **project-local な `skills/` ディレクトリを自動読み込みしません**。スキルとして呼び出すには、ユーザー側（`~/.claude/skills/` など）あるいは plugin として事前にインストールされている必要があります。

- リポジトリに含まれる `skills/*/SKILL.md` は **仕様書** として参照する位置づけ
- 実際にスラッシュコマンド（`/set-organization` 等）として呼ぶには、ユーザースコープへのインストール or plugin 経由が必要
- この制約は将来のハーネスのアップデートで変わる可能性あり

スキル定義の意味・責務・入出力は下記 CLAUDE.md を参照してください。

@CLAUDE.md
