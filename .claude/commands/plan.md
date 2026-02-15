---
title: "計画準備タスク"
read_only: true
type: "command"
---

# 計画準備（/plan）

## 目的

実装に入る前に、AIを「計画準備状態」に遷移させる。

## 実行手順

1. 以下をこの順で読み込む。
   - `AI.md`
   - `.ai/behavior.md`
   - `.ai/rules.md`
   - `.ai/workflow.md`
2. `.context/issue_scope.json` が存在する場合は内容を確認する。
3. 現在の状態を要約する。
   - ルール読み込み完了可否
   - Issue連携の有無（`primary_issue` / `related_issues`）
   - 次に行う1手（通常は「ユーザー確認」）
4. 日本語で報告する。

## ルール

- `/plan` は準備状態に入るためのコマンドであり、実装・Issue作成・コミット・PRマージを実行しない。
- その後にファイル変更を伴う依頼へ進む場合は、`.ai/behavior.md` の通常時フローに従って Issue化可否を確認する。
