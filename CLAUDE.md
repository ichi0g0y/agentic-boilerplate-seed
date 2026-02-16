# CLAUDE.md

対象: Claude Code

## 最重要

**Codex / Claude の共通挙動は [`.ai/behavior.md`](.ai/behavior.md) を正とする。**

- 役割は固定しない
- 必要に応じて `/pick` または `/p` で対象Issueスコープを `.context` に固定してよい（任意）
- レビュー結果は対象GitHub Issueコメントに記録する
- `/review-verify <issue-number>` または `/rv <issue-number>` で採用指摘のみ修正する
- 修正内容・進行状況・手順書・計画・レビュー観点は GitHub Issues に集約し、Issue単位worktree + 小PRで進める

## 必読ドキュメント

- [`.ai/project.md`](.ai/project.md)
- [`.ai/rules.md`](.ai/rules.md)
- [`.ai/workflow.md`](.ai/workflow.md)
- [`.ai/behavior.md`](.ai/behavior.md)
- [`.ai/review.md`](.ai/review.md)
- [`.ai/git.md`](.ai/git.md)
- [`.ai/dev-env.md`](.ai/dev-env.md)
