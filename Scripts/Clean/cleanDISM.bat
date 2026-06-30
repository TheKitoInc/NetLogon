@echo off
cls

:: =========================================
:: DISM COMPONENT CLEANUP
:: =========================================

call "%~dp0..\Helpers\showTitle.bat" "DISM Component Cleanup"

call "%~dp0..\Helpers\checkElevated.bat"

echo Running DISM component cleanup...

DISM /Online /Cleanup-Image /StartComponentCleanup

call "%~dp0..\Helpers\showSuccess.bat"
