@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title 上传到 GitHub
color 0B

echo.
echo ╔════════════════════════════════════════════════════╗
echo ║                                                    ║
echo ║        📤 上传到 GitHub                            ║
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

REM 检查是否已配置远程仓库
git remote get-url origin >nul 2>&1
if errorlevel 1 (
    echo ⚠️  尚未配置远程仓库
    echo.
    echo 请先在 GitHub 创建仓库，然后输入仓库地址
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
echo.

REM 显示当前状态
echo 📊 当前状态:
echo.
git status --short
echo.

REM 询问是否继续
set /p confirm="确认上传到 GitHub? (Y/N): "
if /i not "%confirm%"=="Y" (
    echo.
    echo 已取消
    pause
    exit /b 0
)

echo.
echo ════════════════════════════════════════════════════
echo [1/4] 添加文件...
echo ════════════════════════════════════════════════════
echo.

REM 添加所有文件
git add .

if errorlevel 1 (
    color 0C
    echo ❌ 添加文件失败
    pause
    exit /b 1
)

echo ✅ 文件已添加

echo.
echo ════════════════════════════════════════════════════
echo [2/4] 提交更改...
echo ════════════════════════════════════════════════════
echo.

REM 检查是否有更改需要提交
git diff --cached --quiet
if not errorlevel 1 (
    echo ℹ️  没有新的更改需要提交
    
    REM 检查是否有未推送的提交
    git log origin/main..HEAD >nul 2>&1
    if errorlevel 1 (
        echo.
        echo 准备首次推送...
        goto PUSH
    )
    
    for /f %%i in ('git rev-list --count origin/main..HEAD 2^>nul') do set unpushed=%%i
    if "!unpushed!"=="0" (
        echo ✅ 所有更改已同步
        echo.
        pause
        exit /b 0
    )
    
    echo.
    echo 有 !unpushed! 个提交尚未推送
    goto PUSH
)

REM 提交更改
git commit -m "Update: 更新小学科学四年级学习网站

- 文件重命名为英文
- 修复打包脚本
- 更新文档
- 优化代码"

if errorlevel 1 (
    color 0C
    echo ❌ 提交失败
    pause
    exit /b 1
)

echo ✅ 更改已提交

:PUSH
echo.
echo ════════════════════════════════════════════════════
echo [3/4] 推送到 GitHub...
echo ════════════════════════════════════════════════════
echo.

REM 确保在 main 分支
git branch -M main

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
    echo   • 远程仓库不存在
    echo.
    echo 💡 解决方案:
    echo   1. 检查 GitHub 账号是否已登录
    echo   2. 使用 Personal Access Token
    echo   3. 配置 SSH 密钥
    echo   4. 查看详细说明: GitHub上传步骤.md
    echo.
    pause
    exit /b 1
)

echo.
echo ════════════════════════════════════════════════════
echo [4/4] 验证上传...
echo ════════════════════════════════════════════════════
echo.

REM 获取远程仓库地址
for /f "delims=" %%i in ('git remote get-url origin') do set repo_url=%%i

REM 转换为网页地址
set web_url=!repo_url!
set web_url=!web_url:git@github.com:=https://github.com/!
set web_url=!web_url:.git=!

color 0A
echo.
echo ╔════════════════════════════════════════════════════╗
echo ║   ✅ 上传成功！                                    ║
echo ╚════════════════════════════════════════════════════╝
echo.
echo 📦 仓库地址:
echo    !web_url!
echo.
echo 🌐 GitHub Pages (如果已启用):
echo    !web_url:github.com=!YOUR_USERNAME!.github.io!
echo.
echo 💡 下一步:
echo   1. 访问仓库查看文件
echo   2. 启用 GitHub Pages (Settings → Pages)
echo   3. 添加仓库描述和标签
echo   4. 邀请协作者
echo.

set /p open_browser="是否在浏览器中打开仓库? (Y/N): "
if /i "%open_browser%"=="Y" (
    start "" "!web_url!"
)

echo.
echo ════════════════════════════════════════════════════
echo.
pause
