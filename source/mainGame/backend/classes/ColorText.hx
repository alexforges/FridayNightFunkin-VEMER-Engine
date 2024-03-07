package mainGame.backend.classes;

class ComboRating {
	public var minMisses:Float;
	public var maxMisses:Float;
	public var rating:String;
	public var color:FlxColor;

	public function new(rating:String = "lol", minMisses:Int = 4, maxMisses:Int = 5, color:FlxColor =  0xFF888888)
	{
		this.rating = rating;
        this.minMisses = minMisses;
        this.maxMisses = maxMisses;
		this.color = color;
	}
}

class Misses {
	public function new(miss:Float, color:FlxColor){

	};
}