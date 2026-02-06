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

### 採点ツール (`/grade`)

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

### セクション別コードレビューツール (`/review-s1` 〜 `/review-s8`)

```
/review-sN (オーケストレーター)
  ├── Phase 0: プリフライトチェック（git, gh CLI, 言語検出, 教材確認）
  ├── Phase 1: review_common      … 共通レビュー（構造・命名・品質・Git運用）
  ├── Phase 2: review_sN_*        … セクション固有レビュー（教材ベース）
  └── Phase 3: REVIEW_REPORT.md 生成
```

| コマンド | セクション | 固有エージェント |
|---------|-----------|----------------|
| `/review-s1` | CS基礎 | `review_s1_cs.md` |
| `/review-s2` | AWS・DB設計 | `review_s2_aws_db.md` |
| `/review-s3` | React + Next.js | `review_s3_react_next.md` |
| `/review-s4` | Backend + Express | `review_s4_backend.md` |
| `/review-s5` | 品質保証 | `review_s5_qa.md` |
| `/review-s6` | チーム開発 | `review_s6_team.md` |
| `/review-s7` | TypeScript以外の言語 | `review_s7_multilang.md` |
| `/review-s8` | LLM活用プロダクト開発 | `review_s8_llm.md` |

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
    grade.md                # 採点オーケストレーター
    review-s1.md            # Section 1 レビューオーケストレーター
    review-s2.md            # Section 2 レビューオーケストレーター
    review-s3.md            # Section 3 レビューオーケストレーター
    review-s4.md            # Section 4 レビューオーケストレーター
    review-s5.md            # Section 5 レビューオーケストレーター
    review-s6.md            # Section 6 レビューオーケストレーター
    review-s7.md            # Section 7 レビューオーケストレーター
    review-s8.md            # Section 8 レビューオーケストレーター
  agents/
    git_process.md          # G1-G6 評価サブエージェント
    code_quality.md         # C1-C10 評価サブエージェント
    testing_cicd.md         # T1-T6 評価サブエージェント
    docs_communication.md   # D1-D6 評価サブエージェント
    verification.md         # 検証サブエージェント
    review_common.md        # 共通レビューサブエージェント
    review_s1_cs.md         # Section 1 固有レビュー
    review_s2_aws_db.md     # Section 2 固有レビュー
    review_s3_react_next.md # Section 3 固有レビュー
    review_s4_backend.md    # Section 4 固有レビュー
    review_s5_qa.md         # Section 5 固有レビュー
    review_s6_team.md       # Section 6 固有レビュー
    review_s7_multilang.md  # Section 7 固有レビュー
    review_s8_llm.md        # Section 8 固有レビュー
  resources/
    evaluation_rubric.md    # 評価ルーブリック（28項目）
    review_guidelines.md    # レビューガイドライン・出力フォーマット
    sections/
      s1/ ~ s8/
        materials.md        # 各セクションの教材リファレンス
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
- `GRADING_REPORT.md` / `REVIEW_REPORT.md` は `.gitignore` に含まれており、リポジトリにはコミットしない。
