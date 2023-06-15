function onCreate()
	-- background
	makeLuaSprite('light', 'nothing/light', -350, 10);
	setLuaSpriteScrollFactor('light', 1, 1);
	scaleObject('light', 1.4, 1.4);

	addLuaSprite('light', false);

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end