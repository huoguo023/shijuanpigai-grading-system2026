@echo off
chcp 65001 >nul
title 修复 PyInstaller 兼容性问题
color 0E

echo.
echo ╔════════════════════════════════════════════════════╗
echo ║   🔧 PyInstaller 兼容性修复工具                   ║
echo ╚════════════════════════════════════════════════════╝
echo.

REM 检测 Python 版本
echo [1/4] 检测 Python 版本...
python --version 2>nul
if errorlevel 1 (
    color 0C
    echo.
    echo ❌ 错误: 未检测到 Python
    echo.
    echo 请先安装 Python 3.11 或 3.12
    echo 下载地址: https://www.python.org/downloads/
    echo.
    pause
    exit /b 1
)

echo.
echo ⚠️  Python 3.15 不兼容 PyInstaller
echo.
echo 📋 解决方案:
echo.
echo   [推荐] 方案1: 使用 BAT 启动器（无需 Python 打包）
echo          • 双击 "启动网站.bat" 即可使用
echo          • 无需打包，立即可用
echo          • 文件小巧，易于分享
echo.
echo   [备选] 方案2: 安装 Python 3.11 或 3.12
echo          • 卸载 Python 3.15
echo          • 安装 Python 3.11: https://www.python.org/downloads/release/python-3119/
echo          • 安装 Python 3.12: https://www.python.org/downloads/release/python-3129/
echo          • 重新运行 build_exe.bat
echo.
echo   [高级] 方案3: 尝试 PyInstaller 开发版（可能不稳定）
echo.
echo ════════════════════════════════════════════════════
echo.

set /p choice="是否尝试方案3（安装开发版）? (Y/N): "

if /i not "%choice%"=="Y" (
    echo.
    echo 💡 建议: 直接使用 "启动网站.bat" 或 "启动网站-高级版.bat"
    echo.
    echo 这两个启动器无需打包，功能完整，使用方便！
    echo.
    pause
    exit /b 0
)

echo.
echo ════════════════════════════════════════════════════
echo [2/4] 卸载旧版 PyInstaller...
echo ════════════════════════════════════════════════════
python -m pip uninstall pyinstaller -y

echo.
echo ════════════════════════════════════════════════════
echo [3/4] 安装 PyInstaller 开发版...
echo ════════════════════════════════════════════════════
echo.
echo ⏳ 这可能需要几分钟，请耐心等待...
echo.

python -m pip install https://github.com/pyinstaller/pyinstaller/archive/develop.zip

if errorlevel 1 (
    color 0C
    echo.
    echo ╔════════════════════════════════════════════════════╗
    echo ║   ❌ 安装失败                                      ║
    echo ╚════════════════════════════════════════════════════╝
    echo.
    echo 可能的原因:
    echo   • Python 3.15 太新，PyInstaller 尚未完全支持
    echo   • 网络连接问题
    echo   • 缺少编译工具
    echo.
    echo 💡 强烈建议:
    echo   1. 使用 "启动网站.bat" 或 "启动网站-高级版.bat"
    echo      这是最简单、最可靠的方案！
    echo.
    echo   2. 或者安装 Python 3.11/3.12 后重试
    echo.
    pause
    exit /b 1
)

echo.
echo ════════════════════════════════════════════════════
echo [4/4] 验证安装...
echo ════════════════════════════════════════════════════
pyinstaller --version

if errorlevel 1 (
    color 0C
    echo.
    echo ❌ PyInstaller 安装失败
    echo.
    echo 💡 建议使用 BAT 启动器代替
    echo.
    pause
    exit /b 1
)

color 0A
echo.
echo ╔════════════════════════════════════════════════════╗
echo ║   ✅ 修复完成！                                    ║
echo ╚════════════════════════════════════════════════════╝
echo.
echo 现在可以运行 build_exe.bat 尝试打包
echo.
echo ⚠️  注意: 开发版可能不稳定，如果打包失败，
echo    请使用 "启动网站.bat" 作为替代方案
echo.
pause
