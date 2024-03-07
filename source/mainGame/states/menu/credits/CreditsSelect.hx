package mainGame.states.menu.credits;

import mainGame.states.menu.MainMenuState;
import flixel.addons.display.FlxBackdrop;

import mainGame.states.menu.credits.VEMERCreditsState;

//application change name
import lime.app.Application;

class CreditsSelect extends MusicBeatState
{
	var options:Array<String> = [];
	var optionsEn:Array<String> = ['VEMER Engine', 'Psych Engine', 'Mods'];
	var optionsRu:Array<String> = ['VEMER Движок', 'Упpавлehиe', 'Пoзиции peйtиhга и komбo', 'Графика', 'Визуал и Иhtepфeйc', 'Гeймплeй', 'Языk'];
	private var grpOptions:FlxTypedGroup<Alphabet>;
	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;

	function openSelectedSubstate(label:String) {
		switch(label) {
			case 'VEMER Engine' | 'VEMER Движок' :
				MusicBeatState.switchState(new VEMERCreditsState());
		}
	}

	var bg:FlxBackdrop;
	var selectedOption:String = "";

	override function create() {

		#if desktop
		DiscordClient.changePresence("Credits Selection","Menu", null);
		#end

		switch(ClientPrefs.data.gameLanguage)
		{
			case 'Russian':
				options = optionsRu;
			default:
				options = optionsEn;
		}

		bg = new FlxBackdrop(Paths.image('Menu/Option/Background'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.velocity.set(10, 10);
		bg.updateHitbox();

		bg.screenCenter();
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			switch(ClientPrefs.data.gameLanguage)
			{
				case 'Russian':
					var optionText:Alphabet = new Alphabet(0, 0, options[i], true);
					optionText.screenCenter();
					optionText.y += (100 * (i - (options.length / 2))) + 50;
					grpOptions.add(optionText);
				case 'English':
					var optionText:Alphabet = new Alphabet(0, 0, options[i], true);
					optionText.screenCenter();
					optionText.y += (100 * (i - (options.length / 2))) + 50;
					grpOptions.add(optionText);
			}
		}

		changeSelection();
		ClientPrefs.saveSettings();

		super.create();
	}

	override function closeSubState() {
		super.closeSubState();
		ClientPrefs.saveSettings();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (controls.UI_UP_P) {
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P) {
			changeSelection(1);
		}

		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
		//else if (controls.ACCEPT) MusicBeatState.switchState(new $options[curSelected]);
		if(controls.ACCEPT){
			openSelectedSubstate(options[curSelected]);
		}
	}
	
	function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	override function destroy()
	{
		ClientPrefs.loadPrefs();
		super.destroy();
	}
}