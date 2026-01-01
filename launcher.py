#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
小学科学四年级上册 - 本地启动器
双击运行即可在浏览器中打开学习网站
"""

import http.server
import socketserver
import webbrowser
import os
import sys
import threading
import time
from pathlib import Path

# 配置
PORT = 8080
HOST = "127.0.0.1"
START_PAGE = "index.html"  # 或 "小学科学四上：科学大闯关总站.html"

class QuietHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    """静默的HTTP请求处理器，不打印日志"""
    
    def log_message(self, format, *args):
        """重写日志方法，不输出到控制台"""
        pass
    
    def end_headers(self):
        """添加CORS头，允许跨域"""
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Cache-Control', 'no-store, no-cache, must-revalidate')
        super().end_headers()

def get_resource_path(relative_path):
    """获取资源文件的绝对路径（支持PyInstaller打包）"""
    try:
        # PyInstaller创建临时文件夹，将路径存储在_MEIPASS中
        base_path = sys._MEIPASS
    except Exception:
        base_path = os.path.abspath(".")
    
    return os.path.join(base_path, relative_path)

def find_available_port(start_port=8080, max_attempts=10):
    """查找可用端口"""
    for port in range(start_port, start_port + max_attempts):
        try:
            with socketserver.TCPServer((HOST, port), QuietHTTPRequestHandler) as test_server:
                return port
        except OSError:
            continue
    return None

def start_server(port):
    """启动HTTP服务器"""
    try:
        # 切换到程序所在目录
        if hasattr(sys, '_MEIPASS'):
            os.chdir(sys._MEIPASS)
        
        Handler = QuietHTTPRequestHandler
        
        with socketserver.TCPServer((HOST, port), Handler) as httpd:
            print(f"✅ 服务器已启动")
            print(f"📍 地址: http://{HOST}:{port}")
            print(f"📚 正在打开浏览器...")
            print(f"\n💡 提示：关闭此窗口将停止服务器")
            print(f"=" * 50)
            httpd.serve_forever()
    except Exception as e:
        print(f"❌ 服务器启动失败: {e}")
        input("按回车键退出...")
        sys.exit(1)

def open_browser(url, delay=1.5):
    """延迟打开浏览器"""
    time.sleep(delay)
    try:
        webbrowser.open(url)
        print(f"✅ 浏览器已打开")
    except Exception as e:
        print(f"⚠️  无法自动打开浏览器: {e}")
        print(f"请手动访问: {url}")

def main():
    """主函数"""
    # 设置控制台标题（仅Windows）
    if sys.platform == 'win32':
        os.system('title 小学科学四年级 - 本地服务器')
    
    print("=" * 50)
    print("🎓 小学科学四年级上册 - 互动学习网站")
    print("=" * 50)
    print()
    
    # 检查启动页面是否存在
    if not os.path.exists(START_PAGE):
        print(f"⚠️  警告: 找不到 {START_PAGE}")
        print(f"📂 当前目录: {os.getcwd()}")
        print(f"📋 目录内容:")
        for item in os.listdir('.'):
            print(f"   - {item}")
        print()
    
    # 查找可用端口
    port = find_available_port(PORT)
    if port is None:
        print(f"❌ 无法找到可用端口（尝试了 {PORT}-{PORT+9}）")
        input("按回车键退出...")
        sys.exit(1)
    
    if port != PORT:
        print(f"ℹ️  端口 {PORT} 已被占用，使用端口 {port}")
    
    # 构建URL
    url = f"http://{HOST}:{port}/{START_PAGE}"
    
    # 在新线程中打开浏览器
    browser_thread = threading.Thread(target=open_browser, args=(url,))
    browser_thread.daemon = True
    browser_thread.start()
    
    # 启动服务器（阻塞）
    try:
        start_server(port)
    except KeyboardInterrupt:
        print("\n\n👋 服务器已停止")
        sys.exit(0)

if __name__ == "__main__":
    main()
