@echo off
cls

setlocal

call "%~dp0Helpers\showTitle.bat" "Cleanup Launcher"

:: =========================================
:: Cleanup Framework Launcher
:: =========================================

set BASEDIR=%~dp0



:: =========================================
:: Detect Administrator
:: =========================================

set IS_ADMIN=0

net session >nul 2>&1
if %errorlevel% == 0 (
    set IS_ADMIN=1
)

:: =========================================
:: USER CLEANUP TASKS
:: =========================================

echo Running user cleanup tasks...
echo.

if exist "%BASEDIR%Clean\cleanTemp.bat" (
    call "%BASEDIR%Clean\cleanTemp.bat"
)

if exist "%BASEDIR%Clean\cleanChrome.bat" (
    call "%BASEDIR%Clean\cleanChrome.bat"
)

if exist "%BASEDIR%Clean\cleanChromium.bat" (
    call "%BASEDIR%Clean\cleanChromium.bat"
)

if exist "%BASEDIR%Clean\cleanEdge.bat" (
    call "%BASEDIR%Clean\cleanEdge.bat"
)

if exist "%BASEDIR%Clean\cleanFirefox.bat" (
    call "%BASEDIR%Clean\cleanFirefox.bat"
)

if exist "%BASEDIR%Clean\cleanBrave.bat" (
    call "%BASEDIR%Clean\cleanBrave.bat"
)

if exist "%BASEDIR%Clean\cleanRecycleBin.bat" (
    call "%BASEDIR%Clean\cleanRecycleBin.bat"
)

if exist "%BASEDIR%Clean\cleanPrinters.bat" (
    call "%BASEDIR%Clean\cleanPrinters.bat"
)

echo.
echo User cleanup tasks completed.
echo.

:: =========================================
:: ADMIN CLEANUP TASKS
:: =========================================

if "%IS_ADMIN%"=="1" (

    echo Running administrator cleanup tasks...
    echo.

    if exist "%BASEDIR%Clean\cleanWindowsUpdate.bat" (
        call "%BASEDIR%Clean\cleanWindowsUpdate.bat"
    )

    if exist "%BASEDIR%Clean\cleanPrefetch.bat" (
        call "%BASEDIR%Clean\cleanPrefetch.bat"
    )

    if exist "%BASEDIR%Clean\cleanUVNC.bat" (
        call "%BASEDIR%Clean\cleanUVNC.bat"
    )

    if exist "%BASEDIR%Clean\cleanDISM.bat" (
        call "%BASEDIR%Clean\cleanDISM.bat"
    )

    if exist "%BASEDIR%Clean\cleanDisk.bat" (
        call "%BASEDIR%Clean\cleanDisk.bat"
    )

    if exist "%BASEDIR%Clean\cleanErrorReports.bat" (
        call "%BASEDIR%Clean\cleanErrorReports.bat"
    )

    echo.
    echo Administrator cleanup tasks completed.

) else (

    echo Standard user detected.
    echo Skipping administrator-only tasks.

)

:: =========================================
:: FINISH
:: =========================================

echo.
echo Cleanup completed.

