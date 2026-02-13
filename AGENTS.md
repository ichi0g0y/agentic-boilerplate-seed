# AGENTS.md

対象: Codex

## 最重要

**Codex / Claude の共通挙動は [`.ai/behavior.md`](.ai/behavior.md) を正とする。**

- 役割は固定しない（どちらも計画・実装・テスト・レビューを実行可能）
- レビューで修正点がある場合は、必ず `.context/_review_feedback.md` を先に作成する
- `/review-verify` は `.context/_review_feedback.md` を検証し、採用した指摘のみ修正する

## 必読ドキュメント（常時）

- [`.ai/rules.md`](.ai/rules.md)
- [`.ai/project.md`](.ai/project.md)
- [`.ai/workflow.md`](.ai/workflow.md)
- [`.ai/behavior.md`](.ai/behavior.md)

## `/review-verify` 時の追加必読

- [`.ai/review.md`](.ai/review.md)
- [`.ai/dev-env.md`](.ai/dev-env.md)
- [`.ai/git.md`](.ai/git.md)

## Codex固有の原則

- 詳細は [`.ai/dev-env.md`](.ai/dev-env.md) を正本として参照する
