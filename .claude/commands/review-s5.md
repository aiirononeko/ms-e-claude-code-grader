# Section 5: 品質保証 コードレビューオーケストレーター

Description: Section 5（品質保証）の課題リポジトリに対して、共通レビュー＋セクション固有レビューを実行し、REVIEW_REPORT.md を生成します。

## 重要なルール

- メインエージェント（このコマンド）はソースコード・Gitログを**直接読み込まない**こと（コンテキスト汚染防止）。
- 各フェーズで必ずサブエージェントを使用すること。
- レビューガイドライン: `~/.claude/resources/review_guidelines.md`
- 教材リファレンス: `~/.claude/resources/sections/s5/materials.md`

---

## Phase 0: プリフライトチェック

サブエージェントを起動する前に、メインエージェントが以下を確認する。

1. **カレントディレクトリの確認**:
   ```bash
   ls .git
   ```
   `.git` が存在しない場合、ユーザーに対象リポジトリへの移動を促して終了する。

2. **gh CLI の可用性チェック**:
   ```bash
   gh auth status 2>&1
   ```

3. **言語・FW の検出**:
   ```bash
   ls package.json tsconfig.json pyproject.toml setup.py Gemfile Cargo.toml go.mod 2>/dev/null
   ```

4. **教材の存在確認**:
   ```bash
   ls ~/.claude/resources/sections/s5/materials.md 2>/dev/null
   ```

5. **結果の記録**:
   - リポジトリパス
   - gh CLI 可用性（available / unavailable）
   - 検出言語・FW
   - 教材参照（設定済み / 未設定）

---

## Phase 1: 共通レビュー（サブエージェント）

サブエージェントを起動し、以下の指示を与える:

> `~/.claude/agents/review_common.md` を読み、その指示に従って共通レビューを実行してください。
> レビューガイドラインは `~/.claude/resources/review_guidelines.md` を参照してください。
> 出力は review_common.md に定義されたフォーマットに従ってください。

サブエージェントの出力を **共通レビュー結果** として保持する。

---

## Phase 2: セクション固有レビュー（サブエージェント）

サブエージェントを起動し、以下の指示を与える:

> `~/.claude/agents/review_s5_qa.md` を読み、その指示に従ってSection 5固有のレビューを実行してください。
> レビューガイドラインは `~/.claude/resources/review_guidelines.md` を参照してください。
> 教材リファレンスは `~/.claude/resources/sections/s5/materials.md` を参照してください。
> 出力は review_s5_qa.md に定義されたフォーマットに従ってください。

サブエージェントの出力を **セクション固有レビュー結果** として保持する。

---

## Phase 3: レポート生成

メインエージェントが Phase 1-2 の結果を統合し、`~/.claude/resources/review_guidelines.md` の出力フォーマットに従って `REVIEW_REPORT.md` を生成する。

### レポートのメタ情報

- **生成日時**: 現在日時
- **対象リポジトリ**: カレントディレクトリパス
- **セクション**: Section 5: 品質保証
- **検出言語・FW**: Phase 0 の検出結果
- **教材参照**: Phase 0 の確認結果
- **gh CLI**: Phase 0 の可用性

### 最終アクション

1. `REVIEW_REPORT.md` をカレントディレクトリに保存する。
2. 総評のサマリーをユーザーに表示する。
3. 教材が未設定の場合、その旨をユーザーに伝える。
