local wpairs;

function onCreate()
	-- background
	makeLuaSprite('sky', 'morning/sky', -810, -600);
	setLuaSpriteScrollFactor('sky', 0.9, 0.9);
	scaleObject('sky', 1.7, 1.7);

	makeLuaSprite('tree', 'morning/tree', -630, -450);
	setLuaSpriteScrollFactor('tree', 0.9, 0.9);
	scaleObject('tree', 1.5, 1.5);

	makeLuaSprite('ground', 'morning/ground', -630, -450);
	setLuaSpriteScrollFactor('ground', 1, 1);
	scaleObject('ground', 1.5, 1.5);
	
	makeLuaSprite('light','morning/light', -460, 120)
	addLuaSprite('light',true)
	setBlendMode('light','add')
	setProperty('light.alpha',0.65)
	setScrollFactor('light',1.6, 1.6)

	makeLuaSprite('lightFG', 'afternoon/light above', -180, -900);
	setLuaSpriteScrollFactor('lightBG', 1.1, 1.1);
	setBlendMode('lightFG','add')

	makeAnimatedLuaSprite('boopers','morning/boopers', -240,150)
	addAnimationByPrefix('boopers','boopers','booper',24,true)
	objectPlayAnimation('boopers','boopers',false)
	scaleObject('boopers', 1.3, 1.3);
	setScrollFactor('boopers', 1, 1);
	
	makeAnimatedLuaSprite('foxandraccoon','morning/foxandraccoon', 240, 150)
	addAnimationByPrefix('foxandraccoon','fox and raccoon','fox and raccoon',24,true)
	objectPlayAnimation('foxandraccoon','fox and raccoon',false)
	scaleObject('foxandraccoon', 1.2, 1.2)
	setScrollFactor('foxandraccoon', 1, 1);

	addLuaSprite('sky', false);
	addLuaSprite('tree', false);
	addLuaSprite('ground', false);
	addLuaSprite('boopers', false);
	addLuaSprite('foxandraccoon', false);
	addLuaSprite('lightFG', true);
	addLuaSprite('light', true);
	
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