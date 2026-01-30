# CLAUDE.md — ms-e-claude-code-grader

## 目的

**講師補助ツール**: 受講生リポジトリとGitHubから取得可能な情報を自動評価し、講師のレビュー作業を効率化する。

- **このツールの役割**: リポジトリ・GitHub から判断できる項目を自動評価し、判断材料を提供
- **講師の役割**: 自動評価結果をダブルチェックし、Notion・Discord・普段のコミュニケーションを加味して最終評価を決定

Claude Code のサブエージェント機能を利用し、評価の独立性とコンテキスト分離を実現する。

## 確信度の定義

各評価項目には確信度（Confidence）を付与する:

| 確信度 | 意味 | 講師アクション |
|--------|------|---------------|
| **HIGH** | 明確な証拠あり。自動判定の信頼度が高い | 軽く確認 |
| **MEDIUM** | 証拠はあるが解釈の余地あり | 要確認 |
| **LOW** | 証拠が限定的、または外部情報が必要 | 要判断 |

## アーキテクチャ

```
/grade (オーケストレーター)
  ├── Phase 0: プリフライトチェック
  ├── Phase 1: git_process    … G1-G6  Git・開発プロセス
  ├── Phase 2: code_quality   … C1-C10 コード品質・設計
  ├── Phase 3: testing_cicd   … T1-T6  テスト・CI/CD
  ├── Phase 4: docs_communication … D1-D6 ドキュメント
  ├── Phase 5: verification   … 検証サブエージェント
  └── Phase 6: 最終レポート生成 → GRADING_REPORT.md
```

## 採点規約

- 判定は **[OK] / [WARN] / [NG]** の3段階のみ使用する。
- 全判定に **証拠** を付与すること（ファイルパス:行番号、コミットハッシュ、コマンド出力のいずれか）。
- 全判定に **確信度**（HIGH / MEDIUM / LOW）を付与すること。
- 推測で [OK] を付けない。証拠が得られない場合は [WARN] + 理由を明記する。
- メインエージェント（grade.md）はソースコード・Gitログを直接読まない。

## 対象言語

TypeScript を中心に想定するが、Python・Ruby にも対応する。
特定フレームワークを前提とせず、言語・FW を自動検出して適切なチェックを行う。

## ディレクトリ構成

```
~/.claude/
  commands/
    grade.md              # オーケストレーター（スラッシュコマンド）
  agents/
    git_process.md        # G1-G6 評価サブエージェント
    code_quality.md       # C1-C10 評価サブエージェント
    testing_cicd.md       # T1-T6 評価サブエージェント
    docs_communication.md # D1-D6 評価サブエージェント
    verification.md       # 検証サブエージェント
  resources/
    evaluation_rubric.md  # 評価ルーブリック（28項目）
```

## よく使うコマンド

| 用途 | コマンド |
|------|---------|
| コミット履歴 | `git log --oneline --all --graph -n 50` |
| ブランチ一覧 | `git branch -a` |
| PR一覧 | `gh pr list --state all --limit 20` |
| Issue一覧 | `gh issue list --state all --limit 20` |
| ファイルツリー | `find . -type f -not -path './.git/*' -not -path '*/node_modules/*' -not -path '*/vendor/*' -not -path '*/__pycache__/*'` |
| テストファイル検索 | `find . -type f \( -name '*.test.*' -o -name '*.spec.*' -o -name 'test_*' \) -not -path '*/node_modules/*'` |
| CI/CD設定 | `ls -la .github/workflows/ 2>/dev/null` |

## 注意事項

- `gh` CLI が使えない環境では、PR・Issue 関連の項目に「gh CLI 未使用のため制約あり」と明記する。
- `GRADING_REPORT.md` は `.gitignore` に含まれており、リポジトリにはコミットしない。
