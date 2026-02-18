# CLAUDE.md

対象: Claude Code

## 最重要

**Codex / Claude の共通挙動は [`.ai/behavior.md`](.ai/behavior.md) を正とする。**

- 役割は固定しない
- 必要に応じて `/pick` または `/p` で対象Issueスコープを `.context` に固定してよい（任意）
- レビュー結果は対象GitHub Issueコメントに記録する
- `/review-verify <issue-number>` または `/rv <issue-number>` で採用指摘のみ修正する
- 修正内容・進行状況・手順書・計画・レビュー観点は GitHub Issues に集約し、Issue単位worktree + 小PRで進める

## タスク運用方針（共通）

- 新規タスク起票時は、同一目的・同一完了条件の作業を原則1つのIssueに集約し、進捗はIssue本文のチェックリストで管理する
- Issue分割は優先度・担当・期限・リリース単位が異なる場合に限定し、分割時は親子Issueを `Refs #...` で相互参照する
- `/pick` / `/p` 等の明示指示がない依頼は、まず plan モードとして扱い、Issue設計とスコープ確認を先に行う
- 実装着手時に `primary_issue` と必要な `related_issues` を確定し、Issue単位worktree + 小PRで順次進める
- 運用ルールの正本は `.ai/workflow.md`（必要に応じて `.ai/behavior.md`）とし、`CLAUDE.md` は整合を保つ

## 必読ドキュメント

- [`.ai/project.md`](.ai/project.md)
- [`.ai/rules.md`](.ai/rules.md)
- [`.ai/workflow.md`](.ai/workflow.md)
- [`.ai/behavior.md`](.ai/behavior.md)
- [`.ai/review.md`](.ai/review.md)
- [`.ai/git.md`](.ai/git.md)
- [`.ai/dev-env.md`](.ai/dev-env.md)
