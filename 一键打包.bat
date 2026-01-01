@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title 小学科学四年级 - 智能打包工具
color 0B

echo.
echo ╔════════════════════════════════════════════════════╗
echo ║                                                    ║
echo ║        🎓 小学科学四年级 - 智能打包工具           ║
echo ║                                                    ║
echo ╚════════════════════════════════════════════════════╝
echo.

REM ============================================
REM 步骤1: 检测 Python
REM ============================================
echo [1/5] 检测 Python...
echo.

python --version >nul 2>&1
if errorlevel 1 (
    color 0C
    echo ❌ 错误: 未检测到 Python
    echo.
    echo 💡 解决方案:
    echo    1. 安装 Python 3.11 或 3.12（推荐）
    echo       下载: https://www.python.org/downloads/
    echo.
    echo    2. 或者使用 BAT 启动器（无需 Python）
    echo       双击: 启动网站-高级版.bat
    echo.
    pause
    exit /b 1
)

REM 获取 Python 版本
for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo ✅ 检测到 Python %PYTHON_VERSION%
echo.

REM 检查版本兼容性
echo %PYTHON_VERSION% | findstr /r "3\.1[45]" >nul
if not errorlevel 1 (
    color 0E
    echo ⚠️  警告: Python %PYTHON_VERSION% 可能不兼容 PyInstaller
    echo.
    echo 💡 推荐方案:
    echo    1. 使用 BAT 启动器（最简单）
    echo       双击: 启动网站-高级版.bat
    echo.
    echo    2. 降级到 Python 3.11 或 3.12
    echo       查看: Python3.15兼容性说明.md
    echo.
    set /p continue="是否继续尝试打包? (Y/N): "
    if /i not "!continue!"=="Y" (
        echo.
        echo 已取消打包
        pause
        exit /b 0
    )
    color 0B
)

REM ============================================
REM 步骤2: 安装 PyInstaller
REM ============================================
echo.
echo [2/5] 检查 PyInstaller...
echo.

python -c "import PyInstaller" >nul 2>&1
if errorlevel 1 (
    echo 📦 正在安装 PyInstaller...
    echo.
    
    REM 尝试使用 python -m pip
    python -m pip install pyinstaller >nul 2>&1
    
    if errorlevel 1 (
        color 0C
        echo ❌ PyInstaller 安装失败
        echo.
        echo 可能的原因:
        echo   • Python 版本不兼容
        echo   • 网络连接问题
        echo   • 权限不足
        echo.
        echo 💡 建议:
        echo    使用 BAT 启动器代替（无需打包）
        echo    双击: 启动网站-高级版.bat
        echo.
        pause
        exit /b 1
    )
    
    echo ✅ PyInstaller 安装成功
) else (
    echo ✅ PyInstaller 已安装
)

REM 验证 PyInstaller
python -m PyInstaller --version >nul 2>&1
if errorlevel 1 (
    color 0C
    echo ❌ PyInstaller 无法运行
    echo.
    echo 💡 建议: 使用 BAT 启动器
    echo    双击: 启动网站-高级版.bat
    echo.
    pause
    exit /b 1
)

REM ============================================
REM 步骤3: 选择打包方式
REM ============================================
echo.
echo [3/5] 选择打包方式...
echo.
echo  ┌────────────────────────────────────────────────┐
echo  │  [1] 简单打包（EXE + HTML 文件）              │
echo  │      • 文件小（约 5-10 MB）                   │
echo  │      • 需要 HTML 文件                         │
echo  │      • 推荐日常使用                           │
echo  │                                                │
echo  │  [2] 完整打包（单一 EXE，包含所有文件）       │
echo  │      • 文件大（约 20-50 MB）                  │
echo  │      • 独立运行                               │
echo  │      • 推荐正式发布                           │
echo  └────────────────────────────────────────────────┘
echo.
set /p pack_type="请选择 (1 或 2): "

if "%pack_type%"=="1" goto SIMPLE_PACK
if "%pack_type%"=="2" goto FULL_PACK

echo.
echo ❌ 无效选项
pause
exit /b 1

REM ============================================
REM 简单打包
REM ============================================
:SIMPLE_PACK
echo.
echo [4/5] 开始简单打包...
echo.

