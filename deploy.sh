#!/bin/bash

# 小学科学四年级网站 - GitHub 部署脚本
# 使用方法: bash deploy.sh

echo "🚀 开始部署到 GitHub..."

# 检查是否已初始化 Git
if [ ! -d ".git" ]; then
    echo "📦 初始化 Git 仓库..."
    git init
    echo "✅ Git 仓库初始化完成"
fi

# 添加所有文件
echo "📝 添加文件到 Git..."
git add .

# 提交
echo "💾 提交更改..."
read -p "请输入提交信息 (默认: Update content): " commit_msg
commit_msg=${commit_msg:-"Update content"}
git commit -m "$commit_msg"

# 检查是否已添加远程仓库
if ! git remote | grep -q "origin"; then
    echo "🔗 请输入 GitHub 仓库地址:"
    read -p "仓库地址 (例如: https://github.com/username/repo.git): " repo_url
    git remote add origin "$repo_url"
    echo "✅ 远程仓库已添加"
fi

# 推送到 GitHub
echo "⬆️  推送到 GitHub..."
git branch -M main
git push -u origin main

echo ""
echo "✨ 部署完成！"
echo ""
echo "📌 下一步操作:"
echo "1. 访问你的 GitHub 仓库"
echo "2. 进入 Settings → Pages"
echo "3. 选择 Source: Deploy from a branch"
echo "4. 选择 Branch: main 和 / (root)"
echo "5. 点击 Save"
echo "6. 等待几分钟后访问你的网站"
echo ""
echo "🌐 你的网站地址将是:"
echo "   https://你的用户名.github.io/仓库名/"
echo ""
