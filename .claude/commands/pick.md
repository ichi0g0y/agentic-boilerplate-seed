---
title: "Issue固定タスク"
read_only: false
type: "command"
argument-hint: "[issue-number]"
---

# Issue固定（/pick）

## 目的

対象Issueを `.context/current_issue` に保存し、作業対象を明示する。

## 実行手順

1. 既存の `.context/current_issue` の有無を確認する。
2. 既存ファイルがある場合:
   - 既存スコープがある旨を警告する。
   - 上書きしてよいかユーザーに確認する。
3. 引数がある場合:
   - 引数のIssue番号を `.context/current_issue` に1行で保存する。
4. 引数がない場合:
   - Open Issue を優先度順（`P0 -> P1 -> P2 -> P3 -> 優先度なし`）で候補取得する。
   - 最上位が1件ならそのIssue番号を設定する。
   - 複数候補ならユーザーに選択を求める。
5. 設定結果（Issue番号）を報告する。

## ルール

- `/pick` は任意コマンド。未実行でも通常動作は可能。
- `.context/current_issue` はIssue番号のみを保存する。
- 既存スコープがある場合、ユーザー確認なしで上書きしない。
