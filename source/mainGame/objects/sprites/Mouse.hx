package mainGame.objects.sprites;

import openfl.display.DisplayObject;
import openfl.ui.Mouse;
import flixel.FlxBasic;

class Mouse extends FlxBasic
{
    public static var sprite:String = 'cursor';    
    public static var seeMouse:Bool = true;
    public static var defaultMouseLol:Bool = false;
    public static var scaleMouse:Float = 1;


    public static function loadMouse(showMouse:Bool = true, spriteMouse:String = 'cursor', scale:Float = 1)
    {
        seeMouse = showMouse;
        sprite = spriteMouse;
        scaleMouse = scale;

        FlxG.mouse.load(loadGraphic(Paths.image('$sprite')).bitmap, scale, 0, 0);
    }

    public static function defaultMouse(anwser:Bool)
    {
        FlxG.mouse.useSystemCursor = anwser;
    }
    

    public static function see(need:Bool = true)
    {
        seeMouse = need;

        FlxG.mouse.visible = seeMouse;

        if(need)
            loadMouse(sprite);
    }
}