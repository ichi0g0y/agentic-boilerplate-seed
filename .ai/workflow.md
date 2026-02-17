# ワークフロー

## AI協調フロー

- Codex / Claude の役割は固定しない
- 修正内容・進行状況・手順書・計画・レビュー観点は GitHub Issues に集約する
- GitHub操作手段は固定しない（REST API / GraphQL API など、環境に合う手段を選ぶ）
- 認証切り替えが多い環境では、CLI認証依存を避けてAPI実行を優先してよい
- 状態管理は GitHub Issue のラベル + Close で運用する
- 1 Issue 1 worktree を基本とし、強く関連するIssueのみ同一worktreeで扱う
- PR は小さく分割して順次マージする
- 既存の未コミット変更があっても、Issue作成とIssue番号の確定は通常どおり進める

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
- `.context/issue_scope.json` は `schema_version: 2` を基本形式とし、`primary_issue` / `related_issues` / `active_related_issues` を使って状態管理する
- 用語:
  - `primary_issue`: このworktree/チャットの主担当Issue
  - `related_issues`: 関連Issueの候補集合
  - `active_related_issues`: 今回の実作業対象（状態付き）
- `active_related_issues` の状態は `reserved` / `in_progress` / `ready_for_close` / `closed` を使用し、推奨遷移は `reserved -> in_progress -> ready_for_close -> closed` とする
- `/pick` 引数ありは `primary_issue` 固定 + `related_issues` 記録、引数なしは Open Issue を優先度順（`P0 -> P1 -> P2 -> P3 -> 優先度なし`）で `primary_issue` に選定する
- related issue を扱う場合は、未アクティブまたは期限切れのIssueから1件を `reserved` で確保し、`owner` / `reserved_at`（必要に応じて `expires_at`）を記録してよい
- 再 `/pick` / `/p` で既存スコープがある場合は、上書き前に警告してユーザー確認を行う
- PR作成/更新後は、必要に応じて `.context/issue_scope.json` に `pr_number`（必要なら `pr_url`）を記録し、後続作業で参照できる状態にする
- `issue_scope.json` 更新時は排他制御を必須とし、`mkdir .context/.issue_scope.lock` 等でロック取得後に一時ファイルへ書き込み、`mv` で置換する
- ロックは更新成功/失敗にかかわらず必ず解放する
- 共有ライブラリ変更で複数Issueに影響する場合は、各Issueコメントに関連Issueを相互記載する

想定フォーマット:

```json
{
  "schema_version": 2,
  "primary_issue": 9,
  "related_issues": [12, 15, 18],
  "active_related_issues": {
    "12": {
      "state": "in_progress",
      "owner": "conductor:ws-event:chat-a",
      "reserved_at": "2026-02-15T10:30:00Z",
      "expires_at": "2026-02-15T12:30:00Z",
      "updated_at": "2026-02-15T10:45:00Z"
    },
    "15": {
      "state": "ready_for_close",
      "owner": "conductor:ws-event:chat-a",
      "reserved_at": "2026-02-15T10:50:00Z",
      "updated_at": "2026-02-15T11:40:00Z"
    }
  },
  "branch": "feature/example",
  "pr_number": 34,
  "pr_url": "https://github.com/example/repo/pull/34",
  "picked_at": "2026-02-15T10:30:00Z",
  "updated_at": "2026-02-15T11:40:00Z"
}
```

## 基本フロー

### 0. 修正依頼の受付ゲート

1. ファイル変更を伴う依頼を受けたら、着手前にIssue化可否をユーザーへ確認する
2. Issue化がOKならIssueを作成し、Issue番号を確定する（既存の未コミット変更があっても止めない）
3. Issue化しない場合は、Issue未作成で進める合意を明示してから進める

### 1. 計画

1. ユーザー指示を分解し、Issue化する対象の GitHub Issues を作成する
2. 各Issueに目的・手順・受け入れ条件・チェックリストを記載する
3. 各Issueに優先度ラベル（`priority:*`）を付与する

### 2. スコープ固定（任意）

