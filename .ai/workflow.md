# ワークフロー

## AI協調フロー

- Codex / Claude の役割は固定しない
- `.context/tasks` は使用しない
- レビュー連携は `.context/_review_feedback.md` のみを使う
- 計画・手順書・調査メモは `issues/` に集約し、`docs/` は確定情報を保持する
- Issue単位でworktreeを作成し、小さなPRを順次適用して進める

## 基本フロー

### 1. 実装

1. ユーザー指示に沿って実装する
2. 必要なテストや検証を実行する
3. 実装内容と検証結果を報告する

### 2. レビュー

1. 変更差分をレビューする（観点は `.ai/review.md` を参照）
2. 修正点がある場合は、先に `.context/_review_feedback.md` を作成する（テンプレートは `.ai/review.md` を参照）
3. その後レビュー結果を報告する
4. 修正点がない場合は `.context/_review_feedback.md` を作成しない
5. 報告時に `.context/_review_feedback.md` の出力有無を明記する

### 3. `/review-verify`

1. `.context/_review_feedback.md` の有無を確認する
2. 指摘を採用/不採用/追加情報必要に分類する
3. 採用した指摘のみ修正する
4. 必要なテストや検証を実行する
5. すべての修正・テストが完了したら `.context/_review_feedback.md` を削除する
6. 結果を報告する

## Issue管理

- 将来実装項目は `issues/index.md` と `issues/open/` 配下のIssueで管理する
- コードコメントの TODO は TODO ID とセットで管理し、対応するIssueに記載する
- 状態遷移は `issues/open/` → `issues/in-progress/` → `issues/done/` の順で行う

## Worktree + PR運用

1. まず `issues/open/` にIssueを作成し、目的・手順・受け入れ条件を定義する
2. `main` からIssue専用worktreeを作成して実装する
3. レビュー時は必要に応じて別worktreeを作成し、差分確認と指摘整理を行う
4. 1Issue 1PRを基本とし、PRは小さく分割して順次マージする
5. マージ後は `issues/index.md` とIssueの状態を更新する
