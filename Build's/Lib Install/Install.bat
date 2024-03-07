@echo off
color 05
title FNF VEMER Engine Setup - Start
echo Make sure Haxe 4.2.5 (it's verry need)
echo Press any key to install required libraries.
pause >nul
title FNF VEMER Engine Setup - Installing libraries Pack
echo Installing haxelib libraries...

haxelib remove discord_rpc
haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc.git

haxelib remove flixel-addons
haxelib install flixel-addons 3.0.2

haxelib remove flixel-tools
haxelib install flixel-tools 1.5.1

haxelib remove flixel-ui
haxelib install flixel-ui 2.5.0

haxelib remove flixel
haxelib install flixel 5.2.2

haxelib remove tjson
haxelib install tjson 1.4.0

haxelib remove hxCodec
haxelib git hxCodec https://github.com/polybiusproxy/hxCodec.git

haxelib remove lime
haxelib install lime 8.0.1

haxelib remove linc_luajit
haxelib git linc_luajit https://github.com/superpowers04/linc_luajit.git

haxelib remove openfl
haxelib install openfl 9.2.1

haxelib remove hxcpp-debug-server
haxelib install hxcpp-debug-server

haxelib install hmm
haxelib run hmm install

cls
title FNF VEMER Engine Setup - User action required
set /p menu="Would you like to install Visual Studio Community and components? (Necessary to compile/ 5.5GB) [Y/N]"
       if %menu%==Y goto InstallVSCommunity
       if %menu%==y goto InstallVSCommunity
       if %menu%==N goto SkipVSCommunity
       if %menu%==n goto SkipVSCommunity
       cls

:SkipVSCommunity
cls
title FNF Setup - Success
echo Warnign you need install SScript (discord:vemer to am gived you lib and Instruction).
pause >nul
cls
title FNF Setup - Success
echo Setup successful. Press any key to exit.
pause >nul
exit

:InstallVSCommunity
title FNF Setup - Installing Visual Studio Community
curl -# -O https://download.visualstudio.microsoft.com/download/pr/3105fcfe-e771-41d6-9a1c-fc971e7d03a7/8eb13958dc429a6e6f7e0d6704d43a55f18d02a253608351b6bf6723ffdaf24e/vs_Community.exe
vs_Community.exe --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 --add Microsoft.VisualStudio.Component.Windows10SDK.19041 -p
del vs_Community.exe
goto SkipVSCommunity