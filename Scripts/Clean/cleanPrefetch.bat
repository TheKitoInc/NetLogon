@echo off
cls

:: =========================================
:: PREFETCH
:: =========================================

call "%~dp0..\Helpers\showTitle.bat" "Prefetch Cleaner"

call "%~dp0..\Helpers\checkElevated.bat"

echo Cleaning Prefetch...

del /f /s /q "C:\Windows\Prefetch\*" >nul 2>&1

call "%~dp0..\Helpers\showSuccess.bat"
