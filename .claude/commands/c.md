---
title: "Gitコミットタスク"
read_only: true
type: "command"
---

# Gitコミット（/c）

## 短縮コマンド宣言

- `/c` は `/commit` の短縮コマンド。
- 挙動・判断基準は `.claude/commands/commit.md` に準拠する。

## 重要な前提事項

- はじめに `git add -A` で変更をステージングする
- ステージング済みの差分のみを根拠にコミットメッセージを提案する
- ユーザーの明示的な承認があるまで `git commit -m` を実行しない
- コミットに Claude 共著フッターを追加しない

## コミットメッセージ規約

- 形式: `絵文字 scope: 説明`
- 説明は日本語で簡潔に書く
- scope は変更の主対象を短く表す（例: `docs` `ai` `claude` `root`）

## 実行手順

1. `git add -A` を実行する
2. `git diff --cached --name-only` でステージング対象を確認する
3. `git diff --cached` で変更内容を把握する
4. 規約に沿ったコミットメッセージ候補を提示する
5. ユーザーの明示承認後に `git commit -m "..."` を実行する
