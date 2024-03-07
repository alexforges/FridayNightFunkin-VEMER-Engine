package mainGame.substates;

import mainGame.backend.system.Aplication;
import mainGame.backend.data.WeekData;
import mainGame.backend.Highscore;
import mainGame.backend.Song;

import flixel.addons.transition.FlxTransitionableState;

import flixel.util.FlxStringUtil;

import flixel.FlxSprite;

import mainGame.states.menu.StoryMenuState;
import mainGame.states.menu.FreeplayState;
import mainGame.states.menu.options.OptionsState;

import mainGame.backend.TranslationUtil;

//app
import lime.app.Application;

class PauseSubState extends MusicBeatSubstate
{
	var grpMenuShit:FlxTypedGroup<Alphabet>;

	var menuItems:Array<String> = [];
	var menuItemsOG:Array<String> = [];
	var menuItemsEN:Array<String> = ['Resume', 'Restart Song', 'Change Difficulty', 'Options', 'Exit to menu'];
	var menuItemsRU:Array<String> = ['Пpoдoлжиtь', 'Пepeзапуctиtь Пechю', 'Изmehиtь Cлoжhoctь', 'Hаctpoйkи', 'Выйtи в mehю'];
	var difficultyChoices = [];
	var curSelected:Int = 0;

	var pauseMusic:FlxSound;
	var practiceText:FlxText;
	var skipTimeText:FlxText;
	var skipTimeTracker:Alphabet;
	var curTime:Float = Math.max(0, Conductor.songPosition);

	var bg:FlxSprite;
	var item:Alphabet;

	var missingTextBG:FlxSprite;
	var missingText:FlxText;

	var hih:FlxSprite;

	var canControl:Bool = true;

	public static var songName:String = '';

	var kosar:Int = 0;

