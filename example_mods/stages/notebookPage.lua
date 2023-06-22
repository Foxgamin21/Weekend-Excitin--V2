function onCreate()
	-- background shit
	makeLuaSprite('stageback', 'te room', -400, -10);
	setScrollFactor('stageback', 1.0, 0.9);
         
	addLuaSprite('stageback', false);
	addLuaSprite('stagefront', false);
	addLuaSprite('stagelight_left', false);
	addLuaSprite('stagelight_right', false);
	addLuaSprite('stagecurtains', false);
	
end
function onUpdate(elapsed)
    setProperty('dad.visible', false)
end