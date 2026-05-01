#!/bin/bash
# 天元鼎.skills — 一键推送到 GitHub 公开仓库
# 用法: bash push_to_github.sh

set -e

REPO_NAME="tianyuanding-skills"
GITHUB_USER="duanyu119"
REMOTE_URL="https://github.com/${GITHUB_USER}/${REPO_NAME}.git"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "============================================================"
echo "  天元鼎.skills → GitHub 公开仓库推送"
echo "============================================================"
echo ""
echo "本地目录: $SCRIPT_DIR"
echo "远端仓库: $REMOTE_URL"
echo ""

# Step 1: 检查是否已经是 git 仓库
if [ ! -d "$SCRIPT_DIR/.git" ]; then
    echo "▶ Step 1: 初始化 git 仓库"
    cd "$SCRIPT_DIR"
    git init
    git branch -M main
else
    echo "▶ Step 1: git 仓库已���在，跳过 init"
    cd "$SCRIPT_DIR"
fi

# Step 2: 配置 remote
if git remote get-url origin &>/dev/null; then
    CURRENT_REMOTE=$(git remote get-url origin)
    if [ "$CURRENT_REMOTE" != "$REMOTE_URL" ]; then
        echo "▶ Step 2: 更新 remote origin → $REMOTE_URL"
        git remote set-url origin "$REMOTE_URL"
    else
        echo "▶ Step 2: remote 已正确配置"
    fi
else
    echo "▶ Step 2: 添加 remote origin → $REMOTE_URL"
    git remote add origin "$REMOTE_URL"
fi

# Step 3: 添加所有文件
echo "▶ Step 3: git add -A"
git add -A

# Step 4: Commit
echo "▶ Step 4: commit"
if git diff --cached --quiet 2>/dev/null; then
    echo "  无新变更，跳过 commit"
else
    git commit -m "init: 天元鼎.skills — AI 私人知识系统框架"
fi

# Step 5: Push
echo "▶ Step 5: push to origin/main"
echo ""
echo "  如果卡住超过 60 秒，可能是网络问题（中国→GitHub 偶尔超时）"
echo "  Ctrl+C 中断后重跑即可"
echo ""

git push -u origin main

echo ""
echo "============================================================"
echo "  ✅ 推送成功！"
echo "  🔗 https://github.com/${GITHUB_USER}/${REPO_NAME}"
echo "============================================================"
echo ""
echo "下一步："
echo "  1. 打开上面的链接，确认文件都在"
echo "  2. 在 GitHub 仓库 Settings 确认是 Public"
echo "  3. 可选：添加 Topics 标签（ai, knowledge-management, claude, personal-knowledge-base）"
