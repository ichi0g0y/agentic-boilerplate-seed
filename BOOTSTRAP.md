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
4. 実装・検証を実行し、結果を報告する

## 既存プロジェクトへ移植する場合の手順

1. `docs/guides/AI_INSTRUCTION_PORTING.md` に従って以下を配置する
   - `AGENTS.md`
   - `CLAUDE.md`
   - `AI.md`
   - `.ai/*.md`
2. 対象リポジトリに既存の AI 関連ドキュメント（`AGENTS.md` / `CLAUDE.md` / `AI.md` / `.ai/*.md`）がある場合は、上書きせず差分比較して統合する
   - 既存プロジェクト固有の制約は保持する
   - 本テンプレートの共通運用（レビュー連携、コミット運用など）は可能な限り採用する
   - 衝突した項目は採用方針（採用 / 不採用 / 保留）を明記する
3. 配置後、最低限次の3点を対象プロジェクト向けに更新する
   - `.ai/project.md`
   - `.ai/rules.md`
   - `.ai/workflow.md`
4. 既存ルールとの衝突点を洗い出し、採用方針を明記する

## 初回依頼テンプレート（ユーザー用）

以下をそのまま AI へ渡してください。

```text
このリポジトリ準拠で作業してください。
対象リポジトリ: https://github.com/ichi0g0y/agentic-boilerplate-seed.git
まず BOOTSTRAP.md と AGENTS.md を読み、指定された必読ドキュメントを確認してください。
追加の個別指示がなくても、BOOTSTRAP.md に記載の初期手順を実行してください。
その後、以下を先に報告してください。
1) 読み込んだルールファイル
2) 今回の作業対象
3) 作業前に守る制約

既存プロジェクトへの移植の場合は、
docs/guides/AI_INSTRUCTION_PORTING.md の手順で不足ファイルを補い、
.ai/project.md / .ai/rules.md / .ai/workflow.md をプロジェクト用に調整してください。
既存の AGENTS.md / CLAUDE.md / AI.md / .ai/*.md がある場合は上書きせず統合し、
採用方針（採用 / 不採用 / 保留）を報告してください。
```
