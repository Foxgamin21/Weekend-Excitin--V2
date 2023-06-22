local allowCountdown = false

function onCreate()

	triggerEvent('Intro','Now playing:','Stalwart')
	
	
	end

function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);
		makeLuaSprite('morningcs', 'morningcs', 0, 0);
		scaleObject('morningcs', 0.83, 0.83);
		addLuaSprite('morningcs', true);
		setObjectCamera('morningcs', 'hud');
		setObjectOrder('morningcs', 0);
		allowCountdown = true;
		return Function_Stop;
	end
	doTweenAlpha('CGtween2', 'morningcs', 0, 0.4, 'linear');
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
	-- triggered when the next dialogue line starts, 'line' starts with 1
end

function onSkipDialogue(count)
	-- triggered when you press Enter and skip a dialogue line that was still being typed, dialogue line starts with 1
end