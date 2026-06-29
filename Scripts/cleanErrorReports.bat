@echo off
cls

:: =========================================
:: CLEAN WINDOWS ERROR REPORTING
:: =========================================

call "%~dp0Helpers\showTitle.bat" "Clean Windows Error Reporting"

call "%~dp0Helpers\checkElevated.bat"

del /f /s /q "%ProgramData%\Microsoft\Windows\WER\*" >nul 2>&1
for /d %%x in ("%ProgramData%\Microsoft\Windows\WER\*") do rd /s /q "%%x" >nul 2>&1

call "%~dp0Helpers\showSuccess.bat"
