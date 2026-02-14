# AI指示ファイル移植ガイド

このテンプレートのAI運用ルールを別リポジトリへ移植するための手順です。

## 対象ファイル

- `AGENTS.md`
- `CLAUDE.md`
- `AI.md`
- `.ai/*.md`
- `issues/README.md`
- `issues/index.md`
- `issues/templates/issue.md`
- `issues/open/` / `issues/in-progress/` / `issues/done/`

## 移植対象外ファイル（原則）

- `BOOTSTRAP.md`
- `docs/guides/AI_INSTRUCTION_PORTING.md`
- 理由: いずれもテンプレート側の導入手順・参照資料であり、対象リポジトリの常設運用ファイルではないため

## 移植手順

1. 対象リポジトリに上記ファイルを配置する
2. 既存の AI 関連ドキュメント（`AGENTS.md` / `CLAUDE.md` / `AI.md` / `.ai/*.md`）がある場合は、上書きせず差分比較して統合する
3. 衝突したルールは採用方針（採用 / 不採用 / 保留）を明記する
4. `.ai/project.md` をプロジェクト内容に合わせて更新する
5. `.ai/rules.md` に言語・フレームワーク固有ルールを追加する
6. `.ai/workflow.md` のコマンド例を実運用に合わせて更新する
7. 既存のタスク管理資料（`docs/TODO.md` など）がある場合は、Issue運用に移行する
8. 旧タスク管理資料への参照が残っていないことを確認する（`README.md` / `docs/` / `AGENTS.md` など）
9. 移行完了した旧タスク管理資料（`docs/TODO.md` など）を削除する
10. 移植後に以下が満たされることを確認する
    - 手順書・計画・レビュー観点が `issues/` に集約されている
    - Issue単位でworktreeを作成する運用になっている
    - 小さなPRを順次適用する方針が明文化されている

## 注意点

- 既存プロダクト固有の制約はそのまま流用しない
- ローカル絶対パスを含む設定は削除する
- `/commit`・`/commit!` の運用ルールだけは全リポジトリで統一する
- `docs/` は確定情報の保管先とし、揮発タスクを混在させない
