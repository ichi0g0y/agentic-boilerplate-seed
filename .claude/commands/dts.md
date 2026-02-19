---
title: "ステージング反映PRタスク"
read_only: false
type: "command"
argument-hint: "[--no-merge] [release-label]"
---

# ステージング反映PR作成（/dts）

## 短縮コマンド宣言

- `/dts` は `/deploy-to-staging` の短縮コマンド。
- 挙動・判断基準は `.claude/commands/deploy-to-staging.md` に準拠する。

## 実行ルール

- `base=staging` / `head=develop` のPR作成（または既存PR再利用）を行う。
- `--no-merge` がない限り、PRは作成/更新後にマージまで行う。