	public function new(x:Float, y:Float)
	{
		super();
		if(Difficulty.list.length < 2) menuItemsOG.remove('Change Difficulty'); //No need to change difficulty if there is only one!


		//kosar = PlayState.kosarVerni;

		if(canControl == false) canControl = true;

		if(PlayState.instance.cpuControlled)
			Aplication.setText('Paused: ${PlayState.SONG.song}', true, 'Botplay');
		else
			Aplication.setText('Paused: ${PlayState.SONG.song}');

		switch(ClientPrefs.data.gameLanguage)
		{		
			case 'Russian':
				menuItemsOG = menuItemsRU;
				if(Difficulty.list.length < 2) menuItemsOG.remove('Изmehиtь Cлoжhoctь'); //No need to change difficulty if there is only one!

				if(PlayState.chartingMode)
				{
					menuItemsOG.insert(2, 'Выйtи из peжиmа peдаktopа');
					
					var num:Int = 0;
					if(!PlayState.instance.startingSong)
					{
						num = 1;
						menuItemsOG.insert(3, 'Пропустить Время');
					}
					menuItemsOG.insert(3 + num, 'Заkohчиtь пechю');
					menuItemsOG.insert(4 + num, 'Peжиm Пpаktиkи');
					menuItemsOG.insert(5 + num, 'Peжиm Бotа');
				}
			default:	
				menuItemsOG = menuItemsEN;
				if(Difficulty.list.length < 2) menuItemsOG.remove('Change Difficulty'); //No need to change difficulty if there is only one!

				if(PlayState.chartingMode)
				{
					menuItemsOG.insert(2, 'Leave Charting Mode');
					
					var num:Int = 0;
					if(!PlayState.instance.startingSong)
					{
						num = 1;
						menuItemsOG.insert(3, 'Skip Time');
					}
					menuItemsOG.insert(3 + num, 'End Song');
					menuItemsOG.insert(4 + num, 'Toggle Practice Mode');
					menuItemsOG.insert(5 + num, 'Toggle Botplay');
				}
		}
		menuItems = menuItemsOG;

		for (i in 0...Difficulty.list.length) {
			var diffNoCorrect:String = Difficulty.getString(i);	
			var diff:String = diffNoCorrect;
			var diffTranslate:String = diffNoCorrect;
			switch(ClientPrefs.data.gameLanguage)
			{
				case 'Russian':
					diffTranslate = TranslationUtil.ruDiffFormat(Difficulty.TranslateENToRU(diffNoCorrect));
				default:
					diffTranslate = diffNoCorrect;
			}
			diff = diffTranslate;
			difficultyChoices.push(diff);
		}

		switch(ClientPrefs.data.gameLanguage)
		{
			case 'Russian':
				difficultyChoices.push('HАЗАД');
			default:
				difficultyChoices.push('BACK');
		}



		pauseMusic = new FlxSound();
		if(songName != null) {
			pauseMusic.loadEmbedded(Paths.music(songName), true, true);
		} else if (songName != 'None') {
			pauseMusic.loadEmbedded(Paths.music(Paths.formatToSongPath(ClientPrefs.data.pauseMusic)), true, true);
		}
		pauseMusic.volume = 0;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

		FlxG.sound.list.add(pauseMusic);

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		hih = new FlxSprite().loadGraphic(Paths.image('pause/'+ PlayState.SONG.song));
		//hih.screenCenter();
		hih.antialiasing = ClientPrefs.data.antialiasing;
		if(hih !=null) add(hih);
		hih.alpha = 0;
		hih.x = 25;

		var levelInfo:FlxText = new FlxText(20, 15, 0, PlayState.SONG.song, 32);
		levelInfo.scrollFactor.set();
		levelInfo.setFormat(Paths.font("vcr.ttf"), 32);
		levelInfo.updateHitbox();
		add(levelInfo);

		var levelDifficulty:FlxText = new FlxText(20, 15 + 32, 0, Difficulty.getString().toUpperCase(), 32);
		levelDifficulty.scrollFactor.set();
		levelDifficulty.setFormat(Paths.font('vcr.ttf'), 32);
		levelDifficulty.updateHitbox();
		add(levelDifficulty);

		var blueballedTxt:FlxText = new FlxText(20, 15 + 64, 0, "Blueballed: " + PlayState.deathCounter, 32);
		blueballedTxt.scrollFactor.set();
		blueballedTxt.setFormat(Paths.font('vcr.ttf'), 32);
		blueballedTxt.updateHitbox();
		add(blueballedTxt);

		practiceText = new FlxText(20, 15 + 101, 0, "PRACTICE MODE", 32);
		practiceText.scrollFactor.set();
		practiceText.setFormat(Paths.font('vcr.ttf'), 32);
		practiceText.x = FlxG.width - (practiceText.width + 20);
		practiceText.updateHitbox();
		practiceText.visible = PlayState.instance.practiceMode;
		add(practiceText);

		var chartingText:FlxText = new FlxText(20, 15 + 101, 0, "CHARTING MODE", 32);
		chartingText.scrollFactor.set();
		chartingText.setFormat(Paths.font('vcr.ttf'), 32);
		chartingText.x = FlxG.width - (chartingText.width + 20);
		chartingText.y = FlxG.height - (chartingText.height + 20);
		chartingText.updateHitbox();
		chartingText.visible = PlayState.chartingMode;
		add(chartingText);

		blueballedTxt.alpha = 0;
		levelDifficulty.alpha = 0;
		levelInfo.alpha = 0;

		levelInfo.x = FlxG.width - (levelInfo.width + 20);
		levelDifficulty.x = FlxG.width - (levelDifficulty.width + 20);
		blueballedTxt.x = FlxG.width - (blueballedTxt.width + 20);

		FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(levelInfo, {alpha: 1, y: 20}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
		FlxTween.tween(levelDifficulty, {alpha: 1, y: levelDifficulty.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.5});
		FlxTween.tween(blueballedTxt, {alpha: 1, y: blueballedTxt.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.7});
		if(hih !=null) FlxTween.tween(hih, {alpha: 1, x: 0}, 0.55, {ease: FlxEase.quartInOut});

		grpMenuShit = new FlxTypedGroup<Alphabet>();
		add(grpMenuShit);

		missingTextBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		missingTextBG.alpha = 0.6;
		missingTextBG.visible = false;
		add(missingTextBG);
		
		missingText = new FlxText(50, 0, FlxG.width - 100, '', 24);
		missingText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		missingText.scrollFactor.set();
		missingText.visible = false;
		add(missingText);

		regenMenu();
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	var holdTime:Float = 0;
	var cantUnpause:Float = 0.1;
	override function update(elapsed:Float)
	{
		cantUnpause -= elapsed;
		if (pauseMusic.volume < 0.5)
			pauseMusic.volume += 0.01 * elapsed;

		super.update(elapsed);
		updateSkipTextStuff();

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var accepted = controls.ACCEPT;

		if(canControl == true){
			if (upP)
				{
					changeSelection(-1);
				}
			if (downP)
				{
					changeSelection(1);
				}
		}
		var daSelected:String = menuItems[curSelected];
		switch (daSelected)
		{
			case 'Skip Time' | 'Пропустить Время':
				if (controls.UI_LEFT_P)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
					curTime -= 1000;
					holdTime = 0;
				}
				if (controls.UI_RIGHT_P)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
					curTime += 1000;
					holdTime = 0;
				}

				if(controls.UI_LEFT || controls.UI_RIGHT)
				{
					holdTime += elapsed;
					if(holdTime > 0.5)
					{
						curTime += 45000 * elapsed * (controls.UI_LEFT ? -1 : 1);
					}

					if(curTime >= FlxG.sound.music.length) curTime -= FlxG.sound.music.length;
					else if(curTime < 0) curTime += FlxG.sound.music.length;
					updateSkipTimeText();
				}
		}

		if (accepted && (cantUnpause <= 0 || !controls.controllerMode))
		{
			if (menuItems == difficultyChoices)
			{
				try{
					if(menuItems.length - 1 != curSelected && difficultyChoices.contains(daSelected)) {

						var name:String = PlayState.SONG.song;
						var poop = Highscore.formatSong(name, curSelected);
						PlayState.SONG = Song.loadFromJson(poop, name);
						PlayState.storyDifficulty = curSelected;
						MusicBeatState.resetState();
						FlxG.sound.music.volume = 0;
						PlayState.changedDifficulty = true;
						PlayState.chartingMode = false;
						return;
					}					
				}catch(e:Dynamic){
					trace('ERROR! $e');

					var errorStr:String = e.toString();
					if(errorStr.startsWith('[file_contents,assets/data/')) errorStr = 'Missing file: ' + errorStr.substring(27, errorStr.length-1); //Missing chart
					missingText.text = 'ERROR WHILE LOADING CHART:\n$errorStr';
					missingText.screenCenter(Y);
					missingText.visible = true;
					missingTextBG.visible = true;
					FlxG.sound.play(Paths.sound('cancelMenu'));

					super.update(elapsed);
					return;
				}


				menuItems = menuItemsOG;
				regenMenu();
			}

			switch (daSelected)
			{
				case "Resume" | "Пpoдoлжиtь":
					if(canControl == true){

						canControl = false;

						FlxG.sound.play(Paths.sound('confirmMenu'));
					}

					if(hih !=null)FlxTween.tween(hih, {alpha: 0, x: 25}, 0.55, {ease: FlxEase.quartInOut});

					FlxTween.tween(bg, {alpha: 0}, 0.65, {
						ease: FlxEase.quadOut,
						onComplete: function(twn:FlxTween)
						{
							close();
						}
					});


					case 'Change Difficulty' | "Изmehиtь Cлoжhoctь":
						menuItems = difficultyChoices;
						deleteSkipTimeText();
						regenMenu();
					case 'Toggle Practice Mode' | "Peжиm Пpаktиkи":
						PlayState.instance.practiceMode = !PlayState.instance.practiceMode;
						PlayState.changedDifficulty = true;
						practiceText.visible = PlayState.instance.practiceMode;
					case "Restart Song" | "Пepeзапуctиtь Пechю":
						restartSong();
					case "Leave Charting Mode" | "Выйtи из peжиmа peдаktopа":
						restartSong();
						PlayState.chartingMode = false;
					case 'Skip Time' | 'Пропустить Время':
						if(curTime < Conductor.songPosition)
						{
							PlayState.startOnTime = curTime;
							restartSong(true);
						}
						else
						{
							if (curTime != Conductor.songPosition)
							{
								PlayState.instance.clearNotesBefore(curTime);
								PlayState.instance.setSongTime(curTime);
							}
							close();
						}
					case 'End Song' | 'Заkohчиtь пechю':
						close();
						PlayState.instance.notes.clear();
						PlayState.instance.unspawnNotes = [];
						PlayState.instance.finishSong(true);
					case 'Toggle Botplay' | 'Peжиm Бotа':
						PlayState.instance.cpuControlled = !PlayState.instance.cpuControlled;
						PlayState.changedDifficulty = true;
						PlayState.instance.botplayTxt.visible = PlayState.instance.cpuControlled;
						PlayState.instance.botplayTxt.alpha = 1;
						PlayState.instance.botplaySine = 0;
					case 'Options' | 'Hаctpoйkи':
						PlayState.instance.paused = true; // For lua
						PlayState.instance.vocals.volume = 0;
						MusicBeatState.switchState(new OptionsState());
						if(ClientPrefs.data.pauseMusic != 'None')
						{
							FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.data.pauseMusic)), pauseMusic.volume);
							FlxTween.tween(FlxG.sound.music, {volume: 1}, 0.8);
							FlxG.sound.music.time = pauseMusic.time;
						}
						OptionsState.onPlayState = true;
					case "Exit to menu" | "Выйtи в mehю":
						#if desktop DiscordClient.resetClientID(); #end
						PlayState.deathCounter = 0;
						PlayState.seenCutscene = false;	

