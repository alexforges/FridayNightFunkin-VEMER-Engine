package openfl.display;

import haxe.display.Protocol.Version;
import flixel.FlxG;
import openfl.display.Shader;
import openfl.filters.ShaderFilter;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;
import mainGame.backend.data.ClientPrefs;
import mainGame.backend.data.Versions;

class FPS extends TextField
{
	/**
		The current frame rate, expressed using frames-per-second
	**/
	public var currentFPS(default, null):UInt;

	var peak:UInt = 0;

	public var bitmap:Bitmap;

	var buildLol:String = "" + mainGame.backend.data.Versions.dataBuild;

	public static var showMEM:Bool=true; // TODO: Rename
    public static var showFpsCounter:Bool = true;
	public static var showMemPEAK:Bool = true;
	public static var myFUCKINGENGINGEBLIAT:String = "VE:"+ mainGame.backend.data.Versions.myFreakingEngine;
	public var lolSpace:String = "";
	public var lolTwoSpace:String = "";

	@:noCompletion private var cacheCount:Int;
	@:noCompletion private var currentTime:Float;
	@:noCompletion private var times:Array<Float>;

	public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000, sizeText:Int = 12)
	{
		super();

		this.x = x;
		this.y = y;

		currentFPS = 0;
		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat("_sans", sizeText, color);
		text = "";

		cacheCount = 0;
		currentTime = 0;
		times = [];


		autoSize = LEFT;
		backgroundColor = 0;

		#if flash
		addEventListener(Event.ENTER_FRAME, function(e)
		{
			var time = Lib.getTimer();
			__enterFrame(time - currentTime);
		});
		#end

		width = 350;

		//bitmap = ImageOutline.renderImage(this, 1, 0x000000, 1, true);
		//(cast(Lib.current.getChildAt(0), Main)).addChild(bitmap);
	}

	// Event Handlers
	@:noCompletion
	private #if !flash override #end function __enterFrame(deltaTime:Float):Void
	{
		currentTime += deltaTime;
		times.push(currentTime);

		while (times[0] < currentTime - 1000)
		{
			times.shift();
		}

		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount));


		// my engine fps counter yeah.... so much "if" i know i idk how make withoud "if"
	    // -VEMER
		text = "";
		//if (backend.ClientPrefs.FPSCounter){
		if(showFpsCounter)
			text += ""+ currentFPS + ":FPS" + "\n";

		if(showMEM)

			if(showFpsCounter)
				lolSpace = " ";
		    else
				lolSpace = "";

			text += lolSpace + "Memory:" + getSizeLabel(System.totalMemory) + "\n";

		if(showMemPEAK)

			if(showFpsCounter)
				lolTwoSpace = " ";
		    else if(showFpsCounter && showMEM)
				lolTwoSpace = "  ";
			else
				lolTwoSpace = "";

			text += lolTwoSpace + "Mem Peak:" + getSizeLabel(peak) + "\n";


			// WATERMARK YUIPEEEEEEEEEEE
		text += "\n";
			text += lolSpace + myFUCKINGENGINGEBLIAT + "\n";

		var mem = System.totalMemory;
		if (mem > peak)
			peak = mem;	

		text +="\n";

		#if debug
		text +="--Debug Build"+ "\n";

		text +="Build:" + buildLol + "\n";
		text +="PC Name:" + Sys.environment()["USERNAME"];

		#end
		

	}

	final dataTexts = ["B", "KB", "MB", "GB", "TB", "PB"];

	public function getSizeLabel(num:UInt):String
	{
		var size:Float = num;
		var data = 0;
		while (size > 1024 && data < dataTexts.length - 1)
		{
			data++;
			size = size / 1024;
		}

		size = Math.round(size * 100) / 100;

		if (data <= 2)
			size = Math.round(size);

		return size + " " + dataTexts[data];
	}
}