# 🎁 EXE 打包快速指南

## ⚠️ Python 3.15 用户必读

如果您使用的是 **Python 3.15**，打包时会遇到兼容性问题：

```
ModuleNotFoundError: No module named 'imp'
```

**解决方案**：
1. **推荐**: 使用 BAT 启动器（无需打包）→ 查看下方"方法一"
2. **备选**: 降级到 Python 3.11 或 3.12 → 查看 `Python3.15兼容性说明.md`
3. **尝试**: 运行 `修复打包问题.bat` 安装开发版（可能不稳定）

---

## 🚀 最简单的方法（无需编程）

### 方法一：使用 BAT 启动器（推荐）⭐

**优点**：
- ✅ 无需安装 Python
- ✅ 无需打包
- ✅ 文件小巧
- ✅ 立即可用

**步骤**：
1. 双击 `启动网站.bat`
2. 浏览器自动打开网站
3. 完成！

**分发方法**：
```
📁 小学科学四年级/
  ├── 启动网站.bat          ← 双击这个
  ├── index.html
  ├── 小学科学四上：科学大闯关总站.html
  └── 所有其他 HTML 文件
```

将整个文件夹压缩成 ZIP，分享给其他人即可。

---

## 🔨 打包成真正的 EXE

### 方法二：使用 Python + PyInstaller

#### 准备工作
1. **安装 Python**
   - 下载：https://www.python.org/downloads/
   - 版本：Python 3.7+
   - ⚠️ 安装时勾选 "Add Python to PATH"

2. **验证安装**
   ```bash
   python --version
   ```

#### 自动打包（推荐）

**简单版（EXE + HTML 文件）**：
```bash
双击运行: build_exe.bat
```

**高级版（所有文件打包进 EXE）**：
```bash
双击运行: build_exe_advanced.bat
```

#### 手动打包

```bash
# 1. 安装 PyInstaller
pip install pyinstaller

# 2. 打包
pyinstaller --onefile --windowed --name "小学科学四年级" launcher.py

# 3. 查看结果
# EXE 文件在 dist 文件夹中
```

---

## 📦 三种打包方案对比

| 方案 | 优点 | 缺点 | 适用场景 |
|------|------|------|---------|
| **BAT 启动器** | 简单、快速、无需打包 | 需要 HTML 文件 | 个人使用、快速分享 |
| **简单 EXE** | 专业、易用 | 需要 HTML 文件 | 学校、培训机构 |
| **完整 EXE** | 单文件、独立运行 | 文件较大 | 正式发布、商业使用 |

---

## 🎯 推荐方案

### 场景1：给同事/朋友使用
**推荐**：BAT 启动器
```
1. 将所有文件放在一个文件夹
2. 压缩成 ZIP
3. 分享下载链接
4. 解压后双击 "启动网站.bat"
```

### 场景2：学校电脑使用
**推荐**：简单 EXE
```
1. 运行 build_exe.bat
2. 将 dist 文件夹中的 EXE 复制出来
3. 和 HTML 文件放在一起
4. 双击 EXE 启动
```

### 场景3：正式发布/商业使用
**推荐**：完整 EXE + 安装程序
```
1. 运行 build_exe_advanced.bat
2. 使用 Inno Setup 创建安装程序
3. 添加代码签名
4. 发布到官网
```

---

## 📝 详细步骤（方法二）

### 步骤1：安装 Python

1. 访问 https://www.python.org/downloads/
2. 下载 Python 3.11（或最新版本）
3. 运行安装程序
4. ⚠️ **重要**：勾选 "Add Python to PATH"
5. 点击 "Install Now"
6. 等待安装完成

### 步骤2：打包 EXE

#### 方式A：使用自动脚本（推荐）

1. 双击 `build_exe.bat`
2. 等待自动安装 PyInstaller
3. 等待打包完成（约 1-2 分钟）
4. 在 `dist` 文件夹找到 EXE

#### 方式B：手动命令

打开命令提示符（CMD），输入：

```bash
# 安装 PyInstaller
pip install pyinstaller

# 打包（简单版）
pyinstaller --onefile --windowed launcher.py

# 打包（自定义名称）
pyinstaller --onefile --windowed --name "小学科学四年级" launcher.py

# 打包（添加图标）
pyinstaller --onefile --windowed --icon=icon.ico launcher.py
```

