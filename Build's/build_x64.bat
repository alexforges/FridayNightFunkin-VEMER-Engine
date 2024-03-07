@echo off
color 05
cd ..
echo BUILDING GAME x64
haxelib run lime build windows -release
echo.
echo done.
pause
pwd
explorer.exe export\release\windows\bin