# Claude Code Automated Grader 🤖

Claude Codeを使用して、受講生のリポジトリを自動採点するためのツールセットです。
評価基準（ルーブリック）に基づき、Gitの運用、コード品質、ドキュメント等を多角的に監査します。

## 🚀 導入手順 (Setup)

このリポジトリをクローンし、`.claude` フォルダの中身をあなたのホームディレクトリの `.claude` にコピーしてください。

```bash
# 1. このリポジトリをクローン
git clone [https://github.com/aiirononeko/ms-e-claude-code-grader.git](https://github.com/aiirononeko/ms-e-claude-code-grader.git)
cd ms-e-claude-code-grader

# 2. 設定ファイルをClaude Codeのグローバル設定へコピー
# (既に .claude フォルダがある前提です)
cp -r .claude/commands/* ~/.claude/commands/
cp -r .claude/resources/* ~/.claude/resources/
※ .claude/resources フォルダがない場合は作成してください: mkdir -p ~/.claude/resources

📝 使い方 (Usage)
採点したい受講生のリポジトリに移動します。

Bash
cd ~/projects/students/student-repo-name
Claude Codeを起動し、コマンドを実行します。

Bash
# 対話モードの場合
> /grade

# 一発実行の場合
claude -p "/grade"
実行後、カレントディレクトリに GRADING_REPORT.md が生成されます。

⚙️ カスタマイズ
評価基準を変更したい場合は、~/.claude/resources/evaluation_rubric.md を編集してください。
