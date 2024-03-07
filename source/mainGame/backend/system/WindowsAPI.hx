package mainGame.backend.system;

class WindowsAPI {
	public static function setDarkMode(enable:Bool) {
		#if windows
		native.WinAPI.setDarkMode(enable);
		#end

        #if debug
        Debug.LogConsole('windows dark mode: ${enable}');
        #end
	} //only one fuckin function - Snake
}