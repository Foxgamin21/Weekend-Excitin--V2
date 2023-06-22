local turnvalue = 20

bitchhoe = 39

function onBeatHit()

doDaBeat()

end


function doDaBeat()


turnvalue = 10
if curBeat % 2 == 0 then
turnvalue = -10
end



setProperty('iconP2.angle',turnvalue)
setProperty('iconP1.angle',turnvalue)

doTweenAngle('iconTween1','iconP1',0,crochet/1000,'circOut')
doTweenAngle('iconTween2','iconP2',0,crochet/1000,'circOut')



end