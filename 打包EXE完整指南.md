# 🎁 打包 EXE 完整指南

## 📋 准备工作

### 1. 安装 Python
如果还没有安装 Python：
1. 访问 https://www.python.org/downloads/
2. 下载 Python 3.7 或更高版本
3. 安装时勾选 "Add Python to PATH"
4. 验证安装：
```bash
python --version
```

### 2. 安装 PyInstaller
```bash
pip install pyinstaller
```

## 🚀 三种打包方案

### 方案一：简单打包（推荐）⭐

**特点**：
- EXE 文件小（约 5-10 MB）
- 需要 HTML 文件在同一目录
- 适合经常更新内容

**步骤**：
1. 双击运行 `build_exe.bat`
2. 等待打包完成
3. 在 `dist` 文件夹找到 EXE 文件
4. 将 EXE 和所有 HTML 文件放在一起

**使用方法**：
```
📁 小学科学四年级/
  ├── 小学科学四年级学习网站.exe
  ├── index.html
  ├── 小学科学四上：科学大闯关总站.html
  ├── 第一单元 第1课.听听声音 .html
  ├── 第一单元 第二课：声音是怎样产生的.html
  └── ... (其他所有 HTML 文件)
```

### 方案二：高级打包（单文件）

**特点**：
- 所有文件打包进一个 EXE
- 文件较大（约 20-50 MB）
- 无需其他文件，可独立运行

**步骤**：
1. 双击运行 `build_exe_advanced.bat`
2. 等待打包完成（可能需要几分钟）
3. 在 `dist` 文件夹找到 EXE 文件
4. 这个 EXE 可以独立运行

### 方案三：手动打包（自定义）

#### 基础打包
```bash
pyinstaller --onefile --windowed launcher.py
```

#### 添加图标
```bash
pyinstaller --onefile --windowed --icon=icon.ico launcher.py
```

#### 包含所有HTML文件
```bash
pyinstaller --onefile ^
    --windowed ^
    --name "小学科学四年级" ^
    --add-data "*.html;." ^
    launcher.py
```

#### 无控制台窗口
```bash
pyinstaller --onefile --noconsole launcher.py
```

## 📦 打包参数说明

| 参数 | 说明 |
|------|------|
| `--onefile` | 打包成单个 EXE 文件 |
| `--windowed` | 有控制台窗口（可看到日志） |
| `--noconsole` | 无控制台窗口（后台运行） |
| `--name` | 指定 EXE 文件名 |
| `--icon` | 指定图标文件 |
| `--add-data` | 添加数据文件 |

## 🎨 添加自定义图标

### 1. 准备图标
- 格式：`.ico` 文件
- 尺寸：256x256 或 128x128
- 在线转换：https://convertio.co/zh/png-ico/

### 2. 修改打包命令
在 `build_exe.bat` 中添加：
```batch
--icon=icon.ico ^
```

## 📁 文件结构

### 打包后的目录结构
```
项目文件夹/
├── launcher.py              # Python 启动脚本
├── build_exe.bat           # 打包脚本（简单）
├── build_exe_advanced.bat  # 打包脚本（高级）
├── build/                  # 临时构建文件（可删除）
├── dist/                   # 输出文件夹
│   └── 小学科学四年级学习网站.exe
└── *.spec                  # PyInstaller 配置（可删除）
```

### 分发时的目录结构（方案一）
```
小学科学四年级/
├── 小学科学四年级学习网站.exe
├── index.html
├── 小学科学四上：科学大闯关总站.html
├── 小学科学四上：科学大闯关总站_files/
└── 所有课程 HTML 文件
```

## 🔧 常见问题

### 问题1：打包失败
**错误**：`ModuleNotFoundError: No module named 'PyInstaller'`

**解决**：
```bash
pip install pyinstaller
```

### 问题2：EXE 无法运行
**原因**：杀毒软件误报

**解决**：
1. 添加到杀毒软件白名单
2. 使用 `--noconsole` 参数重新打包
3. 使用代码签名（需要证书）

### 问题3：找不到 HTML 文件
**原因**：HTML 文件不在 EXE 同一目录

