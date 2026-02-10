# ms-e-claude-code-grader

Claude Code のカスタムスラッシュコマンドとサブエージェントを使い、受講生のリポジトリを自動評価するツールです。

## 機能

### `/grade` — ルーブリック採点

ルーブリック（24項目）に基づき、[OK] / [WARN] / [NG] の3段階で採点します。結果は `GRADING_REPORT.md` に出力されます。

### `/review-sN` — セクション別コードレビュー

セクションごとの教材に基づき、良い点・改善提案をコードレビュー形式で出力します。結果は `REVIEW_REPORT.md` に出力されます。

## セクション別レビュー 対応状況

教材データ（`materials.md`）が登録されたセクションのみ、セクション固有のレビューが有効になります。未登録のセクションでも共通レビュー（構造・命名・品質・Git運用）は実行されます。

| コマンド | セクション | 教材登録 |
|---------|-----------|---------|
| `/review-s1` | CS基礎 | 未登録 |
| `/review-s2` | AWS・DB設計 | 未登録 |
| `/review-s3` | React + Next.js | 未登録 |
| `/review-s4` | Backend + Express | 未登録 |
| `/review-s5` | 品質保証 | 未登録 |
| `/review-s6` | チーム開発 | 未登録 |
| `/review-s7` | TypeScript以外の言語 | 未登録 |
| `/review-s8` | LLM活用プロダクト開発 | 未登録 |

教材データの登録先: `.claude/resources/sections/sN/materials.md`

## 導入

### 前提条件

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) がインストール済み
- `gh` CLI（GitHub CLI）がインストール・認証済み

```bash
gh --version
gh auth login  # 未認証の場合
```

### セットアップ

```bash
git clone https://github.com/aiirononeko/ms-e-claude-code-grader.git
cd ms-e-claude-code-grader

# セットアップスクリプトを実行（シンボリックリンクを作成）
./setup.sh
```

このスクリプトは `~/.claude/` 配下に**ファイル単位で**シンボリックリンクを作成します。

**既存のコマンド/スキルと共存できます：**
- 既存の個人用ファイルはそのまま保持されます
- このツールのファイルだけがシンボリックリンクとして追加されます
- `~/.claude/commands/` に個人用コマンドがあっても問題ありません

## 使い方

採点対象のリポジトリを Claude Code で開き、コマンドを実行します。

```bash
# ルーブリック採点
> /grade

# セクション別コードレビュー（例: Section 3）
> /review-s3
```

ワンショット実行も可能です。

```bash
claude -p "/grade"
claude -p "/review-s3"
```

## 更新方法

このリポジトリで最新版を取得し、セットアップスクリプトを再実行します。

```bash
cd ms-e-claude-code-grader
git pull
./setup.sh
```

既存のシンボリックリンクは自動的に更新され、新規ファイルがあれば追加されます。個人用ファイルはそのまま保持されます。

## カスタマイズ

| 対象 | ファイル |
|------|---------|
| 採点ルーブリック | `.claude/resources/evaluation_rubric.md` |
| レビューガイドライン | `.claude/resources/review_guidelines.md` |
| セクション教材 | `.claude/resources/sections/sN/materials.md` |
| サブエージェント | `.claude/agents/` 内の各ファイル |

## 注意事項

- `gh` CLI が使えない環境でも動作しますが、PR・Issue 関連の評価は制約付きになります。
- 対象言語は TypeScript を中心に Python・Ruby にも対応しています。
- `GRADING_REPORT.md` / `REVIEW_REPORT.md` はリポジトリにコミットされません（`.gitignore` 済み）。

## トラブルシューティング

### スラッシュコマンドが認識されない

```bash
# シンボリックリンクの確認
ls -la ~/.claude/commands

# セットアップを再実行
cd ms-e-claude-code-grader
./setup.sh
```

### 古いバージョンが動いている

Claude Code を再起動してください。

```bash
# Claude Code を再起動
# または、新しいターミナルで実行
```

### このツールのファイルだけを削除したい

```bash
# このツールが作成したシンボリックリンクだけを削除
cd ~/.claude/commands
ls -la | grep '\->' | grep 'ms-e-claude-code-grader' | awk '{print $9}' | xargs rm

cd ~/.claude/agents
ls -la | grep '\->' | grep 'ms-e-claude-code-grader' | awk '{print $9}' | xargs rm

cd ~/.claude/resources
# 必要に応じて resources/ 配下も同様に
```

個人用ファイル（実体）は削除されません。
