@echo off

Title brpsa premake script
set scriptversion=v1.0.1

REM exclusive for blefonix rp
REM by blefony(trevor_fair)

for /f "delims=" %%i in ('wmic useraccount where "name='%UserName%'" get sid /value') do (
  for /f "delims=" %%j in ("%%i") do set "%%j"
)

pushd %~dp0 >nul 2>&1

if exist "*.log" del /s /q "*.log"
if exist "$brpsa-settings.ini" del /s /q "$brpsa-settings.ini"

if exist "101-enabled-single" @RD /s /q "101-enabled-single"
if exist "101-enabled-mtasa" @RD /s /q "101-enabled-mtasa"
if exist "101-enabled-rhook" @RD /s /q "101-enabled-rhook"

cd cache
if exist "127.0.0.1.7878" @RD /s /q "127.0.0.1.7878"
cd ..
