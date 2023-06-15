local wpairs;

function onCreate()
	-- background
	makeLuaSprite('sky', 'afternoon/sky', -810, -600);
	setLuaSpriteScrollFactor('sky', 0.9, 0.9);
	scaleObject('sky', 1.7, 1.7);

	makeLuaSprite('tree', 'afternoon/tree', -630, -450);
	setLuaSpriteScrollFactor('tree', 0.9, 0.9);
	scaleObject('tree', 1.5, 1.5);

	makeLuaSprite('ground', 'afternoon/ground', -630, -450);
	setLuaSpriteScrollFactor('ground', 1, 1);
	scaleObject('ground', 1.5, 1.5);

	makeLuaSprite('lightFG', 'afternoon/light above', -180, -900);
	setLuaSpriteScrollFactor('lightBG', 1.1, 1.1);
	setBlendMode('lightFG','add')
	
	makeLuaSprite('light','afternoon/light', -460, 120)
	addLuaSprite('light',true)
	setBlendMode('light','add')
	setProperty('light.alpha',0.65)
	setScrollFactor('light',1.6, 1.6)

	addLuaSprite('sky', false);
	addLuaSprite('tree', false);
	addLuaSprite('ground', false);
	addLuaSprite('lightFG', true);
	addLuaSprite('light', true);
	
	wpairs:init(0, 0.8);
	wpairs(true);	
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end

function onBeatHit()
	wpairs:beat();
	if (curBeat == 112) then
		heartGen:init(450, 'bg3'); --Psych you piece of shit, why must I even do this!?
		setProperty('dad.idleSuffix', '-alt');
		setProperty('boyfriend.idleSuffix', '-alt');
	end
end