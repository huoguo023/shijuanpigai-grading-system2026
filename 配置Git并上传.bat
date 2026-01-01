@echo off
chcp 65001 >nul
title 配置 Git 并上传到 GitHub
color 0B

echo.
echo ╔════════════════════════════════════════════════════╗
echo ║                                                    ║
echo ║        🔧 配置 Git 并上传到 GitHub                 ║
echo ║                                                    ║
echo ╚════════════════════════════════════════════════════╝
echo.

REM 检查 Git 是否安装
git --version >nul 2>&1
if errorlevel 1 (
    color 0C
    echo ❌ 错误: 未检测到 Git
    echo.
    echo 请先安装 Git:
    echo https://git-scm.com/downloads
    echo.
    pause
    exit /b 1
)

echo ✅ Git 已安装
echo.

REM 检查 Git 配置
echo [1/5] 检查 Git 配置...
echo.

for /f "delims=" %%i in ('git config user.name 2^>nul') do set git_name=%%i
for /f "delims=" %%i in ('git config user.email 2^>nul') do set git_email=%%i

if "%git_name%"=="" (
    echo ⚠️  Git 用户名未配置
    echo.
    set /p git_name="请输入您的名字 (如: Zhang San): "
    git config --global user.name "!git_name!"
    echo ✅ 用户名已设置: !git_name!
) else (
    echo ✅ Git 用户名: %git_name%
)

echo.

if "%git_email%"=="" (
    echo ⚠️  Git 邮箱未配置
    echo.
    set /p git_email="请输入您的邮箱 (如: zhangsan@example.com): "
    git config --global user.email "!git_email!"
    echo ✅ 邮箱已设置: !git_email!
) else (
    echo ✅ Git 邮箱: %git_email%
)

echo.
echo ════════════════════════════════════════════════════
echo [2/5] 提交所有文件...
echo ════════════════════════════════════════════════════
echo.

REM 添加所有文件
git add -A

REM 提交
git commit -m "Initial commit: 小学科学四年级上册互动学习网站

功能特性:
- 24个课程(3个单元)
- 100+ 精美SVG动画
- 800+ 测试题
- 即时反馈系统
- 闯关塔模式

技术栈:
- HTML5 + CSS3 + JavaScript
- SVG 动画
- 响应式设计

工具:
- BAT 启动器
- Python 打包脚本
- GitHub 上传脚本"

if errorlevel 1 (
    echo.
    echo ℹ️  可能没有新的更改需要提交
) else (
    echo ✅ 文件已提交
)

echo.
echo ════════════════════════════════════════════════════
echo [3/5] 配置远程仓库...
echo ════════════════════════════════════════════════════
echo.

REM 检查是否已配置远程仓库
git remote get-url origin >nul 2>&1
if errorlevel 1 (
    echo ⚠️  尚未配置远程仓库
    echo.
    echo 请先在 GitHub 创建仓库:
    echo 1. 访问: https://github.com/new
    echo 2. 填写仓库名称 (如: elementary-science-grade4)
    echo 3. 选择 Public 或 Private
    echo 4. 不要勾选 "Initialize with README"
    echo 5. 点击 "Create repository"
    echo 6. 复制仓库地址
    echo.
    echo 示例: https://github.com/YOUR_USERNAME/YOUR_REPO.git
    echo.
    set /p repo_url="请输入 GitHub 仓库地址: "
    
    if "!repo_url!"=="" (
        color 0C
        echo.
        echo ❌ 未输入仓库地址
        pause
        exit /b 1
    )
    
    echo.
    echo 正在添加远程仓库...
    git remote add origin !repo_url!
    
    if errorlevel 1 (
        color 0C
        echo ❌ 添加远程仓库失败
        pause
        exit /b 1
    )
    
    echo ✅ 远程仓库已添加
) else (
    for /f "delims=" %%i in ('git remote get-url origin') do set current_repo=%%i
    echo ✅ 远程仓库: !current_repo!
)

echo.
echo ════════════════════════════════════════════════════
echo [4/5] 推送到 GitHub...
echo ════════════════════════════════════════════════════
echo.

REM 确保在 main 分支
git branch -M main

echo 正在推送文件到 GitHub...
echo.
echo ⏳ 这可能需要几分钟，请耐心等待...
echo.

REM 推送到 GitHub
git push -u origin main

if errorlevel 1 (
    color 0E
    echo.
    echo ⚠️  推送失败
    echo.
    echo 可能的原因:
    echo   • 需要登录 GitHub
    echo   • 权限不足
    echo   • 网络问题
    echo.
    echo 💡 解决方案:
    echo.
    echo   方法1: 使用 Personal Access Token
    echo     1. 访问: https://github.com/settings/tokens
    echo     2. Generate new token (classic)
    echo     3. 选择 repo 权限
    echo     4. 复制 token
    echo     5. 重新运行此脚本
    echo     6. 推送时使用 token 作为密码
    echo.
    echo   方法2: 使用 GitHub Desktop
    echo     1. 下载: https://desktop.github.com/
    echo     2. 登录 GitHub 账号
    echo     3. 添加本地仓库
    echo     4. 点击 Publish
    echo.
    pause
    exit /b 1
)

echo.
echo ════════════════════════════════════════════════════
echo [5/5] 验证上传...
echo ════════════════════════════════════════════════════
echo.

REM 获取远程仓库地址
for /f "delims=" %%i in ('git remote get-url origin') do set repo_url=%%i

REM 转换为网页地址
set web_url=%repo_url%
set web_url=%web_url:git@github.com:=https://github.com/%
set web_url=%web_url:.git=%

color 0A
echo.
echo ╔════════════════════════════════════════════════════╗
echo ║   ✅ 上传成功！                                    ║
echo ╚════════════════════════════════════════════════════╝
echo.
echo 🎉 恭喜！您的项目已成功上传到 GitHub！
echo.
echo 📦 仓库地址:
echo    %web_url%
echo.
echo 💡 下一步:
echo   1. 访问仓库查看文件
echo   2. 启用 GitHub Pages (Settings → Pages)
echo   3. 添加仓库描述和标签
echo   4. 分享给其他人
echo.
echo 🌐 启用 GitHub Pages 后可访问:
echo    %web_url:github.com=%YOUR_USERNAME%.github.io%
echo    (将 YOUR_USERNAME 替换为您的用户名)
echo.

set /p open_browser="是否在浏览器中打开仓库? (Y/N): "
if /i "%open_browser%"=="Y" (
    start "" "%web_url%"
)

echo.
echo ════════════════════════════════════════════════════
echo.
echo 📚 相关文档:
echo   • GitHub上传步骤.md - 详细教程
echo   • 如何上传到GitHub.txt - 快速指南
echo   • README.md - 项目说明
echo.
pause
