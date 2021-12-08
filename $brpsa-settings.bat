@echo off

title blefonix rp settings
set scriptversion = v1.0

REM change brpsa settings like
REM mods, graphics, and others
REM exclusive for blefonix rp
REM by blefony(trevor_fair)
REM https://github.com/brpsamp/brpsa-multisa

setlocal EnableDelayedExpansion

@REM ============================================================

for /f "delims=" %%i in ('wmic useraccount where "name='%UserName%'" get sid /value') do (
  for /f "delims=" %%j in ("%%i") do set "%%j"
)
pushd %~dp0 >nul 2>&1

@REM ============================================================

if not exist $brpsa-settings.ini (
    echo.
    echo Generating a game settings file...
    echo ; Blefonix RolePlay Settings > $brpsa-settings.ini
    echo Settings file generated successfully.
    echo Let's customize the game for you!
    echo.
) else (
    echo.
    echo Game settings file is found.
    echo Let's customize it for you!
    echo.
)

@REM ============================================================

if not exist modrhook (
    if exist modloader (
        ren modloader modrhook
        ren modloader_ modloader
    )
)

echo. [1/2]
echo Select the modpack you want.
echo Type number...
:loop
    echo 1. minimal + low graphic
    echo 2. medium and essentials
    echo 3. full and good graphic
    echo 4. skip
    set /p modpack=
    goto end
:end

if %modpack% == 1 (
    initool s $brpsa-settings.ini "" modpack 1 > tempbrp.ini
    move /y tempbrp.ini $brpsa-settings.ini >NUL
    if exist wshps.asi ren wshps.asi wshps.asi_
    cd modloader
    if exist 2-animdoor ren 2-animdoor ".(2)-animdoor"
    if exist 2-exgangwars ren 2-exgangwars ".(2)-exgangwars"
    if exist 2-sampfixes ren 2-sampfixes ".(2)-sampfixes"
    if exist 2-skygrad ren 2-skygrad ".(2)-skygrad"
    if exist 2-wscreenfix ren 2-wscreenfix ".(2)-wscreenfix"
    if exist 3-playerretex ren 3-playerretex ".(3)-playerretex"
    if exist 3-skygfx ren 3-skygfx ".(3)-skygfx"
    if exist 4-betterveg ren 4-betterveg ".(4)-betterveg"
    if exist 4-carcolsfix ren 4-carcolsfix ".(4)-carcolsfix"
    if exist 4-custldscr ren 4-custldscr ".(4)-custldscr"
    if exist 4-gtweaker ren 4-gtweaker ".(4)-gtweaker"
    if exist 4-immerse ren 4-immerse ".(4)-immerse"
    if exist 4-interface ren 4-interface ".(4)-interface"
    if exist 4-maispostes ren 4-maispostes ".(4)-maispostes"
    if exist 4-normalmap ren 4-normalmap ".(4)-normalmap"
    if exist 4-population ren 4-population ".(4)-population"
    if exist 4-prelighfixes ren 4-prelighfixes ".(4)-prelighfixes"
    if exist 4-realskybox ren 4-realskybox ".(4)-realskybox"
    if exist 4-salodlights ren 4-salodlights ".(4)-salodlights"
    if exist 4-greenpiece ren 4-greenpiece ".(4)-greenpiece"
    cd ..
)