REM 清理旧文件
if exist "build" rmdir /s /q build >nul 2>&1
if exist "dist" rmdir /s /q dist >nul 2>&1
if exist "*.spec" del /q *.spec >nul 2>&1

echo 🔨 正在打包（约 1-2 分钟）...
echo.

python -m PyInstaller --onefile --windowed --name "小学科学四年级" launcher.py

if errorlevel 1 goto PACK_FAILED

goto PACK_SUCCESS

REM ============================================
REM 完整打包
REM ============================================
:FULL_PACK
echo.
echo [4/5] 开始完整打包...
echo.

REM 清理旧文件
if exist "build" rmdir /s /q build >nul 2>&1
if exist "dist" rmdir /s /q dist >nul 2>&1
if exist "*.spec" del /q *.spec >nul 2>&1

echo 🔨 正在打包（约 3-5 分钟）...
echo.
echo ⏳ 正在收集所有 HTML 文件...
echo.

REM 创建临时文件列表
set "DATA_FILES="
for %%f in (*.html) do (
    set "DATA_FILES=!DATA_FILES! --add-data "%%f;.""
)

REM 打包
python -m PyInstaller --onefile --windowed --name "小学科学四年级" !DATA_FILES! launcher.py

if errorlevel 1 goto PACK_FAILED

goto PACK_SUCCESS

REM ============================================
REM 打包失败
REM ============================================
:PACK_FAILED
color 0C
echo.
echo ╔════════════════════════════════════════════════════╗
echo ║   ❌ 打包失败                                      ║
echo ╚════════════════════════════════════════════════════╝
echo.
echo 可能的原因:
echo   • Python 版本不兼容（3.14/3.15）
echo   • PyInstaller 版本问题
echo   • 文件路径包含特殊字符
echo   • 权限不足
echo.
echo 💡 推荐解决方案:
echo.
echo   [方案1] 使用 BAT 启动器（⭐ 强烈推荐）
echo           • 无需打包
echo           • 功能完整
echo           • 100%% 可靠
echo           双击: 启动网站-高级版.bat
echo.
echo   [方案2] 降级 Python
echo           • 安装 Python 3.11 或 3.12
echo           • 查看: Python3.15兼容性说明.md
echo.
echo   [方案3] 尝试修复
echo           • 运行: 修复打包问题.bat
echo.
pause
exit /b 1

REM ============================================
REM 打包成功
REM ============================================
:PACK_SUCCESS
color 0A
echo.
echo ╔════════════════════════════════════════════════════╗
echo ║   ✅ 打包成功！                                    ║
echo ╚════════════════════════════════════════════════════╝
echo.

REM 获取文件大小
for %%f in ("dist\小学科学四年级.exe") do set FILE_SIZE=%%~zf
set /a FILE_SIZE_MB=!FILE_SIZE! / 1048576

echo [5/5] 打包完成
echo.
echo 📁 文件位置: dist\小学科学四年级.exe
echo 📦 文件大小: 约 !FILE_SIZE_MB! MB
echo.

if "%pack_type%"=="1" (
    echo 📋 使用说明:
    echo   1. 将 dist\小学科学四年级.exe 复制出来
    echo   2. 将所有 HTML 文件放在 EXE 同一目录
    echo   3. 双击 EXE 文件启动
    echo.
    echo 📦 分发方法:
    echo   • 将 EXE 和所有 HTML 文件打包成 ZIP
    echo   • 分享给其他人
    echo   • 解压后双击 EXE 即可使用
) else (
    echo 📋 使用说明:
    echo   1. 将 dist\小学科学四年级.exe 复制出来
    echo   2. 双击 EXE 文件即可启动（无需其他文件）
    echo.
    echo 📦 分发方法:
    echo   • 直接分享这个 EXE 文件
    echo   • 或创建安装程序
)

echo.
echo ════════════════════════════════════════════════════
echo.

set /p open_folder="是否打开 dist 文件夹? (Y/N): "
if /i "%open_folder%"=="Y" (
    explorer dist
)

echo.
echo 💡 提示:
echo   • 首次运行可能需要几秒钟
echo   • 杀毒软件可能会误报，添加到白名单即可
echo   • 可以使用 Inno Setup 创建安装程序
echo.
pause
exit /b 0
