#!/bin/bash
set -e

# カラー出力
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# このリポジトリのパス
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
SOURCE_BASE="$REPO_DIR/.claude"

echo "================================================"
echo "  ms-e-claude-code-grader セットアップ"
echo "================================================"
echo ""

# Claude Code インストール確認
if ! command -v claude &> /dev/null; then
    echo -e "${RED}✗ Claude Code が見つかりません${NC}"
    echo "  先に Claude Code をインストールしてください："
    echo "  https://docs.anthropic.com/en/docs/claude-code"
    exit 1
fi

echo -e "${GREEN}✓ Claude Code インストール確認${NC}"
echo ""

# ディレクトリ構造を作成
echo "ディレクトリ構造を作成中..."
while IFS= read -r -d '' dir; do
    # .claude/ からの相対パスを取得
    rel_path="${dir#$SOURCE_BASE/}"
    target_dir="$CLAUDE_DIR/$rel_path"

    # ディレクトリが存在しない、またはシンボリックリンクの場合は作成
    if [ ! -e "$target_dir" ]; then
        mkdir -p "$target_dir"
    elif [ -L "$target_dir" ]; then
        # 既存のディレクトリ単位のシンボリックリンクを削除して実体化
        rm "$target_dir"
        mkdir -p "$target_dir"
        echo -e "${YELLOW}⚠${NC} ディレクトリ単位のリンクを解除: ~/.claude/$rel_path"
    fi
done < <(find "$SOURCE_BASE" -type d -print0)

echo -e "${GREEN}✓${NC} ディレクトリ構造を作成しました"
echo ""

# ファイル単位でシンボリックリンクを作成
echo "ファイルをリンク中..."
LINKED_COUNT=0
SKIPPED_COUNT=0
UPDATED_COUNT=0

while IFS= read -r -d '' source_file; do
    # .claude/ からの相対パスを取得
    rel_path="${source_file#$SOURCE_BASE/}"
    target_file="$CLAUDE_DIR/$rel_path"

    # ターゲットが存在しない → 新規リンク作成
    if [ ! -e "$target_file" ]; then
        ln -s "$source_file" "$target_file"
        echo -e "${GREEN}✓${NC} リンク作成: ~/.claude/$rel_path"
        LINKED_COUNT=$((LINKED_COUNT + 1))

    # ターゲットがシンボリックリンク → 更新
    elif [ -L "$target_file" ]; then
        rm "$target_file"
        ln -s "$source_file" "$target_file"
        echo -e "${BLUE}↻${NC} リンク更新: ~/.claude/$rel_path"
        UPDATED_COUNT=$((UPDATED_COUNT + 1))

    # ターゲットが実ファイル → スキップ（個人用ファイルとして保持）
    else
        echo -e "${YELLOW}⊘${NC} スキップ（既存ファイル保持）: ~/.claude/$rel_path"
        SKIPPED_COUNT=$((SKIPPED_COUNT + 1))
    fi
done < <(find "$SOURCE_BASE" -type f -print0)

echo ""
echo "================================================"
echo -e "${GREEN}✓ セットアップ完了！${NC}"
echo "================================================"
echo ""
echo "【結果】"
echo "  新規リンク: ${LINKED_COUNT} 件"
echo "  更新: ${UPDATED_COUNT} 件"
if [ $SKIPPED_COUNT -gt 0 ]; then
    echo "  スキップ（既存ファイル）: ${SKIPPED_COUNT} 件"
fi
echo ""
echo "【次のステップ】"
echo "1. 採点対象のリポジトリを Claude Code で開く"
echo "2. スラッシュコマンドを実行"
echo ""
echo "   例: /grade           # ルーブリック採点"
echo "   例: /review-s3       # Section 3 レビュー"
echo ""
echo "【更新方法】"
echo "  このリポジトリで 'git pull' → './setup.sh' で最新版が反映されます"
echo ""
echo "【個人用ファイルとの共存】"
echo "  既存のファイルはそのまま保持されます"
echo "  このツールのファイルはシンボリックリンクとして追加されます"
echo ""