if %modpack% == 2 (
    initool s $brpsa-settings.ini "" modpack 2 > tempbrp.ini
    move /y tempbrp.ini $brpsa-settings.ini >NUL
    if exist wshps.asi_ ren wshps.asi_ wshps.asi
    cd modloader
    if exist ".(2)-animdoor" ren ".(2)-animdoor" 2-animdoor
    if exist ".(2)-exgangwars" ren ".(2)-exgangwars" 2-exgangwars
    if exist ".(2)-sampfixes" ren ".(2)-sampfixes" 2-sampfixes
    if exist ".(2)-skygrad" ren ".(2)-skygrad" 2-skygrad
    if exist ".(2)-wscreenfix" ren ".(2)-wscreenfix" 2-wscreenfix
    if exist 3-playerretex ren 3-playerretex ".(3)-playerretex"
    if exist 3-skygfx ren 3-skygfx ".(3)-skygfx"
    if exist 4-betterveg ren 4-betterveg ".(4)-betterveg"
    if exist 4-carcolsfix ren 4-carcolsfix ".(4)-carcolsfix"
    if exist 4-custldscr ren 4-custldscr ".(4)-custldscr"
    if exist 4-gtweaker ren 4-gtweaker ".(4)-gtweaker"
    if exist 4-immerse ren 4-immerse ".(4)-immerse"
    if exist 4-interface ren 4-interface ".(4)-interface"
    if exist 4-maispostes ren 4-maispostes ".(4)-maispostes"
    if exist 4-normalmap ren 4-normalmap ".(4)-normalmap"
    if exist 4-population ren 4-population ".(4)-population"
    if exist 4-prelighfixes ren 4-prelighfixes ".(4)-prelighfixes"
    if exist ".(4)-realskybox" ren ".(4)-realskybox" 4-realskybox
    if exist 4-salodlights ren 4-salodlights ".(4)-salodlights"
    if exist 4-greenpiece ren 4-greenpiece ".(4)-greenpiece"
)

if %modpack% == 3 (
    initool s $brpsa-settings.ini "" modpack 3 > tempbrp.ini
    move /y tempbrp.ini $brpsa-settings.ini >NUL
    if exist wshps.asi_ ren wshps.asi_ wshps.asi
    cd modloader
    if exist ".(2)-animdoor" ren ".(2)-animdoor" 2-animdoor
    if exist ".(2)-exgangwars" ren ".(2)-exgangwars" 2-exgangwars
    if exist ".(2)-sampfixes" ren ".(2)-sampfixes" 2-sampfixes
    if exist ".(2)-skygrad" ren ".(2)-skygrad" 2-skygrad
    if exist ".(2)-wscreenfix" ren ".(2)-wscreenfix" 2-wscreenfix
    if exist ".(3)-playerretex" ren ".(3)-playerretex" 3-playerretex
    if exist ".(3)-skygfx" ren ".(3)-skygfx" 3-skygfx
    if exist ".(4)-betterveg" ren ".(4)-betterveg" 4-betterveg
    if exist ".(4)-carcolsfix" ren ".(4)-carcolsfix" 4-carcolsfix
    if exist ".(4)-custldscr" ren ".(4)-custldscr" 4-custldscr
    if exist ".(4)-gtweaker" ren ".(4)-gtweaker" 4-gtweaker
    if exist ".(4)-immerse" ren ".(4)-immerse" 4-immerse
    if exist ".(4)-interface" ren ".(4)-interface" 4-interface
    if exist ".(4)-maispostes" ren ".(4)-maispostes" 4-maispostes
    if exist ".(4)-normalmap" ren ".(4)-normalmap" 4-normalmap
    if exist ".(4)-population" ren ".(4)-population" 4-population
    if exist ".(4)-prelighfixes" ren ".(4)-prelighfixes" 4-prelighfixes
    if exist ".(4)-realskybox" ren ".(4)-realskybox" 4-realskybox
    if exist ".(4)-salodlights" ren ".(4)-salodlights" 4-salodlights
    if exist ".(4)-greenpiece" ren ".(4)-greenpiece" 4-greenpiece
    cd ..
)

@REM ============================================================

echo.
echo Remember! If you see two folders or files
echo with the same name, just press F5 or fn+F5.
echo.
echo. [2/2]
echo The config file is ready.
echo What do you want to play?
echo Type number...
:loop
    echo 1. samp
    echo 2. single
    echo 3. mta
    echo 4. rhook (not recommended)
    echo 5. exit
    set /p choice=
    goto end
:end
if %choice% == 1 $brp-run-samp.bat
if %choice% == 2 $brp-run-single.bat
if %choice% == 3 $brpsa-run-mta.bat
if %choice% == 4 $brpsa-m-rhook.bat
