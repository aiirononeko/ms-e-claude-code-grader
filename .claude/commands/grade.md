# Student Repository Grader

Description: ベストプラクティスに基づき、サブエージェントを用いて「Git」「コード」「ドキュメント」を独立して採点し、統合レポートを作成します。

## Guidelines
- メインエージェントはソースコードやGitログを直接読み込まないでください（コンテキスト汚染防止）。
- 各フェーズで必ず **"Use a sub-agent"** を実行してください。
- 評価基準ファイル: `~/.claude/resources/evaluation_rubric.md`

## Steps

1. **Phase 1: Git Audit (Sub-agent)**
   - Use a sub-agent to analyze Git history.
   - **Instruction for Sub-agent:**
     1. Read the "Git / バージョン管理" section of the rubric file.
     2. Run `git log --oneline -n 30` to check commit granularity and messages.
     3. Run `git branch -a` to check branch naming.
     4. Check if PR templates exist (look for `.github/pull_request_template.md`).
     5. Output a concise Markdown summary focusing ONLY on Git criteria.

2. **Phase 2: Code Quality & Architecture (Sub-agent)**
   - Use a sub-agent to analyze code quality.
   - **Instruction for Sub-agent:**
     1. Read the "実装・機能要件" and "コード品質・可読性" sections of the rubric.
     2. Explore the file structure using `ls -R` (ignore `node_modules`).
     3. Select and read 2-3 representative source files (e.g., from `src/`).
     4. Check for: Naming conventions, Error handling (try-catch), and Directory structure.
     5. Output a concise Markdown summary focusing ONLY on Code criteria.

3. **Phase 3: Documentation & Testing (Sub-agent)**
   - Use a sub-agent to check docs and tests.
   - **Instruction for Sub-agent:**
     1. Read the "品質保証" and "ドキュメンテーション" sections of the rubric.
     2. Check for `README.md` and test files (`.test.ts`, `.spec.js`, etc.).
     3. Check for CI configs (`.github/workflows`).
     4. Output a concise Markdown summary focusing on Docs/Tests.

4. **Phase 4: Final Report Generation**
   - As the Main Agent, read the summaries from Phase 1, 2, and 3.
   - Compile a final grading report strictly following the "採点レポートの出力形式" in the rubric.
   - Save the report to `GRADING_REPORT.md` in the current directory.
   - Display the summary table to the user.
