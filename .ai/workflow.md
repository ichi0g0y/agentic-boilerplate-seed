# ワークフロー

## AI協調フロー

- Codex / Claude の役割は固定しない
- 修正内容・進行状況・手順書・計画・レビュー観点は GitHub Issues に集約する
- GitHub操作手段は固定しない（REST API / GraphQL API など、環境に合う手段を選ぶ）
- 状態管理は GitHub Issue のラベル + Close で運用する
- 1 Issue 1 worktree を基本とし、強く関連する作業のみ同一worktreeで扱う
- PR は小さく分割して順次マージする
- 既存の未コミット変更があっても、Issue作成とIssue番号の確定は通常どおり進める
- `/pick` / `/p` 等の明示指示がない依頼は、まず Issue設計とスコープ確認を行う

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

## Issue設計原則

- 新規タスク起票時は、同一目的・同一完了条件の作業を原則1つのIssueに集約する
- 進捗はIssue本文のチェックリストで管理する
- Issue分割は優先度・担当・期限・リリース単位が異なる場合に限定する
- 分割した親子Issueは `Refs #...` で相互参照する

## Issueスコープ管理（任意）

- `.context/current_issue` を使って対象Issueを共有してよい
- `.context/current_issue` は Issue番号のみを1行で保存する
- `/pick` / `/p` の実行自体は任意
- ファイル変更を伴う依頼では、着手前に「Issue化するか」をユーザーへ確認する
- Issue化する場合はIssue作成またはIssue番号指定を行い、対象Issue番号を確定してから進める
- Issue化しない場合は、Issue未作成で進める合意をユーザーと確認して進める
- `.context/current_issue` が未設定でも、依頼文でIssue番号が明示されていれば進行してよい
- `/pick` 引数ありは指定Issue番号を `.context/current_issue` に設定する
- `/pick` 引数なしは Open Issue を優先度順（`P0 -> P1 -> P2 -> P3 -> 優先度なし`）で候補化し、最上位1件なら自動設定、複数なら選択して設定する
- 既に `.context/current_issue` がある状態で再設定する場合は、上書き前にユーザー確認を行う
- PR作成/更新後は必要に応じて `.context/current_issue` を参照して整合を確認する

## 基本フロー

### 0. 修正依頼の受付ゲート

1. `/pick` / `/p` 等の明示指示がない依頼は、まず Issue設計とスコープ確認を行う
2. ファイル変更を伴う依頼を受けたら、着手前にIssue化可否をユーザーへ確認する
3. Issue化がOKならIssueを作成し、Issue番号を確定する
4. Issue化しない場合は、Issue未作成で進める合意を明示してから進める

### 1. 計画

1. ユーザー指示を分解し、同一目的・同一完了条件の作業を原則1つのIssueに集約する
2. 分割が必要な場合は、優先度・担当・期限・リリース単位の差異を根拠に分割する
3. 各Issueに目的・手順・受け入れ条件・チェックリストを記載する
4. 各Issueに優先度ラベル（`priority:*`）を付与する

### 2. スコープ固定

1. 実装着手時に対象Issue番号を確定する
2. 必要なら `/pick` または `/p` で `.context/current_issue` を更新する
3. `.context/current_issue` が未設定でも、Issue番号を依頼文で明示して進めてよい
4. Issue化して進める場合に `.context/current_issue` と依頼文のどちらにもIssue番号がないときは、Issue起票または番号指定を確認する

### 3. 実装

1. Issue化して進める場合は、対象Issue番号が確定していることを確認する
2. Conductorで対象Issue用のworkspace（worktree）を作成する
3. 基底ブランチは `develop` を使う（GitHubのデフォルトブランチ設定は変更しない）
4. Issue化している場合は、着手時にIssueへ `status:in-progress` を付与する
5. 実装・テストを行い、必要に応じてIssueコメントで進捗共有する

### 4. レビュー

1. レビュー依頼時は対象Issue番号を明示する
2. レビュー指摘は、必要に応じて手動コピーまたは `.context/` 経由で共有する
3. 指摘にはファイルパス・行番号・根拠を含める
4. 指摘は `採用 / 不採用 / 追加情報必要` で判定する
5. レビュー結果のIssueコメント自動投稿は行わない

### 5. Codex疑似コマンド運用

- Codexでは `/pick` `/p` `/deploy-to-production` `/dtp` `/deploy-to-staging` `/dts` `/commit` `/c` `/commit!` `/c!` をコマンドとして直接実行できない
- 短縮形（`/p` `/dtp` `/dts` `/c` `/c!`）はClaude Code向けの別名であり、Codexではそのまま送らない
- Codexへは「`/pick` 相当を実施」「`/dtp` 相当を実施」のように、処理内容を文章で明示する
- 例:
  - `Issue #7 を .context/current_issue に設定して（/pick 相当）`
  - `develop から main へのリリースPRを作成して通常はそのままマージして（/dtp 相当）`
  - `develop から staging へのリリースPRを作成して通常はそのままマージして（/dts 相当）`
  - `git add -A 後に確認付きでコミット候補を提示して（/commit 相当）`

### 6. PRと完了

1. PR本文には対象Issueを記載する
2. `Closes` は `.context/current_issue`（または依頼文で確定したIssue番号）を記載する
3. `Refs` は関連Issueのみを記載する
4. PRが基底ブランチへマージされたらIssueが自動クローズされる
5. `develop -> main` 反映時は `/deploy-to-production` / `/dtp` 相当の手順を必須とする
6. `develop -> staging` 反映時は `/deploy-to-staging` / `/dts` 相当の手順を使用する
