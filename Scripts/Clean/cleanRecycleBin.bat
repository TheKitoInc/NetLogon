@echo off
cls

:: =========================================
:: RECYCLE BIN
:: =========================================

call "%~dp0..\Helpers\showTitle.bat" "Recycle Bin Cleaner"

echo Emptying Recycle Bin...

powershell -Command "Clear-RecycleBin -Force" >nul 2>&1

call "%~dp0..\Helpers\showSuccess.bat"
