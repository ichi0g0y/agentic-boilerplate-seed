# agentic-boilerplate-seed

言語やフレームワークをまだ決めていない状態で、AI（Codex / Claude）と協調しながらプロジェクトを立ち上げるための最小ボイラープレートです。

## このテンプレートの方針

- 実装前にAI運用ルールを先に固定する
- 技術スタック未決定でも使えるよう、言語依存ルールを持ち込まない
- レビュー連携は `.context/_review_feedback.md` のみで管理する

## ディレクトリ構成

- `.ai/`: エージェント共通ルール（必読）
- `.claude/commands/`: Claude用コマンド定義（commit / review-verify）
- `BOOTSTRAP.md`: AIセッション開始時の初期手順
- `docs/`: 最小限の運用ドキュメント
- `.context/`: エージェント間の作業連携用（gitignore前提）

## 使い始める手順

1. `docs/guides/GETTING_STARTED.md` を読む
2. `.ai/project.md` に今回の目的と制約を書く
3. 言語選定までは、設計・要件・タスク分解を中心に進める
4. 言語選定後に、必要な開発/テストコマンドを `docs/` と `.ai/` に追加する

## BOOTSTRAP.md の使い方

1. AIへ最初に依頼する前に `BOOTSTRAP.md` を開く
2. `BOOTSTRAP.md` の「初回依頼テンプレート」をそのまま依頼文に含め、対象リポジトリURLを明記する
3. AIの初回返答で、読込ルール・作業対象・制約確認が報告されていることを確認する

## エージェント定義について

このテンプレートでは `.claude/agents/` にカスタムエージェント定義を意図的に配置していません。
Claude Code の組み込みエージェント、またはユーザーディレクトリ（`~/.claude/agents/`）のエージェント定義を使用する方針です。

## AI協調フロー

- 実装: 指示に沿って実装し、必要な検証結果を報告
- レビュー: 問題がある場合のみ `.context/_review_feedback.md` を先に作成
- `/review-verify`: 指摘を検証し、採用したものだけ修正

詳細は `.ai/workflow.md` を参照してください。
