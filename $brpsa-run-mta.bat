@echo off

color 17
set scriptversion=v1.0.1
set brpmode=MTA
set running=Done. Starting Blefonix RolePlay %brpmode%
set help=[Help] If you need help, please write to Blefonix RolePlay Discord: https://discord.gg/n2FPfqwh2g
Title Blefonix RolePlay %brpmode%

echo.
echo  Blefonix RolePlay %brpmode% (Runner %scriptversion%)
echo  Exclusive for Blefonix RolePlay by blefony(Trevor_Fair)
echo  https://github.com/brpsamp/brpsa-multisa
echo.

REM Gets the SID of the current logged in user, needed for wiping the registry values which cause issues.

for /f "delims=" %%i in ('wmic useraccount where "name='%UserName%'" get sid /value') do (
  for /f "delims=" %%j in ("%%i") do set "%%j"
)

REM Sets batch file dir as working directory, since batch files ran as admin use system32 by default.

pushd %~dp0 >nul 2>&1

REM Checks existance of problematic registry keys and deletes them thereafter, plus giving out proper message.

REG Query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" >nul 2>&1
if %errorlevel%==0 (
	REG Delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /f
	@REM echo. [startup util] Registry entry #1 successfully deleted!
) else (
	@REM echo. [startup util] Registry entry #1 not found, skipping.
)

REG Query "HKEY_USERS\%SID%\Software\Microsoft\Internet Explorer\LowRegistry\Audio\PolicyConfig\PropertyStore" >nul 2>&1
if %errorlevel%==0 (
	REG Delete "HKEY_USERS\%SID%\Software\Microsoft\Internet Explorer\LowRegistry\Audio\PolicyConfig\PropertyStore" /f
	@REM echo. [startup util] Registry entry #2 successfully deleted!
) else (
	@REM echo. [startup util] Registry entry #2 not found, skipping.
)

REG Query "HKEY_USERS\%SID%\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" >nul 2>&1
if %errorlevel%==0 (
	REG Delete "HKEY_USERS\%SID%\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /f
	@REM echo. [startup util] Registry entry #3 successfully deleted!
) else (
	@REM echo. [startup util] Registry entry #3 not found, skipping.
)

REG Query "HKEY_USERS\%SID%_Classes\VirtualStore\MACHINE\SOFTWARE\Wow6432Node\Microsoft\Direct3D\MostRecentApplication" >nul 2>&1
if %errorlevel%==0 (
	REG Delete "HKEY_USERS\%SID%_Classes\VirtualStore\MACHINE\SOFTWARE\Wow6432Node\Microsoft\Direct3D\MostRecentApplication" /f
	@REM echo. [startup util] Registry entry #4 successfully deleted!
) else (
	@REM echo. [startup util] Registry entry #4 not found, skipping.
)

REG Query "HKEY_USERS\%SID%_Classes\VirtualStore\MACHINE\SOFTWARE\Wow6432Node\Microsoft\DirectDraw\MostRecentApplication" >nul 2>&1
if %errorlevel%==0 (
	REG Delete "HKEY_USERS\%SID%_Classes\VirtualStore\MACHINE\SOFTWARE\Wow6432Node\Microsoft\DirectDraw\MostRecentApplication" /f
	@REM echo. [startup util] Registry entry #5 successfully deleted!
) else (
	@REM echo. [startup util] Registry entry #5 not found, skipping.
)

REM File renaming and game running.

if not exist $brpsa-settings.ini (
	$brpsa-settings.bat
) else (
	if exist mtasa (
		if exist reshade-shaders ren reshade-shaders render
		if exist imfast.asi ren imfast.asi imfast.asi_
		if exist "101-enabled-single" ren "101-enabled-single" "101-enabled-mtasa"
		if exist "101-enabled-samp" ren "101-enabled-samp" "101-enabled-mtasa"
		if exist "101-enabled-rhook" ren "101-enabled-samp" "101-enabled-mtasa"
		if not exist "101-enabled-mtasa" mkdir "101-enabled-mtasa"
		if exist data (
			if not exist datasp ren data datasp
			if exist datam ren datam data
		) else (
			if exist datam ren datam data
		)
		if exist libcurl.dll ren libcurl.dll #libcurl.dll_
		cd mtasa
		echo. %running%
		"Multi Theft Auto.exe"
	)
)
