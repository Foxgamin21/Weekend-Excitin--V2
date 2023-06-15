local allowCountdown = false

function onCreate()

	triggerEvent('Intro','Now playing:','Cat')
	
	
	end

function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);
		makeLuaSprite('cutscreen1', 'cutscreen1', 0, 0);
		scaleObject('cutscreen1', 0.83, 0.83);
		addLuaSprite('cutscreen1', true);
		setObjectCamera('cutscreen1', 'hud');
		setObjectOrder('cutscreen1', 0);
		allowCountdown = true;
		return Function_Stop;
	end
	doTweenAlpha('CGtween2', 'cutscreen2', 0, 0.4, 'linear');
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		startDialogue('dialogue', '');
	end
end

function onTweenCompleted(tag)
if tag == 'CGtween2' then
	removeLuaSprite('cutscreen2');
end
end

-- Dialogue (When a dialogue is finished, it calls startCountdown again)
function onNextDialogue(count)
	if count == 6 then
		makeLuaSprite('cutscreen2', 'cutscreen2', 0, 0);
		scaleObject('cutscreen2', 0.83, 0.83);
		addLuaSprite('cutscreen2', true);
		setObjectCamera('cutscreen2', 'hud');
		setObjectOrder('cutscreen2', 0);
	end
	if count == 6 then
	removeLuaSprite('cutscreen1');
	end
	-- triggered when the next dialogue line starts, 'line' starts with 1
end

function onSkipDialogue(count)
	-- triggered when you press Enter and skip a dialogue line that was still being typed, dialogue line starts with 1
	if getProperty('skippedDialogue') == true then
		setProperty('skippedDialogue', false);
			removeLuaSprite('cutscreen1');
			removeLuaSprite('cutscreen2');
			toggleHud(true);
	end
		
end