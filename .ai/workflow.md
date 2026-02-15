# ワークフロー

## AI協調フロー

- Codex / Claude の役割は固定しない
- 修正内容・進行状況・手順書・計画・レビュー観点は GitHub Issues に集約する
- GitHub操作手段は固定しない（`gh` / REST API / GraphQL API のいずれでもよい）
- `gh` を使う場合は `scripts/ghx ...` を基本とする
- 認証切り替えが多い環境では、`gh auth` 依存を避けてAPI実行を優先してよい
- 状態管理は GitHub Issue のラベル + Close で運用する
- 1 Issue 1 worktree を基本とし、強く関連するIssueのみ同一worktreeで扱う
- PR は小さく分割して順次マージする

## Issue状態とラベル

- `Open`: 未着手/待機中（ラベルなし）
- `In Progress`: `status:in-progress` ラベルを付与
- `Close`: 完了。PRマージ後にIssueをクローズする
- 優先度は `priority:P0` / `priority:P1` / `priority:P2` / `priority:P3` で管理する

優先度の目安:

1. `P0`: サービス停止・致命的不具合・最優先対応
2. `P1`: 重要機能の実装/修正で早期対応が必要
3. `P2`: 通常優先度
4. `P3`: 低優先度・後続対応可

## Issueスコープ管理（任意）

- `.context/issue_scope.json` を使って対象Issueを共有してよい
- `/pick` / `/p` の実行自体は任意
- ファイル変更を伴う依頼では、着手前に「Issue化するか」を必ずユーザーへ確認する
- Issue化する場合はIssue作成またはIssue番号指定を行い、対象Issue番号を確定してから進める
- Issue化しない場合は、Issue未作成で進める合意をユーザーと確認して進める
- 計画相談・壁打ちなど、ファイル変更を伴わない場合はIssueスコープ未設定でもよい
- `.context/issue_scope.json` が未設定でも、依頼文でIssue番号が明示されていれば進行してよい
- 再 `/pick` / `/p` で既存スコープがある場合は、上書き前に警告してユーザー確認を行う
- 軽微な修正をまとめる場合は、`primary_issue` + `related_issues` で複数Issueを保持してよい
- 共有ライブラリ変更で複数Issueに影響する場合は、各Issueコメントに関連Issueを相互記載する

想定フォーマット:

```json
{
  "primary_issue": 9,
  "related_issues": [12, 15],
  "branch": "feature/example",
  "picked_at": "2026-02-15T10:30:00Z"
}
```

## 基本フロー

### 0. 修正依頼の受付ゲート

1. ファイル変更を伴う依頼を受けたら、着手前にIssue化可否をユーザーへ確認する
2. Issue化がOKならIssueを作成し、Issue番号を確定する
3. Issue化しない場合は、Issue未作成で進める合意を明示してから進める

### 1. 計画

1. ユーザー指示を分解し、Issue化する対象の GitHub Issues を作成する
2. 各Issueに目的・手順・受け入れ条件・チェックリストを記載する
3. 各Issueに優先度ラベル（`priority:*`）を付与する

### 2. スコープ固定（任意）

1. 必要なら `/pick` または `/p` で対象Issueを固定する
2. 固定時は `primary_issue` と `related_issues` を明示する
3. `.context/issue_scope.json` が未設定でも、Issue番号を依頼文で明示して進めてよい
4. Issue化して進める場合に `.context` と依頼文のどちらにもIssue番号がないときは、Issue起票または番号指定を確認する

### 3. 実装

1. Issue化して進める場合は、対象Issue番号が確定していることを確認する
2. Conductorで対象Issue用のworkspace（worktree）を作成する
3. 基底ブランチはリポジトリ標準の基底ブランチを使う（`main` 固定にしない）
4. Issue化している場合は、着手時にIssueへ `status:in-progress` を付与する
5. 実装・テストを行い、必要に応じてIssueコメントで進捗共有する

### 4. レビュー

1. レビュー依頼時は対象Issue番号を明示する
2. レビュー結果は GitHub Issue コメントに記載する
3. レビュアーは対象Issue番号をコメント内に明記する
4. 指摘は `採用 / 不採用 / 追加情報必要` で判定する
5. 指摘にはファイルパス・行番号・根拠を含める
6. レビュアーは最新の修正結果コメント（`/rv` / `/review-verify` の結果）も確認する
7. `gh` でレビュー結果を Issue に記録する場合は `scripts/ghx issue comment ...` を使う

### 5. `/review-verify`

- Claude Code:
  - `/review-verify <issue-number>` または `/rv <issue-number>` を使用する
  - 引数がない場合は `.context/issue_scope.json` を参照する
  - 引数も `.context/issue_scope.json` もない場合は通常動作で進め、Issue連携は行わない
  - `.context` に `related_issues` がある場合は関連Issueも対象に検証する
  - Issue連携を行った場合のみ、修正後に対象Issueへ修正結果コメントを追記する
- Codex:
  - Slash Command は使えないため、同等内容をプロンプトで指示する
  - 例: 「Issue #9 の最新レビューコメントを検証し、採用指摘のみ修正し、結果をIssueコメントに追記」

### 6. Codex疑似コマンド運用

- Codexでは `/pick` `/p` `/review-verify` `/rv` `/commit` `/c` `/commit!` `/c!` をコマンドとして直接実行できない
- 短縮形（`/p` `/rv` `/c` `/c!`）はClaude Code向けの別名であり、Codexではそのまま送らない
- Codexへは「`/pick` 相当を実施」「`/rv` 相当を実施」のように、処理内容を文章で明示する
- 例:
  - `Issue #7 を primary_issue として .context/issue_scope.json を更新して（/pick 相当）`
  - `Issue #7 のレビューコメントを検証し、採用指摘のみ修正してIssueへ結果コメントして（/rv 相当）`
  - `git add -A 後に確認付きでコミット候補を提示して（/commit 相当）`
  - `git add -A 後に最初の候補で即コミットして（/commit! 相当）`

### 7. PRと完了

1. PR本文に `Closes #<issue-number>` を記載する
2. 複数Issueを同一PRで完了させる場合は、複数の `Closes #...` を記載してよい
3. 参照のみのIssueは `Refs #<issue-number>` を使う
4. `gh` で PR を作成/更新する場合は `scripts/ghx pr ...` を使う
5. PRが基底ブランチへマージされたらIssueが自動クローズされる
