package mainGame.backend.data;

import mainGame.backend.data.ClientPrefs;

class TypeRating {

	public static var typeRatingList:Array<String> = [
	'Andromeda', 
	'Forever',
	'Stars',
	'CodeName',
	'Psych',
	'Disabled'
    ];

    public static var foreverRatings:Array<Dynamic> = [
		["F", 0.2], // 65%
		["E", 0.3], // 70%
		["D", 0.4], // 75%
		["C", 0.7], // 80%
		["B", 0.8], // 85%
		["A", 0.9], // 90%
		["S", 1], // 99.9%
		["S+", 1] // 100%
	];

	public static var andromedaRatings:Array<Dynamic> = [
		["D", 0.46], // 45%
		["D+", 0.51], // 50%
		["C-", 0.56], // 55%
		["C", 0.61], // 60%
		["C+", 0.65], // 64%
		["B-", 0.69], // 68%
		["B", 0.73], // 72%
		["B+", 0.77], // 76%
		["A-", 0.81], // 80%
		["A", 0.84], // 83%
		["A+", 0.87], // 86%
		["S-", 0.9], // 89%
		["S", 0.93], // 92%
		["S+", 0.95], // 94%
		["☆", 0.97], // 96%
		["☆☆", 0.99], // 98%
		["☆☆☆", 1], // 99.99%
		["☆☆☆☆", 1] // 100%
	];

	public static var starsRatings:Array<Dynamic> = [
		["☆☆☆☆☆", 0.31],
		["★☆☆☆☆", 0.41],
		["★★☆☆☆", 0.51],
		["★★★☆☆", 0.61],
		["★★★★☆", 1],
		["★★★★★", 1]
	];

	public static var codeNameRatings:Array<Dynamic> = [
		["F", 0],
		["E", 0.51],
		["D", 0.71],
		["C", 0.81],
		["B", 0.86],
		["A", 0.91],
		["S", 1],
		["S++", 1]
	];
    
	public static var psychRatings:Array<Dynamic> = [
		['You Suck!', 0.2], //From 0% to 19%
		['Shit', 0.4], //From 20% to 39%
		['Bad', 0.5], //From 40% to 49%
		['Bruh', 0.6], //From 50% to 59%
		['Meh', 0.69], //From 60% to 68%
		['Nice', 0.7], //69%
		['Good', 0.8], //From 70% to 79%
		['Great', 0.9], //From 80% to 89%
		['Sick!', 1], //From 90% to 99%
		['Perfect!!', 1] //100%
	];

}