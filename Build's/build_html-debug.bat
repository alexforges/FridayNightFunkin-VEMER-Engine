@echo off
color 05
cd ..
@echo on
echo BUILDING GAME html (DEBUG)
haxelib run lime test html5 -debug
pause