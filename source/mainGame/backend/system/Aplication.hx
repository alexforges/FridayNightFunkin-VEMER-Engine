package mainGame.backend.system;

import lime.app.Application;

class Aplication {

    public static var appTitle:String = "Friday Night Funkin': VEMER Engine";
	public static var appPrefix:String = "=";
	public static var appDopPrefix:String = "/";
	public static var appWallPefix:String = "|";
    

    public static function setText(text:String = '', needAppPrefix:Bool = false, twoText:String = '') {
        if(needAppPrefix)
            Application.current.window.title = '${appTitle} ${appPrefix} ${text} ${appDopPrefix} ${twoText}';
        else
            Application.current.window.title = '${appTitle} ${appPrefix} ${text} ${twoText}';
    }

    public static function playText(text:String, status:String) {
        Application.current.window.title = '${appTitle} ${appPrefix} Playing: ${text} ${appDopPrefix} ${status}';
    }

    public static function setStateName(text:String, dlcText:String = '')
    {
        if(text != 'Freeplay')
            Application.current.window.title = '${appTitle} ${appPrefix} ${text} Menu';

        if(text == 'Freeplay')
            Application.current.window.title = '${appTitle} ${appPrefix} ${text} ${appDopPrefix} ${dlcText}';
    }
}