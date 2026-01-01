@echo off
chcp 65001 >nul
echo.
echo ========================================
echo 小学科学四年级 - 高级 EXE 打包工具
echo （包含所有文件的单一EXE）
echo ========================================
echo.

REM 检查Python
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ 错误: 未检测到 Python
    pause
    exit /b 1
)

echo ✅ Python 已安装
echo.

REM 安装PyInstaller
python -c "import PyInstaller" >nul 2>&1
if errorlevel 1 (
    echo 📦 正在安装 PyInstaller...
    python -m pip install pyinstaller
)

echo.
echo 🔨 开始打包（这可能需要几分钟）...
echo.

REM 清理
if exist "build" rmdir /s /q build
if exist "dist" rmdir /s /q dist
if exist "*.spec" del /q *.spec

REM 高级打包 - 将所有HTML文件打包进EXE
pyinstaller --onefile ^
    --noconsole ^
    --name "小学科学四年级" ^
    --add-data "index.html;." ^
    --add-data "小学科学四上：科学大闯关总站.html;." ^
    --add-data "第一单元*.html;." ^
    --add-data "第二单元*.html;." ^
    --add-data "第三单元*.html;." ^
    --add-data "小学科学四上*.html;." ^
    launcher.py

if errorlevel 1 (
    echo ❌ 打包失败
    pause
    exit /b 1
)

echo.
echo ✅ 打包成功！
echo.
echo 📁 位置: dist\小学科学四年级.exe
echo 📦 大小: 约 5-10 MB（包含所有课程）
echo.
echo 💡 这个 EXE 文件可以独立运行，无需其他文件
echo.

pause
