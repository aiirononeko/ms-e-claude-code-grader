# ms-e-claude-code-grader

Claude Code のカスタムスラッシュコマンドとサブエージェントを使い、受講生のリポジトリをルーブリックに基づいて自動採点するツールです。

## 仕組み

`/grade` コマンドを実行すると、メインエージェントが3つのサブエージェントを順に起動し、それぞれ独立した観点で評価を行います。

1. **Git監査** -- コミット粒度、メッセージ規約、ブランチ運用、PRテンプレートの有無
2. **コード品質・設計** -- ディレクトリ構造、命名規則、エラーハンドリング、DRY原則
3. **ドキュメント・テスト** -- README、テストコード、CI/CD設定の有無

各サブエージェントの出力をメインエージェントが統合し、最終レポート (`GRADING_REPORT.md`) を生成します。

評価カテゴリの詳細は `~/.claude/resources/evaluation_rubric.md` を参照してください。

## 導入

```bash
git clone https://github.com/aiirononeko/ms-e-claude-code-grader.git
cd ms-e-claude-code-grader

# 設定ファイルを Claude Code のグローバル設定にコピー
mkdir -p ~/.claude/commands ~/.claude/resources
cp -r .claude/commands/* ~/.claude/commands/
cp -r .claude/resources/* ~/.claude/resources/
```

## 使い方

採点対象のリポジトリに移動し、Claude Code 上で `/grade` を実行します。

```bash
cd /path/to/student-repo

# 対話モード
> /grade

# ワンショット実行
claude -p "/grade"
```

実行が完了すると、カレントディレクトリに `GRADING_REPORT.md` が出力されます。

## カスタマイズ

評価基準を変更するには `~/.claude/resources/evaluation_rubric.md` を編集してください。判定記号の定義や各カテゴリの判定基準が記載されています。
