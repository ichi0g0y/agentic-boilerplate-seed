---
title: "本番反映PRタスク"
read_only: false
type: "command"
argument-hint: "[--no-merge] [release-label]"
---

# 本番反映PR作成（/dtp）

## 短縮コマンド宣言

- `/dtp` は `/deploy-to-production` の短縮コマンド。
- 挙動・判断基準は `.claude/commands/deploy-to-production.md` に準拠する。

## 実行ルール

- `base=main` / `head=develop` のPR作成（または既存PR再利用）を行う。
- `--no-merge` がない限り、PRは作成/更新後にマージまで行う。
