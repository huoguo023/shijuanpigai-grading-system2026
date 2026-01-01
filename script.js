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
        'u1-3': 'unit1-lesson3-sound-propagation.html',
        'u1-4': 'unit1-lesson4-hearing.html',
        'u1-5': 'unit1-lesson5-sound-intensity.html',
        'u1-6': 'unit1-lesson6-sound-pitch.html',
        'u1-78': 'unit1-lesson7-8-instruments.html',
        // 第二单元
        'u2-1': 'unit2-lesson1-breathing.html',
        'u2-2': 'unit2-lesson2-healthy-breathing.html',
        'u2-3': 'unit2-lesson3-lung-capacity.html',
        'u2-4': 'unit2-lesson4-daily-food.html',
        'u2-5': 'unit2-lesson5-nutrition.html',
        'u2-6': 'unit2-lesson6-balanced-diet.html',
        'u2-7': 'unit2-lesson7-digestion-mouth.html',
        'u2-8': 'unit2-lesson8-digestion-journey.html',
        // 第三单元
        'u3-1': 'unit3-lesson1-motion-force.html',
        'u3-2': 'unit3-lesson2-balloon-car.html',
        'u3-3': 'unit3-lesson3-rubber-band-car.html',
        'u3-4': 'unit3-lesson4-spring-scale.html',
        'u3-5': 'unit3-lesson5-friction.html',
        'u3-6': 'unit3-lesson6-friction-secrets.html',
        'u3-78': 'unit3-lesson7-8-car-design.html'
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
