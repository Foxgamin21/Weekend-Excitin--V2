local wpairs = {};

function wpairs.init(self, py, scrollFact)
	self.pairs = {
		'ayanna and dalia', 'sarv and ruv', 'macy and bob', 'tabi and fswhitty', 'sol and nik', 'eddsworld gang', 'garcelloanchor', 'kou and kapi', 'selsunday', 'shaggy and tree', 'jads smokey', 'yukichi and impostor', 'cval and kolsan', 'violet and ruria'
	};
	self.flip = {
		true, false, true, false, true
	}
	self.currPair = 0;
	local scales = { 1.45, 1.45, 1.45, 1.30, 1.20, 1.45, 1.58, 1.45, 1.45, 1.45, 1.45, 1.45, 1.36, 1.45 };
	local offy = { 450, 580, 450, 490, 470, 450, 520, 450, 530, 510, 510, 450, 450, 510 };
	local offx = { -1200, -1200, -1200, -1200, -2500, -1500, -1200, -1200, -1200, -2000, -2000, -1200, -1200, -1600 };
	--local offy = { 0, 150, 40, 50, 100 };	
	for j = 0, 1 do
		for i = 1, #self.pairs do
			local objName = 'wpair_'..i;
			local imgSrc = 'morning/walking_pairs';
			makeAnimatedLuaSprite(objName, imgSrc, 0, 0);
			setLuaSpriteScrollFactor(objName, scrollFact, scrollFact);
			addAnimationByPrefix(objName, self.pairs[i], self.pairs[i], 24, true);
			objectPlayAnimation(objName, self.pairs[i], true);
			scaleObject(objName, scales[i], scales[i]);
			addLuaSprite(objName, true);
			--setProperty(objName..'.x', -300 + (250 * (i-1)));
			setProperty(objName..'.x', py + offx[i]);
			setProperty(objName..'.y', py + offy[i]);
		end
	end
end

function wpairs.beat(self)
	if (curBeat % 24 == 0) then
		--local pair = math.random(1, #self.pairs);
		self.currPair = self.currPair + 1;
		if (self.currPair > #self.pairs) then self.currPair = 1; end
		local pair = self.currPair;
		local wlkRight = math.random(1, 100) > 50;
		local startPos, endPos;
		if (wlkRight) then
			startPos = -1500;
			endPos = 2700;
		else
			startPos = 2500;
			endPos = -1700;
		end
		local flip = self.flip[pair];
		if (not wlkRight) then flip = not flip; end
		local sufx = '';
		if (math.random(1, 100) < 17) then
			sufx = '_alt';
		end
		setProperty('wpair_'..pair..sufx..'.flipX', flip);
		setProperty('wpair_'..pair..sufx..'.x', startPos);
		doTweenX('anim:wpair_'..pair..sufx, 'wpair_'..pair..sufx, endPos, 10, 'linear');
	end
end

return wpairs;