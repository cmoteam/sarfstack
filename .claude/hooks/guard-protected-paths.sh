#!/usr/bin/env bash
# PreToolUse guard for SARFStack protected paths.
#
# Policy (see CLAUDE.md):
#   - memory/profile.example/**   : upstream template. HARD BLOCK writes.
#   - memory/results.example/**   : upstream template. HARD BLOCK writes.
#   - knowledge/base/**           : canonical framework. PR 経由で編集する前提で
#                                   hook レベルの hard block は外してある
#                                   （settings.json の allow/deny で制御）。
#   - 一次成果物が output/ 以外のルート直下に書かれそうな場合 : WARN（非ブロック）。
#
# Exit codes:
#   0  : allow
#   2  : block (stderr is shown to the model as the reason)
#
# Stdin is a JSON payload from Claude Code with at least:
#   { "tool_name": "Write"|"Edit"|"MultiEdit"|...,
#     "tool_input": { "file_path": "...", ... } }

set -euo pipefail

payload="$(cat)"

tool_name="$(printf '%s' "$payload" | /usr/bin/python3 -c 'import json,sys;print(json.load(sys.stdin).get("tool_name",""))' 2>/dev/null || echo "")"
file_path="$(printf '%s' "$payload" | /usr/bin/python3 -c 'import json,sys;d=json.load(sys.stdin);print(d.get("tool_input",{}).get("file_path",""))' 2>/dev/null || echo "")"

# No file path? Not our concern.
if [[ -z "$file_path" ]]; then
  exit 0
fi

# Only guard mutating tools.
case "$tool_name" in
  Write|Edit|MultiEdit|NotebookEdit) ;;
  *) exit 0 ;;
esac

# Normalize to repo-relative (best effort).
repo_root="$(git rev-parse --show-toplevel 2>/dev/null || echo "")"
rel_path="$file_path"
if [[ -n "$repo_root" && "$file_path" == "$repo_root"/* ]]; then
  rel_path="${file_path#$repo_root/}"
fi

block() {
  local reason="$1"
  echo "[SARFStack guard] BLOCKED: $reason" >&2
  echo "  path: $rel_path" >&2
  echo "  hook: .claude/hooks/guard-protected-paths.sh" >&2
  exit 2
}

# --- Hard blocks ---------------------------------------------------------

case "$rel_path" in
  memory/profile.example/*|memory/profile.example)
    block "memory/profile.example/ は upstream 共通テンプレート。workspace 固有の情報は memory/workspaces/<slug>/profile/ に書くこと（CLAUDE.md §Profile 参照）。"
    ;;
  memory/results.example/*|memory/results.example)
    block "memory/results.example/ は upstream 共通テンプレート。実績は memory/results/ に書くこと（CLAUDE.md §Results 参照）。"
    ;;
  memory/organization.example/*|memory/organization.example)
    block "memory/organization.example/ は upstream 共通テンプレート。組織情報は memory/organization/ に書くこと（CLAUDE.md §Organization 参照）。"
    ;;
esac

# --- Soft warnings (non-blocking) ----------------------------------------

# Warn when a likely one-off deliverable lands outside output/.
# Only matches top-level files (no slash in rel_path) with common artifact extensions.
if [[ "$rel_path" != */* ]]; then
  case "$rel_path" in
    *.md|*.html|*.css|*.pdf|*.csv|*.json)
      # Allow known root files to pass silently.
      case "$rel_path" in
        README.md|CLAUDE.md|AGENTS.md|.mcp.json|.mcp.json.example) ;;
        *)
          echo "[SARFStack guard] WARN: 一次成果物はルート直下ではなく output/ 配下に置いてください（CLAUDE.md §Output Directory）。path: $rel_path" >&2
          ;;
      esac
      ;;
  esac
fi

exit 0