### 步骤3：测试 EXE

1. 进入 `dist` 文件夹
2. 双击 EXE 文件
3. 应该会自动打开浏览器
4. 检查所有功能是否正常

### 步骤4：分发

#### 简单版分发
```
📁 小学科学四年级/
  ├── 小学科学四年级.exe
  ├── index.html
  ├── 小学科学四上：科学大闯关总站.html
  └── 所有课程 HTML 文件
```

#### 完整版分发
```
📁 小学科学四年级/
  └── 小学科学四年级.exe  ← 只需要这一个文件
```

---

## 🐛 常见问题

### Q1: 双击 build_exe.bat 没反应？
**A**: 
1. 检查是否安装了 Python
2. 打开 CMD，输入 `python --version`
3. 如果提示找不到命令，重新安装 Python 并勾选 "Add to PATH"

### Q2: 打包后 EXE 无法运行？
**A**:
1. 检查杀毒软件是否拦截
2. 添加到白名单
3. 或使用 `--noconsole` 参数重新打包

### Q3: 找不到 HTML 文件？
**A**:
1. 确保 HTML 文件和 EXE 在同一文件夹
2. 或使用高级打包将 HTML 打包进 EXE

### Q4: 端口被占用？
**A**:
- 程序会自动尝试 8080-8089 端口
- 如果都被占用，会提示错误
- 关闭其他占用端口的程序

### Q5: 打包文件太大？
**A**:
- 简单版：约 5-10 MB
- 完整版：约 20-50 MB
- 使用 UPX 压缩可以减小 30-50%

---

## 🎨 自定义设置

### 修改启动页面
编辑 `launcher.py`，找到：
```python
START_PAGE = "index.html"
```
改为：
```python
START_PAGE = "小学科学四上：科学大闯关总站.html"
```

### 修改端口
编辑 `launcher.py`，找到：
```python
PORT = 8080
```
改为其他端口，如：
```python
PORT = 9000
```

### 添加图标
1. 准备 `icon.ico` 文件（256x256）
2. 放在项目根目录
3. 打包时添加参数：
```bash
pyinstaller --onefile --windowed --icon=icon.ico launcher.py
```

---

## 📊 性能对比

| 指标 | BAT 启动器 | 简单 EXE | 完整 EXE |
|------|-----------|---------|---------|
| 文件大小 | < 1 KB | 5-10 MB | 20-50 MB |
| 启动速度 | 即时 | 2-3 秒 | 5-10 秒 |
| 易用性 | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| 专业度 | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| 更新方便 | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐ |

---

## 🎓 进阶技巧

### 1. 创建安装程序
使用 Inno Setup：
1. 下载：https://jrsoftware.org/isdl.php
2. 创建安装脚本
3. 生成 Setup.exe

### 2. 添加代码签名
- 购买代码签名证书
- 使用 SignTool 签名
- 避免杀毒软件误报

### 3. 自动更新功能
- 检查 GitHub Releases
- 下载最新版本
- 自动替换文件

---

## 📞 需要帮助？

### 查看详细文档
- `打包EXE完整指南.md` - 超详细教程
- `launcher.py` - 源代码（可修改）

### 在线资源
- PyInstaller 文档: https://pyinstaller.org/
- Python 官网: https://www.python.org/

### 常见错误解决
1. **ModuleNotFoundError**: 运行 `pip install pyinstaller`
2. **Permission Denied**: 以管理员身份运行
3. **Antivirus Alert**: 添加到白名单

---

## ✅ 快速检查清单

打包前：
- [ ] Python 已安装
- [ ] PyInstaller 已安装
- [ ] launcher.py 存在
- [ ] HTML 文件已准备好

打包后：
- [ ] EXE 文件已生成
- [ ] 双击可以运行
- [ ] 浏览器自动打开
- [ ] 所有功能正常

分发前：
- [ ] 测试在其他电脑上运行
- [ ] 添加使用说明
- [ ] 压缩成 ZIP
- [ ] 上传到网盘

---

**祝你打包顺利！🎉**

如有问题，请查看 `打包EXE完整指南.md` 获取更详细的说明。
