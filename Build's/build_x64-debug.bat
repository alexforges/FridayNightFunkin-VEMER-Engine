@echo off
color 05
cd ..
echo BUILDING GAMEx 64 (DEBUG)
haxelib run lime build windows -debug
echo.
echo done.
pause
pwd
explorer.exe export\debug\windows\bin