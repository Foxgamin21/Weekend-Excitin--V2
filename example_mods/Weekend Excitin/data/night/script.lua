local allowCountdown = false

function onCreate()

	triggerEvent('Intro','Now playing:','Night')
	
	
	end

function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.2);
		makeLuaSprite('black', 'black', 0, 0);
		scaleObject('black', 6, 6);
		addLuaSprite('black', true);
		setObjectCamera('black', 'hud');
		setObjectOrder('black', 0);
		allowCountdown = true;
		return Function_Stop;
	end
	doTweenAlpha('CGtween2', 'cutscreen5', 0, 0.4, 'linear');
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		startDialogue('dialogue', '');
	end
end

function onTweenCompleted(tag)
if tag == 'CGtween2' then
	removeLuaSprite('cutscreen5');
end
end

-- Dialogue (When a dialogue is finished, it calls startCountdown again)
function onNextDialogue(count)
	if count == 6 and not allowEndShit then
		removeLuaSprite('black');
		makeLuaSprite('roomcutscreen', 'roomcutscreen', 0, 0);
		scaleObject('roomcutscreen', 0.83, 0.83);
		addLuaSprite('roomcutscreen', true);
		setObjectCamera('roomcutscreen', 'hud');
		setObjectOrder('roomcutscreen', 0);
	end
	if count == 20 and not allowEndShit then
		removeLuaSprite('roomcutscreen');
		makeLuaSprite('cutscreen3', 'cutscreen3', 0, 0);
		scaleObject('cutscreen3', 0.83, 0.83);
		addLuaSprite('cutscreen3', true);
		setObjectCamera('cutscreen3', 'hud');
		setObjectOrder('cutscreen3', 0);
	end
	if count == 23 and not allowEndShit then
		removeLuaSprite('cutscreen3');
		makeLuaSprite('cutscreen4', 'cutscreen4', 0, 0);
		scaleObject('cutscreen4', 0.83, 0.83);
		addLuaSprite('cutscreen4', true);
		setObjectCamera('cutscreen4', 'hud');
		setObjectOrder('cutscreen4', 0);
		playSound('cat_attack', 1);
	end
	if count == 24 and not allowEndShit then
		removeLuaSprite('cutscreen4');
		makeLuaSprite('cutscreen5', 'cutscreen5', 0, 0);
		scaleObject('cutscreen5', 0.83, 0.83);
		addLuaSprite('cutscreen5', true);
		setObjectCamera('cutscreen5', 'hud');
		setObjectOrder('cutscreen5', 0);
		playSound('ren_3', 1);
	end
	if count == 32 and not allowEndShit then
		playSound('ren_4', 1);
	end
	if count == 36 and not allowEndShit then
		removeLuaSprite('cutscreen5');
		makeLuaSprite('roomcutscreen', 'roomcutscreen', 0, 0);
		scaleObject('roomcutscreen', 0.83, 0.83);
		addLuaSprite('roomcutscreen', true);
		setObjectCamera('roomcutscreen', 'hud');
		setObjectOrder('roomcutscreen', 0);
	end
	if count == 45 then
		playSound('poof', 1);
	end
	-- triggered when the next dialogue line starts, 'line' starts with 1
end

function onSkipDialogue(count)
	-- triggered when you press Enter and skip a dialogue line that was still being typed, dialogue line starts with 1
	if getProperty('skippedDialogue') == true then
		setProperty('skippedDialogue', false);
			removeLuaSprite('black');
			removeLuaSprite('roomcutscreen');
			removeLuaSprite('cutscreen3');
			removeLuaSprite('cutscreen4');
			removeLuaSprite('cutscreen5');
			toggleHud(true);
	end
		
end

local allowEndShit = false

function onEndSong()
if not allowEndShit and isStoryMode and not seenCutscene then
		setProperty('inCutscene', true);
		startDialogue('dialogue2', ''); 
		makeLuaSprite('roomcutscreen', 'roomcutscreen', 0, 0);
		scaleObject('roomcutscreen', 0.83, 0.83);
		addLuaSprite('roomcutscreen', true);
		setObjectCamera('roomcutscreen', 'hud');
		setObjectOrder('roomcutscreen', 0);
	allowEndShit = true;
	return Function_Stop;
       end
 return Function_Continue;
end
