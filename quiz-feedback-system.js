/**
 * 小学科学测试即时反馈系统
 * 功能：答对播放表扬音效+撒花动画，答错播放提示音+鼓励提示
 */

// ==================== 音效系统 ====================
const AudioFeedback = {
    ctx: null,
    
    init() {
        this.ctx = new (window.AudioContext || window.webkitAudioContext)();
    },
    
    // 答对音效 - 欢快的上升音阶
    playCorrect() {
        if (!this.ctx) this.init();
        if (this.ctx.state === 'suspended') this.ctx.resume();
        
        const notes = [523.25, 659.25, 783.99]; // C5, E5, G5
        notes.forEach((freq, i) => {
            const osc = this.ctx.createOscillator();
            const gain = this.ctx.createGain();
            osc.connect(gain);
            gain.connect(this.ctx.destination);
            
            const now = this.ctx.currentTime;
            const start = now + i * 0.1;
            
            osc.frequency.value = freq;
            osc.type = 'sine';
            gain.gain.setValueAtTime(0.15, start);
            gain.gain.exponentialRampToValueAtTime(0.01, start + 0.3);
            
            osc.start(start);
            osc.stop(start + 0.3);
        });
    },
    
    // 答错音效 - 温和的提示音
    playWrong() {
        if (!this.ctx) this.init();
        if (this.ctx.state === 'suspended') this.ctx.resume();
        
        const osc = this.ctx.createOscillator();
        const gain = this.ctx.createGain();
        osc.connect(gain);
        gain.connect(this.ctx.destination);
        
        const now = this.ctx.currentTime;
        osc.frequency.setValueAtTime(300, now);
        osc.frequency.linearRampToValueAtTime(250, now + 0.2);
        osc.type = 'triangle';
        
        gain.gain.setValueAtTime(0.1, now);
        gain.gain.linearRampToValueAtTime(0, now + 0.2);
        
        osc.start(now);
        osc.stop(now + 0.2);
    },
    
    // 点击音效
    playClick() {
        if (!this.ctx) this.init();
        if (this.ctx.state === 'suspended') this.ctx.resume();
        
        const osc = this.ctx.createOscillator();
        const gain = this.ctx.createGain();
        osc.connect(gain);
        gain.connect(this.ctx.destination);
        
        const now = this.ctx.currentTime;
        osc.frequency.value = 800;
        gain.gain.setValueAtTime(0.05, now);
        gain.gain.linearRampToValueAtTime(0, now + 0.05);
        
        osc.start(now);
        osc.stop(now + 0.05);
    }
};

// ==================== 动画系统 ====================
const AnimationFeedback = {
    // 撒花动画
    showConfetti(container) {
        const colors = ['#FF6B6B', '#4ECDC4', '#45B7D1', '#FFA07A', '#98D8C8', '#F7DC6F', '#BB8FCE'];
        const confettiCount = 30;
        
        for (let i = 0; i < confettiCount; i++) {
            setTimeout(() => {
                const confetti = document.createElement('div');
                confetti.className = 'confetti';
                confetti.style.cssText = `
                    position: fixed;
                    width: ${Math.random() * 10 + 5}px;
                    height: ${Math.random() * 10 + 5}px;
                    background: ${colors[Math.floor(Math.random() * colors.length)]};
                    left: ${Math.random() * 100}%;
                    top: -20px;
                    border-radius: ${Math.random() > 0.5 ? '50%' : '0'};
                    opacity: 1;
                    z-index: 9999;
                    pointer-events: none;
                    animation: confetti-fall ${Math.random() * 2 + 2}s linear forwards;
                    transform: rotate(${Math.random() * 360}deg);
                `;
                
                (container || document.body).appendChild(confetti);
                
                setTimeout(() => confetti.remove(), 4000);
            }, i * 30);
        }
    },
    
    // 答对提示框
    showCorrectToast(message = '回答正确！真棒！🎉') {
        this.showToast(message, 'success');
    },
    
    // 答错提示框
    showWrongToast(message = '再想想哦！加油！💪') {
        this.showToast(message, 'error');
    },
    
    // 通用提示框
    showToast(message, type = 'success') {
        const toast = document.createElement('div');
        toast.className = `feedback-toast feedback-${type}`;
        toast.innerHTML = `
            <div class="toast-icon">${type === 'success' ? '✓' : '✗'}</div>
            <div class="toast-message">${message}</div>
        `;
        
        document.body.appendChild(toast);
        
        // 触发动画
        setTimeout(() => toast.classList.add('show'), 10);
        
        // 自动移除
        setTimeout(() => {
            toast.classList.remove('show');
            setTimeout(() => toast.remove(), 300);
        }, 2000);
    },
    
    // 选项抖动动画（答错时）
    shakeElement(element) {
        element.classList.add('shake-animation');
        setTimeout(() => element.classList.remove('shake-animation'), 500);
    },
    
    // 选项高亮动画（答对时）
    highlightElement(element) {
        element.classList.add('correct-highlight');
    }
};

