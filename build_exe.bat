@echo off
chcp 65001 >nul
echo.
echo ========================================
echo 小学科学四年级 - EXE 打包工具
echo ========================================
echo.

REM 检查Python是否安装
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ 错误: 未检测到 Python
    echo.
    echo 请先安装 Python 3.7 或更高版本
    echo 下载地址: https://www.python.org/downloads/
    echo.
    pause
    exit /b 1
)

echo ✅ Python 已安装
echo.

REM 检查PyInstaller是否安装
python -c "import PyInstaller" >nul 2>&1
if errorlevel 1 (
    echo 📦 正在安装 PyInstaller...
    python -m pip install pyinstaller
    if errorlevel 1 (
        echo ❌ PyInstaller 安装失败
        pause
        exit /b 1
    )
    echo ✅ PyInstaller 安装成功
) else (
    echo ✅ PyInstaller 已安装
)
echo.

REM 清理旧的构建文件
if exist "build" (
    echo 🧹 清理旧的构建文件...
    rmdir /s /q build
)
if exist "dist" (
    rmdir /s /q dist
)
if exist "*.spec" (
    del /q *.spec
)

echo.
echo 🔨 开始打包 EXE...
echo.

REM 打包命令
pyinstaller --onefile ^
    --windowed ^
    --name "小学科学四年级学习网站" ^
    --icon=NONE ^
    --add-data "*.html;." ^
    --add-data "小学科学四上：科学大闯关总站_files;小学科学四上：科学大闯关总站_files" ^
    --hidden-import=http.server ^
    --hidden-import=socketserver ^
    --hidden-import=webbrowser ^
    launcher.py

if errorlevel 1 (
    echo.
    echo ❌ 打包失败
    pause
    exit /b 1
)

echo.
echo ========================================
echo ✅ 打包成功！
echo ========================================
echo.
echo 📁 EXE 文件位置: dist\小学科学四年级学习网站.exe
echo.
echo 📋 使用说明:
echo 1. 将 dist 文件夹中的 EXE 文件复制出来
echo 2. 将所有 HTML 文件放在 EXE 同一目录
echo 3. 双击 EXE 文件即可启动
echo.
echo 💡 提示: 
echo - 首次运行可能需要几秒钟
echo - 关闭控制台窗口将停止服务器
echo - 可以分享给其他人使用（无需安装Python）
echo.

REM 询问是否打开文件夹
set /p open_folder="是否打开 dist 文件夹? (Y/N): "
if /i "%open_folder%"=="Y" (
    explorer dist
)

echo.
pause
