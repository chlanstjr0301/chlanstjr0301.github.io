@echo off
rem ============================================================
rem  new-post.bat — 더블클릭으로 새 글 만들기 (터미널 불필요)
rem  블로그/일기 선택 → 이름 입력 → 생성된 index.md가 바로 열림
rem ============================================================
setlocal EnableDelayedExpansion
cd /d "%~dp0"

echo.
echo  [b] Blog     [d] Investment Diary
set /p KIND=  which? (b/d):

if /i "!KIND!"=="d" goto diary

set /p CAT=  category path (ex: financial-engineering/options):
set /p NAME=  post name in english (ex: black-scholes-note):
set TARGET=blog/!CAT!/!NAME!
goto create

:diary
for /f %%i in ('powershell -nop -c "Get-Date -Format yyyy-MM-dd"') do set TODAY=%%i
set /p NAME=  note name in english (ex: cpi-note):
set TARGET=diary/!TODAY!-!NAME!

:create
hugo new "!TARGET!"
set FILE=content\!TARGET:/=\!\index.md
if exist "!FILE!" (
  echo.
  echo  created: !FILE!
  start "" "!FILE!"
) else (
  echo.
  echo  [error] failed - check category path
  pause
)
endlocal
