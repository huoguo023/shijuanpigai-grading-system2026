@echo off
chcp 65001 >nul
title 批量重命名 HTML 文件为英文
color 0B

echo.
echo ╔════════════════════════════════════════════════════╗
echo ║                                                    ║
echo ║        📝 批量重命名 HTML 文件为英文              ║
echo ║                                                    ║
echo ╚════════════════════════════════════════════════════╝
echo.
echo 即将重命名所有课程 HTML 文件...
echo.
echo ⚠️  注意：此操作会修改文件名，建议先备份！
echo.
set /p confirm="确认继续? (Y/N): "
if /i not "%confirm%"=="Y" (
    echo 已取消
    pause
    exit /b 0
)

echo.
echo 开始重命名...
echo.

REM 第一单元
echo [第一单元]
ren "第一单元 第1课.听听声音 .html" "unit1-lesson1-sounds.html" 2>nul && echo ✅ 第1课 → unit1-lesson1-sounds.html
ren "第一单元 第二课：声音是怎样产生的.html" "unit1-lesson2-sound-production.html" 2>nul && echo ✅ 第2课 → unit1-lesson2-sound-production.html
ren "第一单元 第三课：声音是怎样传播的.html" "unit1-lesson3-sound-propagation.html" 2>nul && echo ✅ 第3课 → unit1-lesson3-sound-propagation.html
ren "第一单元第四课：我们是怎样听到声音的.html" "unit1-lesson4-hearing.html" 2>nul && echo ✅ 第4课 → unit1-lesson4-hearing.html
ren "第一单元  第五课.声音的强与弱.html" "unit1-lesson5-sound-intensity.html" 2>nul && echo ✅ 第5课 → unit1-lesson5-sound-intensity.html
ren "第一单元6.声音的高与低.html" "unit1-lesson6-sound-pitch.html" 2>nul && echo ✅ 第6课 → unit1-lesson6-sound-pitch.html
ren "第一单元第七、八课：让弦发出高低不同的声音 & 制作小乐器.html" "unit1-lesson7-8-instruments.html" 2>nul && echo ✅ 第7-8课 → unit1-lesson7-8-instruments.html

echo.
REM 第二单元
echo [第二单元]
ren "小学科学四上 第二单元1.感受我们的呼吸 复习.html" "unit2-lesson1-breathing.html" 2>nul && echo ✅ 第1课 → unit2-lesson1-breathing.html
ren "小学科学四上第二单元2.呼吸与健康生活.html" "unit2-lesson2-healthy-breathing.html" 2>nul && echo ✅ 第2课 → unit2-lesson2-healthy-breathing.html
ren "小学科学四上第二单元3.测量肺活量.html" "unit2-lesson3-lung-capacity.html" 2>nul && echo ✅ 第3课 → unit2-lesson3-lung-capacity.html
ren "小学科学四上第二单元4.一天的食物.html" "unit2-lesson4-daily-food.html" 2>nul && echo ✅ 第4课 → unit2-lesson4-daily-food.html
ren "小学科学四上 第二单元4 一天的食物.html" "unit2-lesson4-daily-food-alt.html" 2>nul && echo ✅ 第4课(备份) → unit2-lesson4-daily-food-alt.html
ren "小学科学四上第二单元5.食物中的营养.html" "unit2-lesson5-nutrition.html" 2>nul && echo ✅ 第5课 → unit2-lesson5-nutrition.html
ren "小学科学四上第二单元6.营养要均衡.html" "unit2-lesson6-balanced-diet.html" 2>nul && echo ✅ 第6课 → unit2-lesson6-balanced-diet.html
ren "小学科学四上第二单元7：食物在口腔里的变化.html" "unit2-lesson7-digestion-mouth.html" 2>nul && echo ✅ 第7课 → unit2-lesson7-digestion-mouth.html
ren "小学科学四上第二单元8.食物在身体里的旅行.html" "unit2-lesson8-digestion-journey.html" 2>nul && echo ✅ 第8课 → unit2-lesson8-digestion-journey.html

echo.
REM 第三单元
echo [第三单元]
ren "第三单元 第1课 运动和力 .html" "unit3-lesson1-motion-force.html" 2>nul && echo ✅ 第1课 → unit3-lesson1-motion-force.html
ren "第三单元 新第2课 用气球驱动小车.html" "unit3-lesson2-balloon-car.html" 2>nul && echo ✅ 第2课 → unit3-lesson2-balloon-car.html
ren "第三单元 第三课 用橡皮筋驱动小车.html" "unit3-lesson3-rubber-band-car.html" 2>nul && echo ✅ 第3课 → unit3-lesson3-rubber-band-car.html
ren "第三单元 第四课、弹簧测力计.html" "unit3-lesson4-spring-scale.html" 2>nul && echo ✅ 第4课 → unit3-lesson4-spring-scale.html
ren "第三单元 第四课、弹簧测力计-修复版.html" "unit3-lesson4-spring-scale-fixed.html" 2>nul && echo ✅ 第4课(修复版) → unit3-lesson4-spring-scale-fixed.html
ren "第三单元 第5课.html" "unit3-lesson5-friction.html" 2>nul && echo ✅ 第5课 → unit3-lesson5-friction.html
ren "第三单元 第6课.html" "unit3-lesson6-friction-secrets.html" 2>nul && echo ✅ 第6课 → unit3-lesson6-friction-secrets.html
ren "第三单元 7、 8课.html" "unit3-lesson7-8-car-design.html" 2>nul && echo ✅ 第7-8课 → unit3-lesson7-8-car-design.html

echo.
REM 其他文件
echo [其他文件]
ren "小学科学四上：科学大闯关总站.html" "main-hub.html" 2>nul && echo ✅ 总站 → main-hub.html
ren "02小学科学四上：科学大闯关总站.html" "main-hub-v2.html" 2>nul && echo ✅ 总站v2 → main-hub-v2.html
ren "02小学科学四上：科学大闯关总站 - 副本.html" "main-hub-v2-backup.html" 2>nul && echo ✅ 总站备份 → main-hub-v2-backup.html
ren "第三单元 第一课 运动和力 - 全单元闯关测试02.html" "unit3-full-test.html" 2>nul && echo ✅ 第三单元测试 → unit3-full-test.html
ren "小学科学学习网页.html" "science-learning-page.html" 2>nul && echo ✅ 学习网页 → science-learning-page.html
ren "汇总01 .html" "summary-01.html" 2>nul && echo ✅ 汇总 → summary-01.html

echo.
echo ╔════════════════════════════════════════════════════╗
echo ║   ✅ 重命名完成！                                  ║
echo ╚════════════════════════════════════════════════════╝
echo.
echo 📋 文件命名规则:
echo   • 第一单元: unit1-lesson1-xxx.html
echo   • 第二单元: unit2-lesson1-xxx.html
echo   • 第三单元: unit3-lesson1-xxx.html
echo   • 总站页面: main-hub.html
echo.
echo 💡 提示:
echo   • 所有文件名已改为英文
echo   • 便于跨平台使用
echo   • 避免编码问题
echo.
pause
