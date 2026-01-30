# ms-e-claude-code-grader

Claude Code のカスタムスラッシュコマンドとサブエージェントを使い、受講生のリポジトリをルーブリックに基づいて自動採点するツールです。

## 仕組み

`/grade` コマンドを実行すると、メインエージェント（オーケストレーター）が **4つの評価サブエージェント** と **1つの検証サブエージェント** を順に起動し、計24項目の採点を行います。

```
/grade (オーケストレーター)
  ├── Phase 0: プリフライトチェック
  ├── Phase 1: git_process        … G1-G5  Git・開発プロセス
  ├── Phase 2: code_quality       … C1-C10 コード品質・設計
  ├── Phase 3: testing_cicd       … T1-T5  テスト・CI/CD
  ├── Phase 4: docs_communication … D1-D4  ドキュメント
  ├── Phase 5: verification       … 検証サブエージェント
  └── Phase 6: 最終レポート生成 → GRADING_REPORT.md
```

各サブエージェントの出力を検証サブエージェントがチェックした後、メインエージェントが最終レポート (`GRADING_REPORT.md`) を生成します。

## 評価項目一覧（24項目）

### Git・開発プロセス（G1-G5）

| ID | 評価項目 |
|----|---------|
| G1 | コミット粒度・メッセージ |
| G2 | タスク・Issue管理 |
| G3 | PRレビュー・マージ判断 |
| G4 | バグ分析・特定 |
| G5 | 修正方針の導出 |

### コード品質・設計（C1-C10）

| ID | 評価項目 |
|----|---------|
| C1 | 入力値検証・防衛的プログラミング |
| C2 | 例外処理 |
| C3 | 静的解析ツール |
| C4 | 命名規則 |
| C5 | ディレクトリ構造 |
| C6 | DRY原則・単一責任 |
| C7 | ログ設計 |
| C8 | セキュリティ対策 |
| C9 | パフォーマンス・キャッシュ |
| C10 | アーキテクチャ |

### テスト・CI/CD（T1-T5）

| ID | 評価項目 |
|----|---------|
| T1 | テスト設計書 |
| T2 | テストケース網羅性 |
| T3 | テストコード実装 |
| T4 | 依存性管理（Mock） |
| T5 | CI/CD実装 |

### ドキュメント・コミュニケーション（D1-D4）

| ID | 評価項目 |
|----|---------|
| D1 | コメントの質 |
| D2 | READMEの充実度 |
| D3 | 設計書の整備 |
| D4 | PR記述の適切さ |

## ディレクトリ構成

```
.claude/
  commands/
    grade.md              # オーケストレーター（/grade コマンド）
  agents/
    git_process.md        # G1-G5 評価サブエージェント
    code_quality.md       # C1-C10 評価サブエージェント
    testing_cicd.md       # T1-T5 評価サブエージェント
    docs_communication.md # D1-D4 評価サブエージェント
    verification.md       # 検証サブエージェント
  resources/
    evaluation_rubric.md  # 評価ルーブリック（24項目の判定基準）
CLAUDE.md                 # プロジェクトの永続コンテキスト
```

## 導入

```bash
git clone https://github.com/aiirononeko/ms-e-claude-code-grader.git
cd ms-e-claude-code-grader

# 設定ファイルを Claude Code のグローバル設定にコピー
mkdir -p ~/.claude/commands ~/.claude/resources ~/.claude/agents
cp -r .claude/commands/* ~/.claude/commands/
cp -r .claude/resources/* ~/.claude/resources/
cp -r .claude/agents/* ~/.claude/agents/
```

## 使い方

### 前提条件

`gh` CLI（GitHub CLI）がインストールされ、認証済みであることを確認してください。

```bash
# インストール確認
gh --version

# 未認証の場合
gh auth login
```

### 採点の実行

1. 採点対象のリポジトリをClaude Codeで開きます。
2. Claude Code 上で `/grade` を実行します:

```bash
# 対話モード
> /grade

# ワンショット実行
claude -p "/grade"
```

実行が完了すると、カレントディレクトリに `GRADING_REPORT.md` が出力されます。

## カスタマイズ

- **評価基準の変更**: `~/.claude/resources/evaluation_rubric.md` を編集してください。
- **サブエージェントの調整**: `~/.claude/agents/` 内の各ファイルで探索ステップや判定基準を調整できます。

## 注意事項

- `gh` CLI が使えない環境でも動作しますが、PR・Issue 関連の項目（G2-G5, D4）は制約付き評価となります。
- 対象言語は TypeScript を中心に Python・Ruby にも対応しています。