// ==================== 反馈管理器 ====================
const FeedbackManager = {
    encouragements: [
        '太棒了！继续加油！🌟',
        '你真聪明！👍',
        '完全正确！真厉害！🎯',
        '答对了！你是最棒的！⭐',
        '太优秀了！继续保持！🏆',
        '真是个小天才！💡',
        '回答得非常好！👏',
        '你掌握得很好！📚'
    ],
    
    hints: [
        '再想想哦！你可以的！💪',
        '别灰心，再试一次！🌈',
        '加油！仔细看看题目！👀',
        '没关系，继续努力！💫',
        '再看看知识点吧！📖',
        '不要放弃，你能行！🚀',
        '思考一下，你一定能想到！🤔',
        '加油！相信自己！✨'
    ],
    
    getRandomEncouragement() {
        return this.encouragements[Math.floor(Math.random() * this.encouragements.length)];
    },
    
    getRandomHint() {
        return this.hints[Math.floor(Math.random() * this.hints.length)];
    },
    
    // 答对反馈
    onCorrect(element, options = {}) {
        AudioFeedback.playCorrect();
        AnimationFeedback.showConfetti(options.container);
        AnimationFeedback.showCorrectToast(options.message || this.getRandomEncouragement());
        if (element) AnimationFeedback.highlightElement(element);
    },
    
    // 答错反馈
    onWrong(element, options = {}) {
        AudioFeedback.playWrong();
        AnimationFeedback.showWrongToast(options.message || this.getRandomHint());
        if (element) AnimationFeedback.shakeElement(element);
    },
    
    // 点击反馈
    onClick() {
        AudioFeedback.playClick();
    }
};

// ==================== CSS样式注入 ====================
function injectFeedbackStyles() {
    if (document.getElementById('feedback-styles')) return;
    
    const style = document.createElement('style');
    style.id = 'feedback-styles';
    style.textContent = `
        /* 提示框样式 */
        .feedback-toast {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%) translateY(-100px);
            background: white;
            padding: 15px 25px;
            border-radius: 50px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.2);
            display: flex;
            align-items: center;
            gap: 12px;
            z-index: 10000;
            opacity: 0;
            transition: all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            font-size: 1.1rem;
            font-weight: bold;
        }
        
        .feedback-toast.show {
            opacity: 1;
            transform: translateX(-50%) translateY(0);
        }
        
        .feedback-success {
            border: 3px solid #4CAF50;
            color: #2E7D32;
        }
        
        .feedback-error {
            border: 3px solid #FF9800;
            color: #E65100;
        }
        
        .toast-icon {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            font-weight: bold;
        }
        
        .feedback-success .toast-icon {
            background: #4CAF50;
            color: white;
        }
        
        .feedback-error .toast-icon {
            background: #FF9800;
            color: white;
        }
        
        /* 撒花动画 */
        @keyframes confetti-fall {
            0% {
                transform: translateY(0) rotate(0deg);
                opacity: 1;
            }
            100% {
                transform: translateY(100vh) rotate(720deg);
                opacity: 0;
            }
        }
        
        /* 抖动动画 */
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }
        
        .shake-animation {
            animation: shake 0.5s;
            border-color: #FF9800 !important;
            background: #FFF3E0 !important;
        }
        
        /* 正确高亮动画 */
        @keyframes correct-pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.02); }
        }
        
        .correct-highlight {
            animation: correct-pulse 0.5s;
            border-color: #4CAF50 !important;
            background: #E8F5E9 !important;
            box-shadow: 0 0 20px rgba(76, 175, 80, 0.3) !important;
        }
        
        /* 移动端适配 */
        @media (max-width: 768px) {
            .feedback-toast {
                font-size: 1rem;
                padding: 12px 20px;
                max-width: 90%;
            }
        }
    `;
    
    document.head.appendChild(style);
}

// 初始化
if (typeof window !== 'undefined') {
    injectFeedbackStyles();
    AudioFeedback.init();
}

// 导出（如果使用模块系统）
if (typeof module !== 'undefined' && module.exports) {
    module.exports = { AudioFeedback, AnimationFeedback, FeedbackManager };
}
