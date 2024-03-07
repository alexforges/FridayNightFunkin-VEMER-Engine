@echo off
color 05
title FNF VEMER Engine Setup - Start
echo Make sure Haxe 4.2.5 (it's verry need)
echo Press any key to install required libraries.
pause >nul
title FNF VEMER Engine Setup - Installing libraries Pack
echo Removing haxelib libraries...

haxelib remove discord_rpc

haxelib remove flixel-addons

haxelib remove flixel-tools

haxelib remove flixel-ui

haxelib remove flixel

haxelib remove tjson

haxelib remove hxCodec

haxelib remove lime

haxelib remove linc_luajit

haxelib remove openfl

haxelib remove hxcpp-debug-server

haxelib remove hmm

cls
title FNF Setup - Success
echo Remove lib successful. Press any key to exit.
pause >nul
exit
