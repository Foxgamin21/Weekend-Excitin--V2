local allowCountdown = false

function onCreate()

	triggerEvent('Intro','Now playing:','Overpower')
	
	
	end

function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.2);
		makeLuaSprite('garagecutscreen', 'garagecutscreen', 0, 0);
		scaleObject('garagecutscreen', 0.83, 0.83);
		addLuaSprite('garagecutscreen', true);
		setObjectCamera('garagecutscreen', 'hud');
		setObjectOrder('garagecutscreen', 0);
		allowCountdown = true;
		return Function_Stop;
	end
	doTweenAlpha('CGtween2', 'cutscreen10', 0, 0.4, 'linear');
	return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		startDialogue('dialogue', 'club');
	end
end

function onTweenCompleted(tag)
if tag == 'CGtween2' then
	removeLuaSprite('cutscreen10');
end
end

-- Dialogue (When a dialogue is finished, it calls startCountdown again)
function onNextDialogue(count)
	if count == 1 and not allowEndShit then
		playSound('kochi_1', 1);
	end
	if count == 5 and not allowEndShit then
		removeLuaSprite('garagecutscreen');
		makeLuaSprite('cutscreen6', 'cutscreen6', 0, 0);
		scaleObject('cutscreen6', 0.83, 0.83);
		addLuaSprite('cutscreen6', true);
		setObjectCamera('cutscreen6', 'hud');
		setObjectOrder('cutscreen6', 0);
	end
	if count == 9 and not allowEndShit then
		removeLuaSprite('cutscreen6');
		makeLuaSprite('cutscreen7', 'cutscreen7', 0, 0);
		scaleObject('cutscreen7', 0.83, 0.83);
		addLuaSprite('cutscreen7', true);
		setObjectCamera('cutscreen7', 'hud');
		setObjectOrder('cutscreen7', 0);
	end
	if count == 11 and not allowEndShit then
		playSound('hika_4', 1);
	end
	if count == 14 and not allowEndShit then
		removeLuaSprite('cutscreen7');
		makeLuaSprite('cutscreen8', 'cutscreen8', 0, 0);
		scaleObject('cutscreen8', 0.83, 0.83);
		addLuaSprite('cutscreen8', true);
		setObjectCamera('cutscreen8', 'hud');
		setObjectOrder('cutscreen8', 0);
	end
	if count == 15 and not allowEndShit then
		playSound('hika_2', 1);
	end
	if count == 16 and not allowEndShit then
		removeLuaSprite('cutscreen8');
		makeLuaSprite('cutscreen9', 'cutscreen9', 0, 0);
		scaleObject('cutscreen9', 0.83, 0.83);
		addLuaSprite('cutscreen9', true);
		setObjectCamera('cutscreen9', 'hud');
		setObjectOrder('cutscreen9', 0);
	end
	if count == 17 and not allowEndShit then
		playSound('tsubasa_3', 1);
	end
	if count == 19 and not allowEndShit then
		playSound('tsubasa_2', 1);
	end
	if count == 23 and not allowEndShit then
		playSound('tsubasa_1', 1);
	end
	if count == 25 and not allowEndShit then
		removeLuaSprite('cutscreen9');
		makeLuaSprite('cutscreen10', 'cutscreen10', 0, 0);
		scaleObject('cutscreen10', 0.83, 0.83);
		addLuaSprite('cutscreen10', true);
		setObjectCamera('cutscreen10', 'hud');
		setObjectOrder('cutscreen10', 0);
	end
	if count == 27 and not allowEndShit then
		playSound('ren_1', 1);
	end
	if count == 33 then
		playSound('hika_5', 1);
	end
	if count == 40 then
		playSound('kochi_2', 1);
	end
	-- triggered when the next dialogue line starts, 'line' starts with 1
end

function onSkipDialogue(count)
	-- triggered when you press Enter and skip a dialogue line that was still being typed, dialogue line starts with 1
	if getProperty('skippedDialogue') == true then
		setProperty('skippedDialogue', false);
			removeLuaSprite('garagecutscreen');
			removeLuaSprite('cutscreen6');
			removeLuaSprite('cutscreen7');
			removeLuaSprite('cutscreen8');
			removeLuaSprite('cutscreen9');
			toggleHud(true);
	end
		
end

local allowEndShit = false

function onEndSong()
if not allowEndShit and isStoryMode and not seenCutscene then
		setProperty('inCutscene', true);
		startDialogue('dialogue2', ''); 
		makeLuaSprite('garagecutscreen', 'garagecutscreen', 0, 0);
		scaleObject('garagecutscreen', 0.83, 0.83);
		addLuaSprite('garagecutscreen', true);
		setObjectCamera('garagecutscreen', 'hud');
		setObjectOrder('garagecutscreen', 0);
	allowEndShit = true;
	return Function_Stop;
       end
 return Function_Continue;
end
