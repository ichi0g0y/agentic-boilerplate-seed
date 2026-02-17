# BOOTSTRAP

このドキュメントは、Codex / Claude に対して「このリポジトリ準拠で作業する」ための初期手順を示します。

## 目的

- セッション開始時の読み込み漏れを防ぐ
- 実装前にルール・制約・運用フローを揃える
- 既存プロジェクトへの移植時に、調整対象を明確にする

## セッション開始時の実行手順（AI向け）

1. 次の順に必読ドキュメントを確認する  
   `AGENTS.md` → `AI.md` → `CLAUDE.md` → `.ai/behavior.md` → `.ai/rules.md` → `.ai/workflow.md` → `.ai/project.md`
2. レビュー対応タスクの場合のみ、追加で次を確認する  
   `.ai/review.md` / `.ai/dev-env.md` / `.ai/git.md`
3. ルール確認後、着手前に以下を短く報告する
   - 読み込んだファイル
   - 作業対象
   - 守るべき制約（コミット条件、レビュー連携ルールなど）
   - Issue起点 + worktree + 小PRで進めること
4. 実装・検証を実行し、結果を報告する

## 既存プロジェクトへ移植する場合の手順

1. `docs/guides/AI_INSTRUCTION_PORTING.md` に従って以下を配置する
   - `AGENTS.md`
   - `CLAUDE.md`
   - `AI.md`
   - `.ai/*.md`
   - `BOOTSTRAP.md` と `docs/guides/AI_INSTRUCTION_PORTING.md` は参照専用とし、対象リポジトリへは原則配置しない
2. 対象リポジトリに既存の AI 関連ドキュメント（`AGENTS.md` / `CLAUDE.md` / `AI.md` / `.ai/*.md`）がある場合は、上書きせず差分比較して統合する
   - 既存プロジェクト固有の制約は保持する
   - 本テンプレートの共通運用（レビュー連携、コミット運用など）は可能な限り採用する
   - 衝突した項目は採用方針（採用 / 不採用 / 保留）を明記する
3. 配置後、最低限次の3点を対象プロジェクト向けに更新する
   - `.ai/project.md`
   - `.ai/rules.md`
   - `.ai/workflow.md`
4. 既存ルールとの衝突点を洗い出し、採用方針を明記する
5. GitHub Issue運用を導入する
   - `docs/guides/ISSUE_WORKFLOW.md` の手順に従う
   - `.ai/workflow.md` の「Issue状態とラベル」「基本フロー」を対象プロジェクト向けに調整する
   - 必要に応じて `.context/issue_scope.json` を使ったIssueスコープ共有ルールを整備する
6. 既存のタスク管理先（TODOドキュメント等）がある場合は、GitHub Issues 運用へ移行する
   - どの情報を GitHub Issues に移すかを明記する
   - 移行後、旧タスク管理ドキュメントへの参照が残っていないことを確認する
   - 移行完了した旧タスク管理ドキュメント（`docs/TODO.md` など）は削除する
7. `main` デフォルト + `develop` 統合運用を採用する場合は `docs/guides/DEVELOP_FLOW_BOOTSTRAP.md` を適用する
   - `release:pending` ラベル運用と2つのGitHub Actionsを導入する
   - develop向けPR本文で `Closes/Fixes/Resolves #...` を必須化する
   - `develop -> main` 反映時は `/merge-to-main` または `/mtm` を必須手順として導入する

## 初回依頼テンプレート（ユーザー用）

以下をそのまま AI へ渡してください。

```text
このリポジトリ準拠で作業してください。
対象リポジトリ: https://github.com/ichi0g0y/agentic-boilerplate-seed.git
まず（このテンプレートの）BOOTSTRAP.md と、対象リポジトリの AGENTS.md を読み、
指定された必読ドキュメントを確認してください。
追加の個別指示がなくても、BOOTSTRAP.md に記載の初期手順を参照して実行してください。
その後、以下を先に報告してください。
1) 読み込んだルールファイル
2) 今回の作業対象
3) 作業前に守る制約

既存プロジェクトへの移植の場合は、
docs/guides/AI_INSTRUCTION_PORTING.md の手順で不足ファイルを補い、
.ai/project.md / .ai/rules.md / .ai/workflow.md をプロジェクト用に調整してください。
このテンプレート側の BOOTSTRAP.md と docs/guides/AI_INSTRUCTION_PORTING.md は参照専用であり、
対象リポジトリへは追加しないでください。
また、手順書・計画・レビュー観点は GitHub Issues に集約し、
Issueごとにworktreeを分けて小さなPRを順次適用する運用を導入してください。
既存の AGENTS.md / CLAUDE.md / AI.md / .ai/*.md がある場合は上書きせず統合し、
採用方針（採用 / 不採用 / 保留）を報告してください。
`docs/TODO.md` など既存のタスク管理ドキュメントは GitHub Issues へ移行後、
参照が残っていないことを確認して削除してください。
```
