local shaderName = "blur"
local amount = 1
function onCreatePost()
    makeLuaSprite('black', '', 0, 0)
    makeGraphic('black', 3000, 3000, '000000')
    addLuaSprite('black', true)
end

function onUpdatePost()
    runHaxeCode([[
        shader0.setFloat("iTime", ]] .. os.clock() .. [[);
    ]])
end

function onSongStart()
    doTweenAlpha('nomoreblack', 'black', 0, 7.1)
    runHaxeCode([[
        var shaderName = "]] .. shaderName .. [[";
        
        game.initLuaShader(shaderName);
        
        shader0 = game.createRuntimeShader(shaderName);
        game.camGame.setFilters([new ShaderFilter(shader0)]);
    ]])

    setProperty('camHUD.alpha', 0)
end

function onBeatHit()
    if curBeat == 14 then
        runHaxeCode([[
            game.camGame.setFilters(null);
        ]])
    end
    if curBeat == 16 then
        doTweenAlpha('hi', 'camHUD', 1, 1)
    end
end

function onGameOver()
    runHaxeCode([[
        game.camGame.setFilters(null);
    ]])
end