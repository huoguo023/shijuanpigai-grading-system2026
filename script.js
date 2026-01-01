/* ============================================================ */
/* 小学科学四上：科学大闯关总站 - 脚本文件 */
/* ============================================================ */

// 辅助函数：简化querySelector
function getQuerySelector(selector) {
    if (document.querySelector) {
        return document.querySelector(selector);
    }
    if (selector.startsWith('#')) {
        return document.getElementById(selector.substring(1));
    }
    return document.body; // Fallback
}

// 核心功能：加载课程内容
function loadLesson(id, event) {
    // 1. UI更新
    document.getElementById('welcome').style.display = 'none';
    
    // 移除所有按钮激活态
    var btns = document.querySelectorAll('.lesson-btn');
    for (var i = 0; i < btns.length; i++) {
        btns[i].classList.remove('active');
    }
    
    // 添加当前按钮激活态
    if (event && event.target) {
        event.target.classList.add('active');
    }

    var iframe = document.getElementById('content-frame');
    
    // 2. 特殊处理：使用外部HTML文件的课程
    var externalFiles = {
        // 第一单元
        'u1-3': '第一单元 第三课：声音是怎样传播的.html',
        'u1-4': '第一单元第四课：我们是怎样听到声音的.html',
        'u1-5': '第一单元  第五课.声音的强与弱.html',
        'u1-6': '第一单元6.声音的高与低.html',
        'u1-78': '第一单元第七、八课：让弦发出高低不同的声音 & 制作小乐器.html',
        // 第二单元
        'u2-1': '小学科学四上 第二单元1.感受我们的呼吸 复习.html',
        'u2-2': '小学科学四上第二单元2.呼吸与健康生活.html',
        'u2-3': '小学科学四上第二单元3.测量肺活量.html',
        'u2-4': '小学科学四上第二单元4.一天的食物.html',
        'u2-5': '小学科学四上第二单元5.食物中的营养.html',
        'u2-6': '小学科学四上第二单元6.营养要均衡.html',
        'u2-7': '小学科学四上第二单元7：食物在口腔里的变化.html',
        'u2-8': '小学科学四上第二单元8.食物在身体里的旅行.html',
        // 第三单元
        'u3-1': '第三单元 第1课 运动和力 .html',
        'u3-2': '第三单元 新第2课 用气球驱动小车.html',
        'u3-3': '第三单元 第三课 用橡皮筋驱动小车.html',
        'u3-4': '第三单元 第四课、弹簧测力计.html',
        'u3-5': '第三单元 第5课.html',
        'u3-6': '第三单元 第6课.html',
        'u3-78': '第三单元 7、 8课.html'
    };
    
    if (externalFiles[id]) {
        // 直接加载外部HTML文件
        iframe.src = externalFiles[id];
    } else {
        // 3. 从textarea读取内容
        var storage = document.getElementById(id);
        
        if (storage && storage.value.trim() !== '') {
            // 注入内容到 iframe
            // 优先使用 srcdoc，不兼容则回退到 Blob URL
            if ('srcdoc' in iframe) {
                iframe.srcdoc = storage.value;
            } else {
                var blob = new Blob([storage.value], {type: 'text/html'});
                var blobURL = URL.createObjectURL(blob);
                iframe.src = blobURL;
                
                // 释放内存
                iframe.onload = function() {
                    URL.revokeObjectURL(blobURL);
                };
            }
        } else {
            // 4. 空内容处理
            var emptyContent = '<body style="font-family:\'Microsoft YaHei\', sans-serif; text-align:center; padding:50px; color:#666;">' +
                                '<h2 style="color:#FF5722;">🚧 内容加载中或为空</h2>' +
                                '<p>请确认代码已粘贴到对应ID的 textarea 中。<br>ID: ' + id + '</p></body>';
            iframe.srcdoc = emptyContent;
        }
    }

    // 5. 移动端：点击后自动收起侧边栏
    if (window.innerWidth <= 768) {
        var sidebar = document.getElementById('sidebar');
        var overlay = getQuerySelector('.overlay');
        if (sidebar.classList.contains('open')) {
            toggleSidebar();
        }
    }
}

// 侧边栏切换（移动端）
function toggleSidebar() {
    var sidebar = document.getElementById('sidebar');
    var overlay = getQuerySelector('.overlay');
    
    if (sidebar.classList.contains('open')) {
        sidebar.classList.remove('open');
        if (overlay) overlay.style.display = 'none';
    } else {
        sidebar.classList.add('open');
        if (overlay) overlay.style.display = 'block';
    }
}

// 单元折叠/展开
function toggleUnit(listId) {
    var list = document.getElementById(listId);
    var unitTitle = list.previousElementSibling;
    var arrow = unitTitle.querySelector('span');

    if (list.classList.contains('collapsed')) {
        list.classList.remove('collapsed');
        if (arrow) arrow.textContent = '▼';
    } else {
        list.classList.add('collapsed');
        if (arrow) arrow.textContent = '▶';
    }
}
