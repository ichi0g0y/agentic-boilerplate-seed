# CLAUDE.md

対象: Claude Code

## 最重要

**Codex / Claude の共通運用は [`.ai/workflow.md`](.ai/workflow.md) を正とする。**

- 役割は固定しない
- 修正内容・進行状況・手順書・計画・レビュー観点は GitHub Issues に集約し、Issue単位worktree + 小PRで進める
- レビュー結果は自動投稿せず、必要に応じて手動コピーまたは `.context/` 経由で共有する
- `develop -> main` 反映は `/deploy-to-production` または `/dtp` を使う
- `develop -> staging` 反映は `/deploy-to-staging` または `/dts` を使う

## 必読ドキュメント

- [`.ai/project.md`](.ai/project.md)
- [`.ai/rules.md`](.ai/rules.md)
- [`.ai/workflow.md`](.ai/workflow.md)
- [`.ai/review.md`](.ai/review.md)
- [`.ai/git.md`](.ai/git.md)
- [`.ai/dev-env.md`](.ai/dev-env.md)

## `current_issue` 管理

- 対象Issue確定時は `.context/current_issue` にIssue番号を1行で書き出す
- セッション開始時に `.context/current_issue` があれば対象Issueとして復元する
- 対象PRがマージされ、Issue完了が確認できたら `.context/current_issue` を削除する
