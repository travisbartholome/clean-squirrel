@echo off
echo.

:: Check administrative privileges
echo Checking for administrative privileges...
net session >nul 2>&1
if %errorLevel% == 0 (
  echo Success: Administrative privileges available.
  echo.
) else (
  echo Error: cleansquirrel requires administrative privileges.
  echo Please run using Command Prompt as Admin.
  exit /B 1
)

:: Exit with error if no arguments
if "%~1"=="" (
  echo Error: cleansquirrel requires arguments.
  echo Type cleansquirrel.bat /HELP for help.
  exit /B 1
)

:: Some docs
if "%~1"=="/HELP" (
  echo Cleanly moves Squirrel installs to a new, user-specified location.
  echo Will create a new folder at specified location if one doesn't exist already.
  echo.
  echo cleansquirrel.bat [/HELP] Program TargetDir
  echo         /HELP      Displays this help dialog and ignores other options.
  echo         Program    The name of the folder in your %%appdata%% that
  echo                    contains the program you wish to move.
  echo         TargetDir  The path to which the specified program will
  echo                    be moved.
  exit /B 0
)

:: Check validity of program agrument
if not exist "%appdata%\%~1" (
  if not exist "%LocalAppData%\%~1" (
    echo Error: No such program - %~1
    echo Check to make sure %appdata%\%~1
    echo or %LocalAppData%\%~1 exists.
    exit /B 1
  )
)

:: Check for second argument (destination)
if "%~2"=="" (
  echo Error: You must provide a destination directory.
  echo Type cleansquirrel.bat /HELP for help.
  exit /B 1
)

if not exist %~2 (
  mkdir "%~2"
)

:: Will use existing directories if they exist
mkdir "%~2\Roaming"
mkdir "%~2\Local"

:: Move roaming appdata to new directory and clean old
if exist "%appdata%\%~1" (
  robocopy "%appdata%\%~1" "%~2\Roaming" /E
  rmdir /S "%appdata%\%~1"
)

:: Move local appdata to new directory and clean old
if exist "%LocalAppData%\%~1" (
  robocopy "%LocalAppData%\%~1" "%~2\Local" /E
  rmdir /S "%LocalAppData%\%~1"
)

:: Create symlinks for any future references
mklink /D "%appdata%\%~1" "%~2\Roaming"
mklink /D "%LocalAppData%\%~1" "%~2\Local"
