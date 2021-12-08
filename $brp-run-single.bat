@echo off

color 17
set scriptversion=v1.0.1
set brpmode=SinglePlayer
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
	if exist "101-enabled-samp" ren "101-enabled-samp" "101-enabled-single"
	if exist "101-enabled-mtasa" ren "101-enabled-mtasa" "101-enabled-single"
	if exist "101-enabled-rhook" ren "101-enabled-rhook" "101-enabled-single"
	if not exist "101-enabled-single" mkdir "101-enabled-single"
	if exist data (
		if not exist datam ren data datam
		if exist datasp ren datasp data
	) else (
		if exist datasp ren datasp data
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
	REM disable samp...
	if exist samp.dll ren samp.dll #samp.dll_
	if exist samp.asi ren samp.asi #samp.asi_
	if exist #libcurl.dll_ ren #libcurl.dll_ libcurl.dll
	if exist sampar.dll ren sampar.dll #sampar.dll_
	if exist connection.asi ren connection.asi #connection.asi_
	REM toggle fastman92...
	if exist fastman92limitAdjuster_GTASA.ini (
		if not exist $fastman92limAdjuster.mp_ ren fastman92limitAdjuster_GTASA.ini $fastman92limAdjuster.mp_
		if not exist $fastman92limAdjuster.sp_ ren fastman92limitAdjuster_GTASA.ini $fastman92limAdjuster.sp_
		if not exist $fastman92limAdjuster.rh_ ren fastman92limitAdjuster_GTASA.ini $fastman92limAdjuster.rh_
		if exist $fastman92limAdjuster.sp_ (
			ren $fastman92limAdjuster.sp_ fastman92limitAdjuster_GTASA.ini
			if exist fastman92limitAdjuster_GTASA.ini (
				REM Start the GTA SA SP after everything is done.
				echo. %running%
				taskkill /IM samp.exe /F
				start gta_sa.exe
			) else (
				echo. %error%
				echo. %help%
				pause
			)
		) else (
			echo. %error%
			echo. %help%
			pause
		)
	)
)
