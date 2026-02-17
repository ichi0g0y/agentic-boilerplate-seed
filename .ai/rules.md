# 共通ルール

## 原則

- チャットは日本語で行う
- ソースコメント・ドキュメントは標準的な日本語で記述する
- `/commit` / `/c` または `/commit!` / `/c!` が明示されない限り、コミットしない
- 自動生成コードは直接編集せず、入力元（スキーマ/定義）を修正して再生成する
- 言語選定前に特定技術へ依存した前提を置かない

## 実装ルール

- 変更は最小差分で行う
- 不明点が仕様に直結する場合は推測で埋めずに確認する
- 将来対応が必要な暫定実装は GitHub Issue に必ず記録する
- 手順書・実装計画・調査メモは原則 GitHub Issues に記録し、`docs/` には確定事項のみを残す
- レビュー結果は GitHub Issue コメントに記録する
- 進行状態は `status:in-progress` ラベルとIssueクローズで管理する
- GitHub操作の手段は固定せず、必要に応じてAPI実行などを選択してよい
- 既存の未コミット変更があっても、Issue化（Issue作成/番号確定）を止めない
- `.context/issue_scope.json` を使う場合、未設定時は通常動作で進める
- `.context/issue_scope.json` を再設定する場合は上書き前にユーザー確認を行う
- `.context/issue_scope.json` の基本形式は `schema_version: 2` とし、`primary_issue` / `related_issues` / `active_related_issues` / `branch` / `picked_at` / `updated_at` を保存する
- 複数Issueに関係する作業は `primary_issue` と `related_issues` を使って `issue_scope` に記録し、実作業対象は `active_related_issues` で状態管理する
- PR作成/更新後は `issue_scope` を使う運用であれば `pr_number`（必要に応じて `pr_url`）を記録する
- `issue_scope.json` 更新は原子更新を必須とし、`mkdir .context/.issue_scope.lock` 等で排他後に一時ファイルへ書き込み、`mv` で置換する
- `issue_scope.json` 更新処理は成功/失敗にかかわらずロック解放を必ず行う
- 実装とレビューはIssue単位でworktreeを分けて進める

## 品質ルール

- 1ファイル300行超を目安に分割を検討する
- 1関数100行超を目安に責務分割を検討する