1. 必要なら `/pick` または `/p` で対象Issueを固定する
2. 固定時は `schema_version: 2` の `issue_scope` 形式を使い、`primary_issue` / `related_issues` / `active_related_issues` を記録する
3. related issue を実作業対象として扱う場合は `active_related_issues` に `reserved` で確保し、`owner` / `reserved_at`（必要なら `expires_at`）を記録する
4. `.context/issue_scope.json` が未設定でも、Issue番号を依頼文で明示して進めてよい
5. Issue化して進める場合に `.context` と依頼文のどちらにもIssue番号がないときは、Issue起票または番号指定を確認する

### 3. 実装

1. Issue化して進める場合は、対象Issue番号が確定していることを確認する
2. Conductorで対象Issue用のworkspace（worktree）を作成する
3. 基底ブランチは `develop` を使う（GitHubのデフォルトブランチ設定は変更しない）
4. Issue化している場合は、着手時にIssueへ `status:in-progress` を付与する
5. 実装・テストを行い、必要に応じてIssueコメントで進捗共有する

### 4. レビュー

1. レビュー依頼時は対象Issue番号を明示する
2. レビュー結果は GitHub Issue コメントに記載する
3. レビュアーは対象Issue番号をコメント内に明記する
4. 指摘は `採用 / 不採用 / 追加情報必要` で判定する
5. 指摘にはファイルパス・行番号・根拠を含める
6. レビュアーは最新の修正結果コメント（`/rv` / `/review-verify` の結果）も確認する

### 5. `/review-verify`

- Claude Code:
  - `/review-verify <issue-number>` または `/rv <issue-number>` を使用する
  - 引数がない場合は `.context/issue_scope.json` の `primary_issue` と `active_related_issues`（`in_progress` / `ready_for_close`）を対象にする
  - 引数も `.context/issue_scope.json` もない場合は通常動作で進め、Issue連携は行わない
  - 指摘を反映したIssueのみ `active_related_issues` の状態を更新する
  - Issue連携を行った場合のみ、修正後に対象Issueへ修正結果コメントを追記する
- Codex:
  - Slash Command は使えないため、同等内容をプロンプトで指示する
  - 例: 「Issue #9 の最新レビューコメントを検証し、採用指摘のみ修正し、反映したIssueの `active_related_issues` 状態を更新して結果をIssueコメントに追記」

### 6. Codex疑似コマンド運用

- Codexでは `/pick` `/p` `/review-verify` `/rv` `/merge-to-main` `/mtm` `/commit` `/c` `/commit!` `/c!` をコマンドとして直接実行できない
- Codexでは `/plan` `/pl` もコマンドとして直接実行できない
- 短縮形（`/pl` `/p` `/rv` `/mtm` `/c` `/c!`）はClaude Code向けの別名であり、Codexではそのまま送らない
- Codexへは「`/pick` 相当を実施」「`/rv` 相当を実施」「`/mtm` 相当を実施」のように、処理内容を文章で明示する
- 例:
  - `AI.md と .ai の必読を読み込み、計画準備状態へ入って（/plan 相当）`
  - `Issue #7 を primary_issue として .context/issue_scope.json を更新して（/pick 相当）`
  - `Issue #7 のレビューコメントを検証し、採用指摘のみ修正してIssueへ結果コメントして（/rv 相当）`
  - `develop から main へのリリースPRを作成して通常はそのままマージし、必要なら --no-merge で作成のみ実行して、.context の pr_number/pr_url を更新して（/mtm 相当）`
  - `git add -A 後に確認付きでコミット候補を提示して（/commit 相当）`
  - `git add -A 後に最初の候補で即コミットして（/commit! 相当）`

### 7. PRと完了

1. `Closes` / `Refs` の判定対象は `primary_issue + active_related_issues + related_issues` とする
2. `Closes` は `primary_issue` と、`active_related_issues` が `ready_for_close` / `closed` のIssueを記載する
3. `Refs` は `active_related_issues` が `reserved` / `in_progress` のIssue、および候補のみ（`related_issues` のみ）のIssueを記載する
4. 複数Issueを同一PRで扱う場合、上記判定に沿って `Closes #...` / `Refs #...` を複数併記してよい
5. PRが基底ブランチへマージされたらIssueが自動クローズされる
6. `develop -> main` 反映時は `/merge-to-main` / `/mtm` 相当の手順を必須とする
