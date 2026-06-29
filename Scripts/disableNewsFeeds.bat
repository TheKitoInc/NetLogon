@echo off
cls

:: =========================================
:: DISABLE NEWS AND INTERESTS
:: =========================================

call "%~dp0Helpers\showTitle.bat" "Disable News and Interests"

taskkill /F /IM explorer.exe

reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /v "ShellFeedsTaskbarPreviousViewMode" /t REG_DWORD /d "2" /f

:: Windows 10
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Software\Policies\Microsoft\Windows\Windows Feeds" /v EnableFeeds /t REG_DWORD /d 0 /f

:: Windows 11
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >nul

call "%~dp0Helpers\restartExplorer.bat"

call "%~dp0Helpers\showSuccess.bat"