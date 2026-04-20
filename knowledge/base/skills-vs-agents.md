# Skills vs Agents — 使い分けの判断基準

SARFStack は **Skill**（`.claude/skills/`）と **Agent**（`.claude/agents/`）の2種類を使い分けます。

| | Skill | Agent |
|---|---|---|
| 場所 | `.claude/skills/<name>/SKILL.md` | `.claude/agents/<name>.md` |
| 呼び出し | ユーザーの `/skill-name` or モデルが Skill ツール経由 | モデルが Task ツール経由で並列ディスパッチ |
| コンテキスト | メインセッションで実行（成果物・履歴が残る） | 独立したサブエージェントで実行（結果のみ返却） |
| 副作用 | あり（ファイル書き込み・MCP 呼び出し） | なし（Read のみ、結果を文字列で返す） |
| 典型的な用途 | 直接のユーザー対話・制作・Set/Feedback 操作 | レビュー・評価・並列診断 |

## Agent 化の判断基準

以下のいずれかに当てはまる → **Agent 化**:
- workflow から並列で呼ばれる（例: `/campaign-launch` で CEO/CMO/SEO を同時ディスパッチ）
- レビュー系（副作用なし・結果返却のみ）
- メインコンテキストを汚したくない診断タスク

以下のいずれかに当てはまる → **Skill のまま**:
- 直接のユーザー対話が主（対話を積み重ねて成果物に到達する）
- 書き込み副作用あり（`private/output/` や `private/memory/` への生成）
- MCP 呼び出しや長期状態の操作（`/workspace switch` など）

## Scope（company-wide か workspace か）

Agent の frontmatter には `scope` フィールドを持たせる:

- **`scope: company-wide`** — `private/memory/workspaces/*/` を全走査。全 workspace 横断レビュー（CEO / Group CMO）
- **`scope: workspace`** — アクティブ workspace（`private/memory/workspaces/active/profile/`）のみ。事業部マネージャー / 専門職

**経営層は全事業部横断、それ以外は単一 workspace が基本スコープ**。

## 現状マッピング

| カテゴリ | Agent 化済み（canonical） | Scope | Skill のみ |
|---|---|---|---|
| Review 系 | `ceo-review` | company-wide | — |
| Review 系 | `cmo-review` | company-wide | — |
| Review 系 | `consultant-review` | workspace | — |
| Review 系 | `creative-direction` | workspace | — |
| Review 系 | `seo` | workspace | — |
| Specialist (Ask) | — | workspace | `customer-research` |
| Specialist (Release) | — | workspace | `contents-edit` `ads-manager` `estimate` `ui-design` `pricing-strategy` `churn-prevention` `data-analytics` |
| Optimization | — | workspace | `optimize`（6 target 統合） |
| SARF Ops | — | organization | `set-organization` `set-brand` |
| SARF Ops | — | workspace | `set-workspace` `set-update` `feedback` |
| Meta | — | cross-workspace | `workspace` `next` `sarf-check` |
| Workflows | — | — | `campaign-launch` 他（`.claude/workflows/` 配下、未実装） |

Agent 化された 5 つは、同名の Skill が `.claude/skills/<name>/SKILL.md` に **thin dispatcher** として存在し、slash コマンドのエントリポイント兼 Task tool へのディスパッチャを担う。

## 実装原則

**Agent 化された機能は agent 側を canonical とし、Skill は thin dispatcher（slash エントリ用）**。Skill の責務は Task tool 経由で同名 agent を起動することのみで、ロジックは持たない。

これにより:
- slash コマンド (`/ceo-review` 等) が Unknown にならない
- レビュー系は独立コンテキストで走り、メインセッションを全走査で汚さない
- 仕様は agent 側に一本化され、重複・drift を防ぐ
