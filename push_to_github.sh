#!/bin/bash
# 天元鼎.skills — 一键推送到 GitHub 公开仓库（PAT 认证）
# 用法: bash push_to_github.sh

set -e

REPO_NAME="tianyuanding-skills"
GITHUB_USER="duanyu119"
PAT_FILE="$HOME/Library/Mobile Documents/com~apple~CloudDocs/Documents/Claude_Brain/github_pat0501.md"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "============================================================"
echo "  天元鼎.skills → GitHub 公开仓库推送"
echo "============================================================"
echo ""

# Step 0: 读取 PAT
if [ ! -f "$PAT_FILE" ]; then
    echo "❌ 找不到 PAT 文件: $PAT_FILE"
    exit 1
fi
PAT=$(cat "$PAT_FILE" | tr -d '[:space:]')
REMOTE_URL="https://${GITHUB_USER}:${PAT}@github.com/${GITHUB_USER}/${REPO_NAME}.git"

echo "本地目录: $SCRIPT_DIR"
echo "远端仓库: github.com/${GITHUB_USER}/${REPO_NAME}"
echo ""

# Step 1: 检查是否已经是 git 仓库
if [ ! -d "$SCRIPT_DIR/.git" ]; then
    echo "▶ Step 1: 初始化 git 仓库"
    cd "$SCRIPT_DIR"
    git init
    git branch -M main
else
    echo "▶ Step 1: git 仓库已存在，跳过 init"
    cd "$SCRIPT_DIR"
fi

# Step 2: 配置 remote（用带 PAT 的 URL）
if git remote get-url origin &>/dev/null; then
    echo "▶ Step 2: 更新 remote origin"
    git remote set-url origin "$REMOTE_URL"
else
    echo "▶ Step 2: 添加 remote origin"
    git remote add origin "$REMOTE_URL"
fi

# Step 3: 确保 push_to_github.sh 自身不被提交（含凭证逻辑）
if [ ! -f "$SCRIPT_DIR/.gitignore" ]; then
    echo "push_to_github.sh" > "$SCRIPT_DIR/.gitignore"
elif ! grep -q "push_to_github.sh" "$SCRIPT_DIR/.gitignore"; then
    echo "push_to_github.sh" >> "$SCRIPT_DIR/.gitignore"
fi

# Step 4: 添加所有文件
echo "▶ Step 3: git add -A"
git add -A

# Step 5: Commit
echo "▶ Step 4: commit"
if git diff --cached --quiet 2>/dev/null; then
    echo "  无新变更，跳过 commit"
else
    git commit -m "init: 天元鼎.skills — AI 私人知识系统框架"
fi

# Step 6: Push
echo "▶ Step 5: push to origin/main"
echo ""
echo "  如果卡住超过 60 秒，可能是网络问题（中国→GitHub 偶尔超时）"
echo "  Ctrl+C 中断后重跑即可"
echo ""

git push -u origin main

# Step 7: 推送后清除 remote 中的 PAT（安全措施）
echo "▶ Step 6: 清除 remote 中的凭证"
git remote set-url origin "https://github.com/${GITHUB_USER}/${REPO_NAME}.git"

echo ""
echo "============================================================"
echo "  ✅ 推送成功！"
echo "  🔗 https://github.com/${GITHUB_USER}/${REPO_NAME}"
echo "============================================================"
