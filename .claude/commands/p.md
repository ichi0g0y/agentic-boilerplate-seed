---
title: "Issue固定タスク"
read_only: false
type: "command"
argument-hint: "[issue-number]"
---

# Issue固定（/p）

## 短縮コマンド宣言

- `/p` は `/pick` の短縮コマンド。
- 挙動・判断基準は `.claude/commands/pick.md` に準拠する。

## 実行ルール

- 詳細仕様は `.ai/workflow.md` の「Issueスコープ管理（任意）」に従う。
- 引数ありは指定Issue番号を `.context/current_issue` に保存する。
- 引数なしは優先度順で候補を取得し、1件なら自動設定、複数なら選択する。
- 既存の `.context/current_issue` がある場合は上書き確認を行う。
