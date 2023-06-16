function onUpdate(elpased)

    for i=0,3 do
   noteTweenAlpha(i+0, i, math.floor, 0.3)
   end
  
function onUpdatePost()

	setProperty('botplayTxt.visible', false)

	setProperty('scoreTxt.visible', false)

	setProperty('healthBar.visible', false) -- change this & next 3 to true if u want health

	setProperty('healthBarBG.visible', false)

	setProperty('iconP1.visible', false)

	setProperty('iconP2.visible', false)

	setProperty('timeTxt.visible', false)

	setProperty('timeBar.visible', false)

	setProperty('timeBarBG.visible', false)

	setPropertyFromGroup('opponentStrums', 0, 'alpha', 0)

	setPropertyFromGroup('opponentStrums', 1, 'alpha', 0)

	setPropertyFromGroup('opponentStrums', 2, 'alpha', 0)

	setPropertyFromGroup('opponentStrums', 3, 'alpha', 0)

	setProperty("showComboNum", false)

	setProperty('showRating', false);

end

end