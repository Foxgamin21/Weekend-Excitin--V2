local wpairs;

function onCreate()
	wpairs = loadstring(getTextFromFile('libs/lakitu.lua'))();
	
	if (os and os.time) then
		math.randomseed(os.time());
	end

	-- background
	makeLuaSprite('sky', 'mario/mario-sky', -770, -670);
	setLuaSpriteScrollFactor('sky', 0.7, 0.7);
	scaleObject('sky', 1, 1);

	makeLuaSprite('hill', 'mario/hill', -770, -800);
	setLuaSpriteScrollFactor('hill', 0.8, 0.8);
	scaleObject('hill', 1, 1);

	makeLuaSprite('ground', 'mario/ground-pipe', -770, -780);
	setLuaSpriteScrollFactor('ground', 1, 1);
	scaleObject('ground', 1, 1);
	
	addLuaSprite('sky', false);
	addLuaSprite('hill', false);
	addLuaSprite('ground', false);

	wpairs:init(0, 0.8);
	wpairs(false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end

function onBeatHit()
	wpairs:beat();
	if (curBeat == 180) then
		heartGen:init(450, 'bg3'); --Psych you piece of shit, why must I even do this!?
		setProperty('dad.idleSuffix', '-alt');
		setProperty('boyfriend.idleSuffix', '-alt');
	end
end