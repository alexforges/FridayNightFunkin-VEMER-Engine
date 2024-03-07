@echo off
color 05
cd ..
echo BUILDING GAME x64 (DEBUG)
haxelib run lime test windows -debug
echo.
echo done.
pause