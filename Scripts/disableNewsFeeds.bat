@echo off
cls

:: =========================================
:: DISABLE NEWS AND INTERESTS
:: =========================================

call "%~dp0Helpers\showTitle.bat" "Disable News and Interests"

:: 0. IMPORTANT: stop shell first, not just explorer
taskkill /f /im explorer.exe
taskkill /f /im ShellExperienceHost.exe >nul 2>&1
taskkill /f /im StartMenuExperienceHost.exe >nul 2>&1

:: 1. Set POLICY FIRST (most important)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds" ^
 /v EnableFeeds ^
 /t REG_DWORD ^
 /d 0 ^
 /f

:: 2. User-level fallback (taskbar UI state)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" ^
 /v ShellFeedsTaskbarViewMode ^
 /t REG_DWORD ^
 /d 2 ^
 /f

:: 3. ALSO disable search highlights (keeps feed behavior alive visually)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings" ^
 /v IsDynamicSearchBoxEnabled ^
 /t REG_DWORD ^
 /d 0 ^
 /f


call "%~dp0Helpers\restartExplorer.bat"

call "%~dp0Helpers\showSuccess.bat"