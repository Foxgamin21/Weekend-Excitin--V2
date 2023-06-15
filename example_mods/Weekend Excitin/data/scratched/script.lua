local allowCountdown = false

function onCreate()

	triggerEvent('Intro','Now playing:','Scratched')
	
	
	end

function onCreate()

triggerEvent('Intro','Now playing:','Scratched')


end
function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		startDialogue('dialogue', 'sunny');
	end
end

-- Dialogue (When a dialogue is finished, it calls startCountdown again)
function onNextDialogue(count)

if count == 1 then
	playSound('bfvoice1', 1);
end

if count == 2 then
	playSound('bfvoice3', 1);
end

if count == 5 then
	playSound('bfvoice6', 1);
end

if count == 7 then
	playSound('bfvoice1', 1);
end

	-- triggered when the next dialogue line starts, 'line' starts with 1
end

function onSkipDialogue(count)
	-- triggered when you press Enter and skip a dialogue line that was still being typed, dialogue line starts with 1
end