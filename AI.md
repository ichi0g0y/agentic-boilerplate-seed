# AI

このドキュメントは、**Conductor上でこのリポジトリを扱うときの追加プロンプト設定**だけをまとめたものです。

実装方針・レビュー運用・厳守ルールはこのファイルでは定義しません。
必ず `.ai/` 配下のルールドキュメントを参照してください（正はそちらです）。

- `.ai/behavior.md`
- `.ai/rules.md`
- `.ai/workflow.md`
- `.ai/review.md`

## コーディングからレビューまでの流れ（Conductor）

Conductorでの基本的な進め方は、次の順番です。

1. GitHub Issue に計画・手順・受け入れ条件・進行状況を記載
2. Issue単位でworktreeを作成し、必要なら `/pick` または `/p` で対象Issueを `.context` に固定
3. レビュー依頼（対象Issue番号を明記し、レビュー結果はIssueコメントに記載）
4. `/review-verify <issue-number>` または `/rv <issue-number>` で指摘対応し、修正結果をIssueコメントに記載（引数なし時は `.context` を参照）
5. 小さなPRを順次適用
6. 必要なら `/commit` / `/c` または `/commit!` / `/c!`

### コマンド説明

- コーディング依頼: 明示コマンドは不要です。通常の依頼文で実装を指示します。
- `/plan` または `/pl`: `AI.md` と `.ai/*`（+ `.context/issue_scope.json` があればそれも）を読み込み、計画準備状態に入ります。実装・Issue作成・マージは行いません。
- `/pick <primary-issue> [related-issues...]` または `/p <primary-issue> [related-issues...]`: 対象Issueを `.context/issue_scope.json` に固定します（任意）。
- レビュー依頼: 明示コマンドは不要です。差分レビューを依頼します。
- `/review-verify <issue-number>` または `/rv <issue-number>`: 対象Issueのレビューコメントを読み込み、採用された指摘のみ修正します。Issue連携した場合は修正結果コメントをIssueへ追記します。引数なし時は `.context/issue_scope.json` を参照します。
- `/commit` または `/c`: 確認付きコミットです。候補メッセージ確認後にコミットします。
- `/commit!` または `/c!`: 確認なしで即時コミットします。

注記:

- 上記のスラッシュコマンドは Claude Code 前提です。
- Codex では疑似コマンド運用になるため、`/p` などの文字列だけではなく処理内容を依頼文で明示してください。
- Codexへの指示例:
  - `AI.md と .ai の必読を読み込み、計画準備状態へ入って（/plan 相当）`
  - `Issue #7 を primary_issue として .context/issue_scope.json を更新して（/pick 相当）`
  - `Issue #7 のレビューコメントを検証し、採用指摘のみ修正してIssueへ結果コメントして（/rv 相当）`
  - `git add -A 後に確認付きコミット候補を出して（/commit 相当）`

### レビュー連携の要点

- レビューで修正点がある場合は、レビュー担当が対象Issueへレビューコメントを追加します。
- レビュー結果の報告は日本語で記述します。
- CodexはSlash Commandを使えないため、同等処理はプロンプトで明示指示します。

### Issue番号の受け渡し

- `Issue #9` のように依頼文で明示する方法を基本とします。
- 必要なら `/pick` または `/p` で `.context/issue_scope.json` に固定して共有します。
- `.context` 未設定時は通常動作で進め、Issue固定フローは使いません。
- `.context` と引数の両方がある場合は、引数を優先して扱います。

## Conductor利用時の追加プロンプト

Conductorで依頼する際は、依頼文に次の追加条件を含めてください。
特に、回答・報告・PR本文は日本語で記述することを毎回明記してください。

### review依頼時

```text
- レビュー運用の正は `.ai/review.md` と `.ai/workflow.md` を参照し、重複する指示がある場合はそちらを優先してください。
- 対象Issue番号（例: `#9`）を明記してください。省略する場合は `.context/issue_scope.json` を先に設定してください。
- **レビュー開始前に**、対象Issueの既存コメント（特に `/rv` / `/review-verify` 実行結果）を `gh issue view <number> --comments` で必ず確認してください。
- レビュー結果の報告は必ず日本語で記述してください。
- レビュー結果は対象Issueコメントに記載してください。
- GitHub CLI でレビュー結果をIssueへ記録する場合は `gh issue comment ...` を使ってください。
- `/review-verify` 相当の実行時は、指摘ごとに `採用 / 不採用 / 追加情報必要` を明記してください。
- 修正を行った場合は、実施したテスト内容と結果を最終報告に必ず記載してください。
- 最終報告には、追記したIssueコメントのURL（`issue_comment_url`）を必ず記載してください。
- 対象Issue番号を確定できない、またはIssueコメントの追記に失敗した場合は、実装を進めずに停止して確認してください。
```

### PR作成依頼時

```text
- PR作成・コミット運用で重複するルールは `.ai/git.md` と `.ai/workflow.md` を参照し、そちらを優先してください。
- PR作成に関する報告・提案・本文はすべて日本語で記述してください。
- PRのbaseブランチは `develop` にしてください（GitHubのデフォルトブランチ設定は変更しません）。
- PR本文は日本語で、以下の見出しを含めてください:
  - 概要
  - 変更内容
  - テスト手順
  - 影響範囲
  - チェックリスト
- 完了Issueは必ず `Closes #<issue-number>` を記載してください。
- 参照のみのIssueは `Refs #<issue-number>` を記載してください。
- GitHub CLI でPRを作成/更新する場合は `gh pr ...` を使ってください。
- PR作成/更新後は `.context/issue_scope.json` の `pr_number`（必要に応じて `pr_url`）を更新し、後続作業で参照できるようにしてください。
- 実行した確認コマンド（例: task check:all, task gen:api, task gen:db）と結果を本文に明記してください。
- 未実施の検証がある場合は「未実施項目」と理由を明記してください。
- 最終報告には、作成/更新したPRのURL（`pr_url`）を必ず記載してください。
- 関連Issueへ進捗コメントを追記した場合は、そのIssueコメントURL（`issue_comment_url`）も記載してください。
- PR作成または更新に失敗した場合は、失敗したコマンドとエラーメッセージを添えて停止し、次アクション確認を行ってください。
```
