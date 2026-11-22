@echo off
chcp 936 >nul
cd /d D:\LureWiki
set "GIT=C:\Users\jdhlp\AppData\Local\Programs\WorkBuddy\resources\vendor\PortableGit\mingw64\bin\git.exe"
if not exist "%GIT%" set "GIT=git"
echo ============================================
echo   一键同步路亚百科到 GitHub
echo ============================================
echo.

echo [1/3] 收集改动...
"%GIT%" add -A

"%GIT%" diff --cached --quiet
if %errorlevel% equ 0 (
    echo 没有需要同步的改动，已跳过。
    echo.
    pause
    exit /b 0
)

echo [2/3] 提交改动...
"%GIT%" commit -m "更新文章 %date% %time%"
if %errorlevel% neq 0 (
    echo [错误] 提交失败，请看上面的提示。
    pause
    exit /b 1
)

echo [3/3] 推送到 GitHub...
"%GIT%" push
if %errorlevel% neq 0 (
    echo.
    echo [错误] 推送失败，请检查网络或 Git 登录状态。
    pause
    exit /b 1
)

echo.
echo ============================================
echo   同步完成！
echo   稍等 1-2 分钟，刷新线上站查看：
echo   https://dianwo2010.github.io/lure-wiki/
echo ============================================
echo.
pause
