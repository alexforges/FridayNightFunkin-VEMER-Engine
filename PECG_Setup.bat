@echo off
title Setup - PECG
cd ..
echo WARNING: This is made for experimental branch of Psych Engine (https://github.com/ShadowMario/FNF-PsychEngine/tree/experimental)
echo Installing dependencies, please wait...
haxelib --global update haxelib
haxelib install lime
haxelib run lime setup
haxelib install openfl
haxelib run openfl setup
haxelib install flixel
haxelib run lime setup flixel
haxelib install flixel-tools
haxelib run flixel-tools setup
haxelib install tjson
haxelib install SScript
haxelib install hxCodec
haxelib install hxcpp
haxelib install hxcpp-debug-server
haxelib git linc_luajit https://github.com/superpowers04/linc_luajit
haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc
echo Done!
cls
echo Installing Visual Studio, please wait...
curl -# -O https://download.visualstudio.microsoft.com/download/pr/3105fcfe-e771-41d6-9a1c-fc971e7d03a7/8eb13958dc429a6e6f7e0d6704d43a55f18d02a253608351b6bf6723ffdaf24e/vs_Community.exe
vs_Community.exe --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.Windows10SDK.19041 -p
del vs_Community.exe
echo Finished!
echo Press any key to exit.
pause >nul