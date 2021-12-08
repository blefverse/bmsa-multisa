@echo off

color 17
set scriptversion=v1.0
set brpmode=SAMP
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
	if exist d3d11.dll ren d3d11.dll d3d11.dll_
	if exist timecycle24.asi_ ren timecycle24.asi_ timecycle24.asi
	if exist reshade-shaders ren reshade-shaders render
	if exist imfast.asi ren imfast.asi imfast.asi_
	if not exist "!enabled_1.0.0_samp" (
		if exist "!enabled_1.0.0_single" ren "!enabled_1.0.0_single" "!enabled_1.0.0_samp" NUL
		if exist "!enabled_1.0.0_mtasa" ren "!enabled_1.0.0_mtasa" "!enabled_1.0.0_samp" NUL
		if exist "!enabled_1.0.0_rhook" ren "!enabled_1.0.0_rhook" "!enabled_1.0.0_samp" NUL
	)
	if exist data (
		if not exist datasp ren data datasp
		if exist datam ren datam data
	) else (
		if exist datam ren datam data
	)
	if exist _gtaRenderHook.asi ren _gtaRenderHook.asi _gtaRenderHook.asi_
	if exist AntTweakBar.dll ren AntTweakBar.dll AntTweakBar.dll_
	if exist settings.xml ren settings.xml settings.xml_
	if not exist modrhook (
		if exist modloader (
			ren modloader modrhook
			ren modloader_ modloader
		)
	)
	if exist #samp.dll_ ren #samp.dll_ samp.dll
	if exist #samp.asi_ ren #samp.asi_ samp.asi
	if exist #libcurl.dll_ ren #libcurl.dll_ libcurl.dll
	if exist #connection.asi_ ren #connection.asi_ connection.asi
	if exist #sampar.dll_ ren #sampar.dll_ sampar.dll
	if exist d3d9.dll del d3d9.dll /f /q
	if exist fastman92limitAdjuster_GTASA.ini (
		if not exist $fastman92limAdjuster.mp_ ren fastman92limitAdjuster_GTASA.ini $fastman92limAdjuster.mp_
		if not exist $fastman92limAdjuster.sp_ ren fastman92limitAdjuster_GTASA.ini $fastman92limAdjuster.sp_
		if not exist $fastman92limAdjuster.rh_ ren fastman92limitAdjuster_GTASA.ini $fastman92limAdjuster.rh_
		if exist $fastman92limAdjuster.mp_ ren $fastman92limAdjuster.mp_ fastman92limitAdjuster_GTASA.ini
		if exist fastman92limitAdjuster_GTASA.ini (
			REM Start the GTA SA MP after everything is done.
			echo. %running%
			taskkill /IM samp.exe /F
			start samp.exe
		) else (
			if exist $fastman92limAdjuster.mp_ ren $fastman92limAdjuster.mp_ fastman92limitAdjuster_GTASA.ini
			REM Start the GTA SA MP after everything is done.
			echo. %running%
			taskkill /IM samp.exe /F
			start samp.exe
		)
	)
)
