# GitHub 部署指南

## 📋 准备工作

### 1. 创建 GitHub 账号
如果还没有 GitHub 账号：
1. 访问 https://github.com
2. 点击 "Sign up" 注册
3. 验证邮箱

### 2. 安装 Git
- **Windows**: 下载 [Git for Windows](https://git-scm.com/download/win)
- **Mac**: 使用 Homebrew `brew install git` 或下载安装包
- **Linux**: `sudo apt-get install git` (Ubuntu/Debian)

验证安装：
```bash
git --version
```

## 🚀 部署步骤

### 方法一：使用 GitHub 网页界面（推荐新手）

#### 1. 创建新仓库
1. 登录 GitHub
2. 点击右上角 "+" → "New repository"
3. 填写信息：
   - Repository name: `elementary-science-grade4`（或其他名称）
   - Description: `小学科学四年级上册互动学习网站`
   - Public（公开）或 Private（私有）
   - ✅ 勾选 "Add a README file"
4. 点击 "Create repository"

#### 2. 上传文件
1. 在仓库页面点击 "Add file" → "Upload files"
2. 拖拽或选择所有 HTML 文件
3. 添加提交信息：`Initial commit: 添加所有课程文件`
4. 点击 "Commit changes"

#### 3. 启用 GitHub Pages
1. 进入仓库的 "Settings"
2. 左侧菜单找到 "Pages"
3. Source 选择 "Deploy from a branch"
4. Branch 选择 "main" 和 "/ (root)"
5. 点击 "Save"
6. 等待几分钟，页面会显示访问链接

### 方法二：使用 Git 命令行（推荐熟练用户）

#### 1. 初始化本地仓库
```bash
# 进入项目文件夹
cd /path/to/your/project

# 初始化 Git 仓库
git init

# 添加所有文件
git add .

# 提交
git commit -m "Initial commit: 添加小学科学四年级课程"
```

#### 2. 连接到 GitHub
```bash
# 在 GitHub 创建空仓库后，复制仓库 URL
# 添加远程仓库
git remote add origin https://github.com/你的用户名/仓库名.git

# 推送到 GitHub
git branch -M main
git push -u origin main
```

#### 3. 启用 GitHub Pages
```bash
# 方法1：通过网页界面（见上方"方法一"的步骤3）

# 方法2：使用 GitHub CLI（需要先安装 gh）
gh repo edit --enable-pages --pages-branch main
```

## 🌐 访问网站

部署成功后，你的网站将在以下地址可访问：
```
https://你的用户名.github.io/仓库名/
```

例如：
```
https://zhangsan.github.io/elementary-science-grade4/
```

### 主页设置
有两种方式设置主页：

#### 选项1：使用 index.html
将 `小学科学四上：科学大闯关总站.html` 重命名为 `index.html`

#### 选项2：保持原文件名
访问时使用完整路径：
```
https://你的用户名.github.io/仓库名/小学科学四上：科学大闯关总站.html
```

## 🔄 更新网站

### 使用网页界面
1. 进入仓库
2. 找到要修改的文件
3. 点击文件名 → 点击铅笔图标编辑
4. 修改后点击 "Commit changes"

### 使用 Git 命令
```bash
# 修改文件后

# 查看修改
git status

# 添加修改
git add .

# 提交修改
git commit -m "描述你的修改"

# 推送到 GitHub
git push
```

## 📱 自定义域名（可选）

### 1. 购买域名
从域名注册商购买域名（如 Namecheap、GoDaddy、阿里云等）

### 2. 配置 DNS
在域名管理面板添加 CNAME 记录：
```
类型: CNAME
主机: www (或 @)
值: 你的用户名.github.io
```

### 3. 在 GitHub 设置
1. 进入仓库 Settings → Pages
2. Custom domain 输入你的域名
3. 点击 Save
4. 等待 DNS 验证（可能需要几小时）

## 🔒 HTTPS 设置

GitHub Pages 自动提供 HTTPS：
1. 进入 Settings → Pages
2. 勾选 "Enforce HTTPS"
3. 等待证书生成（几分钟）

## 📊 查看访问统计

### 使用 GitHub Insights
1. 进入仓库
2. 点击 "Insights" 标签
3. 查看 "Traffic" 了解访问情况

### 添加 Google Analytics（可选）
在 HTML 文件的 `<head>` 中添加：
```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'GA_MEASUREMENT_ID');
</script>
```

## 🐛 常见问题

### 问题1：页面404错误
**解决方案**：
- 检查文件名是否正确
- 确认 GitHub Pages 已启用
- 等待几分钟让部署完成

### 问题2：样式或脚本不加载
**解决方案**：
- 检查文件路径是否正确
- 使用相对路径而非绝对路径
- 确保所有资源文件都已上传

### 问题3：中文文件名问题
**解决方案**：
- GitHub Pages 支持中文文件名
- 但建议使用 URL 编码访问
- 或考虑重命名为英文

### 问题4：推送失败
**解决方案**：
```bash
# 拉取最新代码
git pull origin main

# 解决冲突后再推送
git push origin main
```

## 📚 进阶配置

### 添加 README 徽章
在 README.md 顶部添加：
```markdown
![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-deployed-success)
![License](https://img.shields.io/badge/license-MIT-blue)
![HTML5](https://img.shields.io/badge/HTML5-E34F26?logo=html5&logoColor=white)
```

### 设置 GitHub Actions 自动部署
创建 `.github/workflows/deploy.yml`：
```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./
```

## 🎯 优化建议

### 1. 压缩文件
- 使用在线工具压缩 HTML/CSS/JS
- 减小文件大小，加快加载速度

### 2. 添加 favicon
在 `<head>` 中添加：
```html
<link rel="icon" type="image/png" href="favicon.png">
```

### 3. 添加 meta 标签
```html
<meta name="description" content="小学科学四年级上册互动学习网站">
<meta name="keywords" content="小学科学,四年级,学习网站,SVG动画">
<meta name="author" content="你的名字">
```

## 📞 获取帮助

- GitHub 文档: https://docs.github.com/pages
- Git 教程: https://git-scm.com/book/zh/v2
- 提交 Issue: 在仓库中点击 "Issues" → "New issue"

---

**祝你部署顺利！🎉**
