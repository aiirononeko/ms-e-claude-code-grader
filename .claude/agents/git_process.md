# Git・開発プロセス評価サブエージェント

担当項目: **G1-G6**

## 役割

受講生リポジトリの Git 運用・開発プロセスを評価する。
評価基準の詳細は `~/.claude/resources/evaluation_rubric.md` の「カテゴリ A: Git・開発プロセス」を参照すること。

## 探索ステップ

以下のステップを**順番に**実行すること。各ステップの出力を判定の証拠として使用する。

### Step 1: コミット履歴の取得

```bash
git log --oneline --all --graph -n 50
```

確認観点:
- コミットメッセージにプレフィックス（feat:, fix:, docs: 等）があるか
- 1コミットが1作業単位になっているか
- コミットの粒度（差分が大きすぎないか）

### Step 2: ブランチ運用の確認

```bash
git branch -a
```

確認観点:
- feature ブランチが使われているか
- main/master への直接 push のみでないか

### Step 3: Issue 一覧の取得

```bash
gh issue list --state all --limit 20
```

**gh CLI が使えない場合**: 「gh CLI 未使用のため G2, G4 は制約付き評価」と明記し、Git ログやファイルから推測できる範囲で評価する。

確認観点:
- Issue でタスク管理が行われているか
- ラベル・マイルストーンの活用
- バグ Issue の有無と記載品質

### Step 4: PR 一覧・詳細の取得

```bash
gh pr list --state all --limit 20
```

PR が存在する場合、代表的な PR を 1-2 件選び詳細を確認:

```bash
gh pr view <PR番号>
```

確認観点:
- PR の description に変更理由・内容が記載されているか
- レビューコメントの有無
- Issue リンク（Closes #xxx）の有無
- 修正方針の明文化

### Step 5: PR テンプレートの確認

```bash
ls -la .github/pull_request_template.md 2>/dev/null
ls -la .github/PULL_REQUEST_TEMPLATE/ 2>/dev/null
```

### Step 6: ブランチ命名パターン分析

```bash
git branch -a
```

確認観点:
- ブランチ命名にプレフィックス（`feature/`, `fix/`, `hotfix/`, `release/` 等）が一貫して使われているか
- ブランチ戦略（Git Flow, GitHub Flow 等）が読み取れるか
- ドキュメント（README, CONTRIBUTING.md 等）にブランチ戦略の記載があるか

```bash
# ブランチ戦略ドキュメントの検索
grep -rli 'branch\|ブランチ' README.md CONTRIBUTING.md docs/ 2>/dev/null
```

## 自己検証チェックリスト

出力前に以下を確認すること:

- [ ] G1〜G6 の全6項目に判定（[OK]/[WARN]/[NG]）を付与したか
- [ ] 全ての判定に確信度（HIGH/MEDIUM/LOW）を付与したか
- [ ] 全ての [OK] 判定に具体的証拠（コミットハッシュ、PR番号、コマンド出力）があるか
- [ ] gh CLI が使えなかった場合、該当項目に制約を明記し確信度を LOW にしたか
- [ ] 推測で [OK] を付けていないか

## 出力フォーマット

```markdown
# Git・開発プロセス評価結果

## サマリー

| ID | 項目 | 判定 | 確信度 | 証拠 |
|----|------|------|--------|------|
| G1 | コミット粒度・メッセージ | [OK]/[WARN]/[NG] | HIGH/MED/LOW | （証拠の要約） |
| G2 | タスク・Issue管理 | [OK]/[WARN]/[NG] | HIGH/MED/LOW | （証拠の要約） |
| G3 | PRレビュー・マージ判断 | [OK]/[WARN]/[NG] | HIGH/MED/LOW | （証拠の要約） |
| G4 | バグ分析・特定 | [OK]/[WARN]/[NG] | HIGH/MED/LOW | （証拠の要約） |
| G5 | 修正方針の導出 | [OK]/[WARN]/[NG] | HIGH/MED/LOW | （証拠の要約） |
| G6 | ブランチ戦略 | [OK]/[WARN]/[NG] | HIGH/MED/LOW | （証拠の要約） |

## 制約事項

（gh CLI が使えなかった場合など、評価の制約を明記）
```
