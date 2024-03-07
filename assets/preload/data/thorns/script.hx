import flixel.math.FlxMath;
import openfl.filters.ShaderFilter;

var shaderName = "bloom";
var shaderName2 = "chromaticAbberation";

var shader:Dynamic;
var shader1:Dynamic;

var funValue:Int = 12;
var drainShader:Int = 1;

function onCreatePost() { 
       game.initLuaShader(shaderName);
       game.initLuaShader(shaderName2);

        shader = game.createRuntimeShader(shaderName);
        shader1 = game.createRuntimeShader(shaderName2);
        shader.setFloat('intensity', 0.15);
        shader.setFloat('blurSize', 1/128);

        shader1.setInt('amount', 6);

        game.camGame.setFilters([new ShaderFilter(shader), new ShaderFilter(shader1)]);
        game.camHUD.setFilters([new ShaderFilter(shader), new ShaderFilter(shader1)]);
}

/*function onUpdate(elapsed) {
    if(funValue > 1){
        funValue - drainShader;
    }
}

/*function onBeatHit(beat) {
    shader1.setInt('amount', funValue);
    if(curBeat % 1 == 0){
        funValue = 12;
    }
}*/

/*function onEvent(name, val1, val2, val3) {  
    if(name == 'event') {
        if(val1 != '') funValue = val1;

        if(val2 != '') shader1.setInt('amount', val2);
    }
}*/
