@echo off
color 05
cd ..
@echo on
echo BUILDING GAME Html
haxelib run lime test html5 -release
pause