					Mods.loadTopMod();
					if(PlayState.isStoryMode) {
						MusicBeatState.switchState(new StoryMenuState());
					} else {
						MusicBeatState.switchState(new FreeplayState());
					}
					PlayState.cancelMusicFadeTween();
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
					PlayState.changedDifficulty = false;
					PlayState.chartingMode = false;
					FlxG.camera.followLerp = 0;
			}
		}
	}

	function deleteSkipTimeText()
	{
		if(skipTimeText != null)
		{
			skipTimeText.kill();
			remove(skipTimeText);
			skipTimeText.destroy();
		}
		skipTimeText = null;
		skipTimeTracker = null;
	}

	public static function restartSong(noTrans:Bool = false)
	{
		PlayState.instance.paused = true; // For lua
		FlxG.sound.music.volume = 0;
		PlayState.instance.vocals.volume = 0;

		if(noTrans)
		{
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
		}
		MusicBeatState.resetState();
	}

	override function destroy()
	{
		pauseMusic.destroy();

		super.destroy();
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpMenuShit.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));

				if(item == skipTimeTracker)
				{
					curTime = Math.max(0, Conductor.songPosition);
					updateSkipTimeText();
				}
			}
		}
		missingText.visible = false;
		missingTextBG.visible = false;
	}



	function regenMenu():Void {
		for (i in 0...grpMenuShit.members.length) {
			var obj = grpMenuShit.members[0];
			obj.kill();
			grpMenuShit.remove(obj, true);
			obj.destroy();
		}

		for (i in 0...menuItems.length) {
			item = new Alphabet(90, 320, menuItems[i], true);
			item.isMenuItem = true;
			item.targetY = i;
			grpMenuShit.add(item);

			if(menuItems[i] == 'Skip Time')
			{
				skipTimeText = new FlxText(0, 0, 0, '', 64);
				skipTimeText.setFormat(Paths.font("vcr.ttf"), 64, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				skipTimeText.scrollFactor.set();
				skipTimeText.borderSize = 2;
				skipTimeTracker = item;
				add(skipTimeText);

				updateSkipTextStuff();
				updateSkipTimeText();
			}
		}
		curSelected = 0;
		changeSelection();
	}
	
	function updateSkipTextStuff()
	{
		if(skipTimeText == null || skipTimeTracker == null) return;

		skipTimeText.x = skipTimeTracker.x + skipTimeTracker.width + 60;
		skipTimeText.y = skipTimeTracker.y;
		skipTimeText.visible = (skipTimeTracker.alpha >= 1);
	}

	function updateSkipTimeText()
	{
		skipTimeText.text = FlxStringUtil.formatTime(Math.max(0, Math.floor(curTime / 1000)), false) + ' / ' + FlxStringUtil.formatTime(Math.max(0, Math.floor(FlxG.sound.music.length / 1000)), false);
	}
}