**解决**：
- 方案一：确保 HTML 文件和 EXE 在同一文件夹
- 方案二：使用高级打包，将 HTML 打包进 EXE

### 问题4：端口被占用
**错误**：`OSError: [Errno 48] Address already in use`

**解决**：
- 程序会自动尝试其他端口（8080-8089）
- 或修改 `launcher.py` 中的 `PORT` 变量

### 问题5：打包文件太大
**原因**：包含了不必要的库

**解决**：
```bash
# 使用虚拟环境
python -m venv venv
venv\Scripts\activate
pip install pyinstaller
pyinstaller launcher.py
```

## 🎯 优化建议

### 1. 减小文件大小
```bash
# 使用 UPX 压缩
pip install pyinstaller[encryption]
pyinstaller --onefile --upx-dir=upx launcher.py
```

### 2. 加快启动速度
- 使用 `--onedir` 而非 `--onefile`
- 减少打包的文件数量

### 3. 添加启动画面
创建 `splash.py`：
```python
import tkinter as tk
from PIL import Image, ImageTk

def show_splash():
    splash = tk.Tk()
    splash.overrideredirect(True)
    # 添加图片和文字
    splash.after(2000, splash.destroy)
    splash.mainloop()
```

## 📤 分发方式

### 方式一：压缩包
1. 将 EXE 和 HTML 文件打包成 ZIP
2. 上传到网盘（百度网盘、阿里云盘等）
3. 分享下载链接

### 方式二：安装程序
使用 Inno Setup 创建安装程序：
1. 下载 Inno Setup
2. 创建安装脚本
3. 生成 Setup.exe

### 方式三：便携版
1. 创建文件夹
2. 放入 EXE 和所有文件
3. 添加 README.txt 说明
4. 压缩分发

## 📝 使用说明模板

创建 `使用说明.txt`：
```
小学科学四年级学习网站 - 使用说明

【运行方法】
1. 双击 "小学科学四年级学习网站.exe"
2. 等待几秒钟，浏览器会自动打开
3. 开始学习！

【注意事项】
- 首次运行可能需要 5-10 秒
- 关闭控制台窗口将停止程序
- 确保所有 HTML 文件在同一文件夹

【系统要求】
- Windows 7/8/10/11
- 无需安装 Python
- 无需联网（本地运行）

【常见问题】
Q: 杀毒软件报警？
A: 这是误报，请添加到白名单

Q: 无法打开？
A: 右键 → 属性 → 解除锁定

【联系方式】
如有问题，请联系：[你的邮箱]
```

## 🔐 安全建议

### 1. 代码签名
- 购买代码签名证书
- 使用 SignTool 签名
- 避免杀毒软件误报

### 2. 病毒扫描
打包后上传到：
- VirusTotal: https://www.virustotal.com
- 检查是否有误报

### 3. 开源透明
- 提供源代码
- 说明打包过程
- 建立信任

## 📊 性能对比

| 方案 | 文件大小 | 启动速度 | 易用性 | 更新方便 |
|------|---------|---------|--------|---------|
| 方案一（简单） | 5-10 MB | 快 | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| 方案二（高级） | 20-50 MB | 较慢 | ⭐⭐⭐⭐⭐ | ⭐⭐ |
| 在线版（GitHub） | 0 MB | 最快 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |

## 🎓 进阶技巧

### 1. 自动更新
添加版本检查功能：
```python
import requests

def check_update():
    try:
        response = requests.get('https://api.github.com/repos/你的仓库/releases/latest')
        latest_version = response.json()['tag_name']
        # 比较版本号
    except:
        pass
```

### 2. 使用配置文件
创建 `config.ini`：
```ini
[Server]
port = 8080
host = 127.0.0.1

[UI]
theme = light
language = zh-CN
```

### 3. 添加托盘图标
使用 `pystray` 库：
```python
import pystray
from PIL import Image

def create_tray_icon():
    icon = pystray.Icon("name", Image.open("icon.png"))
    icon.run()
```

## 📞 获取帮助

- PyInstaller 文档: https://pyinstaller.org/
- Python 官网: https://www.python.org/
- 提交 Issue: 在项目仓库中

---

**祝你打包顺利！🎉**

如有问题，请查看详细文档或随时询问。
