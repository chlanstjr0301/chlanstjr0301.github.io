@echo off
rem new-post.bat — double-click launcher (runs tools/new-post.sh in Git Bash)
cd /d "%~dp0"
set "BASH="
if exist "%ProgramFiles%\Git\bin\bash.exe" set "BASH=%ProgramFiles%\Git\bin\bash.exe"
if not defined BASH if exist "%ProgramFiles(x86)%\Git\bin\bash.exe" set "BASH=%ProgramFiles(x86)%\Git\bin\bash.exe"
if not defined BASH if exist "%LocalAppData%\Programs\Git\bin\bash.exe" set "BASH=%LocalAppData%\Programs\Git\bin\bash.exe"
if not defined BASH for /f "delims=" %%i in ('where bash 2^>nul') do if not defined BASH set "BASH=%%i"
if not defined BASH (
  echo Git Bash not found. Install Git for Windows or run: bash tools/new-post.sh
  pause
  exit /b 1
)
"%BASH%" tools/new-post.sh
