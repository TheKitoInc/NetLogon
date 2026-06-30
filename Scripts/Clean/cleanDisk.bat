@echo off
cls

:: =========================================
:: DISK CLEANUP
:: =========================================

call "%~dp0..\Helpers\showTitle.bat" "Disk Cleanup"

call "%~dp0..\Helpers\checkElevated.bat"

echo Running Disk Cleanup...

cleanmgr /sagerun:1

call "%~dp0..\Helpers\showSuccess.bat"
