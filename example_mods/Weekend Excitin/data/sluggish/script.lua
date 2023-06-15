local allowCountdown = false

function onCreate()

	triggerEvent('Intro','Now playing:','Sluggish')
	
	
	end

function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);
		makeLuaSprite('afternooncs', 'afternooncs', 0, 0);
		scaleObject('afternooncs', 0.83, 0.83);
		addLuaSprite('afternooncs', true);
		setObjectCamera('afternooncs', 'hud');
		setObjectOrder('afternooncs', 0);
		allowCountdown = true;
		return Function_Stop;
	end
	doTweenAlpha('CGtween2', 'afternooncs', 0, 0.4, 'linear');
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		startDialogue('dialogue', '');
	end
end

function onTweenCompleted(tag)
if tag == 'CGtween2' then
	removeLuaSprite('afternooncs');
end
end

-- Dialogue (When a dialogue is finished, it calls startCountdown again)
function onNextDialogue(count)
	if count == 16 and not allowEndShit then
		playSound('kochi_1', 1);
	end
	
	if count == 36 then
		removeLuaSprite('afternooncs');
		makeLuaSprite('black', 'black', 0, 0);
		scaleObject('black', 6, 6);
		addLuaSprite('black', true);
		setObjectCamera('black', 'hud');
		setObjectOrder('black', 0);
		playSound('doorsound', 1);
	end
	if count == 37 then
		playSound('kochi_4', 1);
	end
end

function onSkipDialogue(count)
	-- triggered when you press Enter and skip a dialogue line that was still being typed, dialogue line starts with 1
	if getProperty('skippedDialogue') == true then
		setProperty('skippedDialogue', false);
			removeLuaSprite('afternooncs');
			toggleHud(true);
	end
		
end

local allowEndShit = false

function onEndSong()
 if not allowEndShit and isStoryMode and not seenCutscene then
  	setProperty('inCutscene', true);
  	startDialogue('dialogue2', 'sunny');
	makeLuaSprite('afternooncs', 'afternooncs', 0, 0);
	scaleObject('afternooncs', 0.83, 0.83);
	addLuaSprite('afternooncs', true);
	setObjectCamera('afternooncs', 'hud');
	setObjectOrder('afternooncs', 0);
allowEndShit = true;
 return Function_Stop;
 end
 return Function_Continue;
end