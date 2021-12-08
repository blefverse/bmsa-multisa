@echo off

color 17
set scriptversion=v1.0.1
set brpmode=RenderHook
set running=Done. Starting Blefonix RolePlay %brpmode%
set error=[Error] Check if $fastman92limAdjuster.mp_, $fastman92limAdjuster.sp_, $fastman92limAdjuster.rh_ files exists in your game folder.
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
	if exist d3d11.dll_ ren d3d11.dll_ d3d11.dll
	if exist timecycle24.asi ren timecycle24.asi timecycle24.asi_
	if exist _gtaRenderHook.asi_ ren _gtaRenderHook.asi_ _gtaRenderHook.asi
	if exist AntTweakBar.dll_ ren AntTweakBar.dll_ AntTweakBar.dll
	if exist settings.xml_ ren settings.xml_ settings.xml
	if exist modloader ren modloader modloader_
	if exist modrhook ren modrhook modloader
	if exist render ren render reshade-shaders
	if exist imfast.asi_ ren imfast.asi_ imfast.asi
	if exist "101-enabled-samp" ren "101-enabled-samp" "101-enabled-rhook"
	if exist "101-enabled-single" ren "101-enabled-single" "101-enabled-rhook"
	if exist "101-enabled-mtasa" ren "101-enabled-mtasa" "101-enabled-rhook"
	if not exist "101-enabled-rhook" mkdir "101-enabled-rhook"
	if exist data (
		if not exist datasp ren data datasp
		if exist datam ren datam data
	) else (
		if exist datam ren datam data
	)
	REM disable samp...
	if exist samp.dll ren samp.dll #samp.dll_
	if exist samp.asi ren samp.asi #samp.asi_
	if exist #libcurl.dll_ ren #libcurl.dll_ libcurl.dll
	if exist sampar.dll ren sampar.dll #sampar.dll_
	if exist connection.asi ren connection.asi #connection.asi_
	REM toggle fastman92...
	if exist fastman92limitAdjuster_GTASA.ini (
		@REM if exist $fastman92limAdjuster.rh_ (
		if not exist $fastman92limAdjuster.mp_ ren fastman92limitAdjuster_GTASA.ini $fastman92limAdjuster.mp_
		if not exist $fastman92limAdjuster.sp_ ren fastman92limitAdjuster_GTASA.ini $fastman92limAdjuster.sp_
		if not exist $fastman92limAdjuster.rh_ ren fastman92limitAdjuster_GTASA.ini $fastman92limAdjuster.rh_
		if exist $fastman92limAdjuster.rh_ ren $fastman92limAdjuster.rh_ fastman92limitAdjuster_GTASA.ini
		if exist fastman92limitAdjuster_GTASA.ini (
			REM Start the GTA SA SP after everything is done.
			echo. %running%
			echo.
			echo.
			echo    The startup window may be hidden behind
			echo    other windows. Find it and click Ok to run.
			echo.
			echo.	Known issues
			echo    1. If game crash with CLEO warning,
			echo    close gta_rhook.exe in task manager.
			echo    2. If game crash with _gtaRenderHook.asi,
			echo    try to reboot your computer.
			echo.
			echo    https://discord.gg/d8PA6wqrnQ
			echo.
			taskkill /IM samp.exe /F >nul 2>&1
			start gta_rhook.exe
			pause
		)
	) else (
		if not exist $fastman92limAdjuster.mp_ ren fastman92limitAdjuster_GTASA.ini $fastman92limAdjuster.mp_
		if not exist $fastman92limAdjuster.sp_ ren fastman92limitAdjuster_GTASA.ini $fastman92limAdjuster.sp_
		if exist $fastman92limAdjuster.rh_ ren $fastman92limAdjuster.rh_ fastman92limitAdjuster_GTASA.ini
		echo. %running%
		echo.
		echo.
		echo    The startup window may be hidden behind
		echo    other windows. Find it and click Ok to run.
		echo.
		taskkill /IM samp.exe /F >nul 2>&1
		start gta_rhook.exe
		pause
	)
)
