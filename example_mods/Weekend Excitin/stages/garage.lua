function onCreate()
	-- background
	makeLuaSprite('garage', 'garage/garage', -700, -650);
	setLuaSpriteScrollFactor('garage', 1, 1);
	scaleObject('garage', 1.1, 1.1);

	makeAnimatedLuaSprite('friends','garage/friends', -342, 15)
	addAnimationByPrefix('friends','friends','friends',24,true)
	objectPlayAnimation('friends','friends',false)
	scaleObject('friends', 1.1, 1.1);
	setScrollFactor('friends', 1, 1);

	addLuaSprite('garage', false);
	addLuaSprite('friends', false);

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end