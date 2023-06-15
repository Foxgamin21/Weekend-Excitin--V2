function onCreate()
	-- background
	makeLuaSprite('sky', 'room/sky', -700, -350);
	setLuaSpriteScrollFactor('sky', 1, 1);
	scaleObject('sky', 1.3, 1.3);

	makeLuaSprite('city', 'room/city', -700, -350);
	setLuaSpriteScrollFactor('city', 1, 1);
	scaleObject('city', 1.3, 1.3);

	makeLuaSprite('room', 'room/room_night', -700, -350);
	setLuaSpriteScrollFactor('room', 1, 1);
	scaleObject('room', 1.3, 1.3);

	makeLuaSprite('light', 'room/light', -700, -350);
	setLuaSpriteScrollFactor('light', 1, 1);
	scaleObject('light', 1.3, 1.3);

	makeAnimatedLuaSprite('kochiandcat','room/kochiandcat', 580, 270)
	addAnimationByPrefix('kochiandcat','kochiandcat','kochiandcat',24,true)
	objectPlayAnimation('kochiandcat','kochiandcat',false)
	scaleObject('kochiandcat', 1.15, 1.15)
	setScrollFactor('kochiandcat', 1, 1);


	addLuaSprite('sky', false);
	addLuaSprite('city', false);
	addLuaSprite('room', false);
	addLuaSprite('light', true);
	addLuaSprite('kochiandcat', false);

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end