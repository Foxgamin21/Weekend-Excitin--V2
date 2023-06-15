function onCreate()
	makeLuaSprite('comboBurst','combo',1275,500)
	setObjectCamera('comboBurst','other')
	scaleObject('comboBurst', 1.2, 1.2)
	setProperty('comboBurst.alpha', 0)
	addLuaSprite('comboBurst', true)
end

function goodNoteHit(id, direction, noteType, sus)
if getProperty('combo') % 100 == 0 then
doTweenX('Xtween','comboBurst',900, 1,'circOut')
doTweenAlpha('Alphatween','comboBurst', 1, 1,'circIn')
runTimer('burst', 2, 0)
end
end
function onTimerCompleted(tag)
	if tag == 'burst' then
	doTweenX('Xtween','comboBurst',1275, 1,'circOut')
	doTweenAlpha('Alphatween','comboBurst', 0, 0.5,'circIn')
end
end