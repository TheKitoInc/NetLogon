@echo off
cls

:: =========================================
:: BRAVE CACHE
:: =========================================

call "%~dp0..\Helpers\showTitle.bat" "Brave Browser Cache Cleaner"

echo Cleaning Brave Browser cache...

taskkill /f /im brave.exe >nul 2>&1

rd /s /q "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Cache" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Code Cache" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\GPUCache" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\User Data\Default\Service Worker\CacheStorage" >nul 2>&1

call "%~dp0..\Helpers\showSuccess.bat"