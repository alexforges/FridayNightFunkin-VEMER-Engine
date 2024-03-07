package mainGame.states.menu;

import flixel.FlxSubState;

import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;

class FlashingState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	var warnTextTwo:FlxText;
	var whatText:Int = 0;
	var maxWhatText:Int = 2;
	var minWhatText:Int = -1;
    var infoWhatText:Int;
	var info:String;
	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		infoWhatText = maxWhatText - 1;


		warnText = new FlxText(0, 0, FlxG.width,
			"Hey, watch out!\n
			This Mod contains some flashing lights!\n
			And\n
			Many epileptic stuff so...\n
			Press ENTER to disable them now or go to Options Menu.\n
			Press ESCAPE to ignore this message.\n
			You've been warned!\n"+info,
			32);
		warnText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		add(warnText);

		warnTextTwo = new FlxText(0, 0, FlxG.width,
			"thanks for downloading VEMER Engine \nEnjoy :P \n"+info,32);
		warnTextTwo.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER);
		warnTextTwo.screenCenter(Y);
		add(warnTextTwo);

	}

	override function update(elapsed:Float)
	{

		info = "[<] "+ whatText + "/" + infoWhatText + " [>]";

		if(!leftState) {
			var back:Bool = controls.BACK;
			if (controls.ACCEPT || back) {
				leftState = true;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if(!back) {
					ClientPrefs.data.flashing = false;
					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxFlicker.flicker(warnText, 1, 0.1, false, true, function(flk:FlxFlicker) {
						new FlxTimer().start(0.5, function (tmr:FlxTimer) {
							MusicBeatState.switchState(new TitleState());
						});
					});
				} else {
					FlxG.sound.play(Paths.sound('cancelMenu'));
					FlxTween.tween(warnText, {alpha: 0}, 1, {
						onComplete: function (twn:FlxTween) {
							MusicBeatState.switchState(new TitleState());
						}
					});
				}
			}
		}
		if(whatText == 0){
			warnText.visible = true;
			warnTextTwo.visible = false;
		}
		if (whatText == 1){
			warnTextTwo.visible = true;
			warnText.visible = false;
		}
		if (controls.UI_RIGHT){
			{
				whatText +=1;
			}
			if (controls.UI_RIGHT)
			{
				whatText -=1;
			}
		}
		super.update(elapsed);
	}
}

