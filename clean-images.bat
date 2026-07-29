@echo off
rem 글에서 지운 이미지 파일 정리 (참조 없는 고아 이미지를 _to_delete로 이동)
cd /d "%~dp0"
powershell -nop -ExecutionPolicy Bypass -File "tools\clean-images.ps1"
pause
