//Discord API
#if desktop
import mainGame.backend.system.Discord;
#end

//Psych
#if LUA_ALLOWED
import llua.*;
import llua.Lua;
#end

#if(!macro) import mainGame.backend.Paths; #end
import mainGame.backend.Controls;
import mainGame.backend.CoolUtil;
import mainGame.backend.MusicBeatState;
import mainGame.backend.MusicBeatSubstate;
import mainGame.backend.CustomFadeTransition;
import mainGame.backend.data.ClientPrefs;
import mainGame.backend.Conductor;
import mainGame.backend.BaseStage;
import mainGame.backend.Difficulty;
import mainGame.backend.Mods;

import mainGame.objects.Alphabet;
import mainGame.objects.sprites.BGSprite;

import mainGame.states.PlayState;
import mainGame.states.LoadingState;

//Flixel
#if (flixel >= "5.3.0")
import flixel.sound.FlxSound;
#else
import flixel.system.FlxSound;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;

using StringTools;