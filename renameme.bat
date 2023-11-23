@echo off
setlocal enabledelayedexpansion

:: Kill Battle.net App and Agent if running
taskkill /F /IM "Battle.net.exe" /T
taskkill /F /IM "Agent.exe" /T

:: Check if assignmentnotes.txt exists
if exist assignmentnotes.txt (
    :: File exists, read paths
    for /f "tokens=*" %%a in (assignmentnotes.txt) do (
        if not defined unlockerPath (
            set "unlockerPath=%%a"
        ) else if not defined unlockerDir (
            set "unlockerDir=%%a"
        ) else if not defined unlockerName (
            set "unlockerName=%%a"
        )
    )
) else (
    :: File does not exist, ask for path
    set /p "unlockerPath=Paste the path to the unlocker (without quotation marks): "
    for %%a in ("!unlockerPath!") do (
        set "unlockerName=%%~nxa"
        set "unlockerDir=%%~dpa"
    )
    :: Save to assignmentnotes.txt
    echo !unlockerPath! > assignmentnotes.txt
    echo !unlockerDir! >> assignmentnotes.txt
    echo !unlockerName! >> assignmentnotes.txt
)

:: Pause for 5 seconds
timeout /t 5 /nobreak

:: Run the unlocker
start "" "%unlockerPath%"
