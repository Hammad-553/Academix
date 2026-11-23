@echo off
chcp 65001 >nul 2>nul
setlocal
cd /d "%~dp0"

echo ==========================================
echo    AcademiX - Start Project (Local)
echo ==========================================
echo.
echo  Frontend : Vite + React  (port 8080)
echo  Database : Local SQL - browser mein chalta hai
echo  AI Model : Browser mein hi download + chalta hai
echo  Backend  : Alag server ki zaroorat NAHI -
echo             sab kuch isi browser ke andar hai.
echo.

REM ---------- Node.js check ----------
where node >nul 2>nul
if errorlevel 1 (
    echo [ERROR] Node.js nahi mila.
    echo         Install karein: https://nodejs.org
    echo         Phir ye file dobara chalayen.
    pause
    exit /b 1
)

for /f "delims=" %%v in ('node -v') do echo [OK] Node.js %%v

REM ---------- Dependencies check ----------
if exist "node_modules\vite" (
    echo [OK] Dependencies already installed.
) else (
    echo.
    echo [1/2] Dependencies install ho rahi hain - pehli baar thora time lagega...
    call npm install --no-audit --no-fund
    if errorlevel 1 (
        echo.
        echo [ERROR] npm install fail ho gaya - internet check karein.
        pause
        exit /b 1
    )
    echo [OK] Dependencies installed.
)

echo.
echo [2/2] Frontend start ho raha hai...
echo       URL: http://localhost:8080
echo       (Browser khud 6 second mein khul jayega)
echo       Server band karne ke liye: Ctrl+C
echo.

REM ---------- Browser kholein (server start hone ke liye 6s) ----------
start "" cmd /c "timeout /t 6 /nobreak >nul & start http://localhost:8080"

REM ---------- Dev server ----------
call npm run dev

echo.
echo Server band ho gaya.
pause
