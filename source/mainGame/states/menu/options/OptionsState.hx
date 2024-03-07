package mainGame.states.menu.options;

import mainGame.states.menu.MainMenuState;
import mainGame.backend.data.StageData;
import flixel.addons.display.FlxBackdrop;

//application change name
import lime.app.Application;

class OptionsState extends MusicBeatState
{
	var options:Array<String> = [];
	var optionsEn:Array<String> = ['Note Colors', 'Controls', 'Adjust Delay and Combo', 'Graphics', 'Visuals and UI', 'Gameplay', 'Language'];
	var optionsRu:Array<String> = ['Цвetа hot', 'Упpавлehиe', 'Пoзиции peйtиhга и komбo', 'Графика', 'Визуал и Иhtepфeйc', 'Гeймплeй', 'Языk'];

	var selectOption:Array<String> = [
		'Visuals',
		'Gameplay',

	];
	private var grpOptions:FlxTypedGroup<Alphabet>;
	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;
	public static var onPlayState:Bool = false;

	function openSelectedSubstate(label:String) {
		switch(label) {
			case 'Note Colors' | 'Цвetа hot' | 'Kolory Nót':
				//openSubState(new mainGame.options.NotesSubState());
			case 'Controls' | 'Упpавлehиe' | 'Kontrola':
				//openSubState(new mainGame.options.ControlsSubState());
			case 'Graphics' | 'Гpафиkа' | 'Grafika':
				//openSubState(new mainGame.options.GraphicsSettingsSubState());
			case 'Visuals and UI' | 'Визуал и Иhtepфeйc' | 'Wizualizacje i UI':
				//openSubState(new mainGame.options.VisualsUISubState());
			case 'Gameplay' | 'Гeйmплeй':
				//openSubState(new mainGame.options.GameplaySettingsSubState());
			case 'Adjust Delay and Combo' | 'Пoзиции peйtиhга и komбo' | 'Dostosuj delay i kombo':
				//MusicBeatState.switchState(new mainGame.options.NoteOffsetState());
			case 'Language' | 'Языk' | 'Język':
				//openSubState(new mainGame.options.LanguageOptionsSubState());
		}
	}

	var selectorRight:Alphabet;
	var bg:FlxBackdrop;
	var selectedOption:String = "";

	override function create() {

		#if desktop
		DiscordClient.changePresence("Options Menu", null);
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
			var optionText:Alphabet = new Alphabet(0, 0, options[i], true);
			optionText.screenCenter();
			optionText.y += (100 * (i - (options.length / 2))) + 50;
			grpOptions.add(optionText);
		}

		selectorRight = new Alphabet(0, 0, '<', true);
		add(selectorRight);

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
			if(onPlayState)
			{
				StageData.loadDirectory(PlayState.SONG);
				LoadingState.loadAndSwitchState(new PlayState());
				FlxG.sound.music.volume = 0;
			}
			else MusicBeatState.switchState(new MainMenuState());
		}
		else if (controls.ACCEPT) openSelectedSubstate(options[curSelected]);
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
				selectorRight.x = item.x + item.width + 15;
				selectorRight.y = item.y;
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