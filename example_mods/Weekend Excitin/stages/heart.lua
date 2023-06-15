local wpairs;

function onCreate()
	wpairs = loadstring(getTextFromFile('libs/hearts.lua'))();
	
	if (os and os.time) then
		math.randomseed(os.time());
	end

	-- background
	makeLuaSprite('heart', 'heart/heart', -700, -250);
	setLuaSpriteScrollFactor('heart', 1, 1);
	scaleObject('heart', 0.9, 0.9);

	makeLuaSprite('light','afternoon/light', -460, -120)
	addLuaSprite('light',true)
	setBlendMode('light','add')
	setProperty('light.alpha',0.65)
	setScrollFactor('light',1.6, 1.6)

	addLuaSprite('heart', false);
	addLuaSprite('light', false);

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