package mainGame.options;

class LanguageOptionsSubState extends BaseOptionsMenu
{
	var langueList:Array<String> = ['Russian', 'English','Polish','Ukraine'];

	public function new()
	{

		//discord
		switch(ClientPrefs.data.gameLanguage)
		{
			case 'Russian':
				title = 'Языки';
				rpcTitle = 'Настройки'; //for Discord Rich Presence
			default:
				title = 'Language';
				rpcTitle = 'Options'; //for Discord Rich Presence
		}

		//settings
		switch(ClientPrefs.data.gameLanguage)
		{
			case 'Russian':
				var option:Option = new Option('Игры Язык:',
					"Твой язык?",
					'gameLanguage',
					'string',
					langueList);
				addOption(option);
			case 'Polish':
				var option:Option = new Option('Język gry:',
                    "Twój język?",
                    'gameLanguage',
					'string',
					langueList);
				addOption(option);
			default:
				var option:Option = new Option('Game language:',
					"Your language?",
					'gameLanguage',
					'string',
					langueList);
				addOption(option);
		}

		super();
	}

	function onChangeHitsoundVolume()
	{
		FlxG.sound.play(Paths.sound('hitsound'), ClientPrefs.data.hitsoundVolume);
	}

	function onChangeAutoPause()
	{
		FlxG.autoPause = ClientPrefs.data.autoPause;
	}
}