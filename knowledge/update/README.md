# Update Knowledge — 外部揮発情報

このディレクトリには、**外から入ってくる** 揮発性の情報を格納します。
プラットフォームの仕様変更、業界トレンドなど、公開情報ベースで全ユーザー共通の観測。

## 含まれるファイル

- **platform-updates.md** — プラットフォーム仕様変更時に随時更新
- **industry-trends.md** — 月次で更新推奨

> 自社の実績数値（CVR・CPA・ROAS・売上）は `memory/results/` 側（gitignore対象）に格納します。
> ここ（`update/`）は機密性が低い外部観測専用です。

## 使い方

各スキル（特に実行系: SEO, Ads, Content）がこのディレクトリを参照します。
情報が古いと施策の精度が下がるので、`/set-update` で定期的に更新してください。

`/set-update` は AI が公式ソース（Google Ads Blog / Meta for Business / X Business 等の allowlist）を pull 型で巡回し、差分を diff 提示 → ユーザー承認 → 書き込みの順で反映します。手動の intake は行いません（非公開観測は `/feedback` へ）。

`/flow-weekly-retro` ワークフローの中で、外部情報の更新もリマインドされます。
