package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;
import flixel.addons.display.FlxBackdrop;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.6.1'; // This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var show:String = "";
	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;

	var optionShit:Array<String> = ['story_mode', 'freeplay', 'credits', 'options', 'gallery'];

	var magenta:FlxSprite;
	var line:FlxSprite;
	var menu_character:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;
	var chess:FlxBackdrop;

	override function create()
	{
		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG_b'));
		bg.scrollFactor.set(0, yScroll);
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		chess = new FlxBackdrop(Paths.image('mebg2'), #if (flixel < "5.0.0") 0, 0, true, false #else XY #end);
		chess.scrollFactor.set(0, 0.8);
		chess.y -= 80;
		chess.velocity.x = 20;
		add(chess);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		var random = FlxG.random.float(0, 100);
		trace(random);
		if (random >= 0 && random <= 20)
		{
			trace('kochi');
			show = 'kochi';
		}

		if (random >= 20.1 && random <= 40)
		{
			trace('hika');
			show = 'hika';
		}
		if (random >= 40.1 && random <= 60)
		{
			trace('tsubasa');
			show = 'tsubasa';
		}
		if (random >= 60.1 && random <= 80)
		{
			trace('ren');
			show = 'ren';
		}
		if (random >= 80.1 && random <= 100)
		{
			trace('cat');
			show = 'cat';
		}

		switch (show)
		{
			case 'kochi':
				menu_character = new FlxSprite(650, 180);
				menu_character.frames = Paths.getSparrowAtlas('mainmenuchrs/kochi title');
				menu_character.antialiasing = true;
				menu_character.animation.addByPrefix('bump', 'kochi_title', 24, true);
				menu_character.updateHitbox();
				menu_character.scale.set(1.3, 1.3);
				menu_character.animation.play('bump');
				add(menu_character);
			case 'hika':
				menu_character = new FlxSprite(720, 200);
				menu_character.frames = Paths.getSparrowAtlas('mainmenuchrs/hika title');
				menu_character.antialiasing = true;
				menu_character.animation.addByPrefix('bump', 'hika_title', 24, true);
				menu_character.updateHitbox();
				menu_character.scale.set(1.3, 1.3);
				menu_character.animation.play('bump');
				add(menu_character);
			case 'tsubasa':
				menu_character = new FlxSprite(690, 120);
				menu_character.frames = Paths.getSparrowAtlas('mainmenuchrs/tsubasa title');
				menu_character.antialiasing = true;
				menu_character.animation.addByPrefix('bump', 'tsubasa_title', 24, true);
				menu_character.updateHitbox();
				menu_character.scale.set(1.3, 1.3);
				menu_character.animation.play('bump');
				add(menu_character);
			case 'ren':
				menu_character = new FlxSprite(750, 120);
				menu_character.frames = Paths.getSparrowAtlas('mainmenuchrs/ren title');
				menu_character.antialiasing = true;
				menu_character.animation.addByPrefix('bump', 'ren_tittle', 24, true);
				menu_character.updateHitbox();
				menu_character.scale.set(1.3, 1.3);
				menu_character.animation.play('bump');
				add(menu_character);
			case 'cat':
				menu_character = new FlxSprite(800, 480);
				menu_character.frames = Paths.getSparrowAtlas('mainmenuchrs/lucky cat title');
				menu_character.antialiasing = true;
				menu_character.animation.addByPrefix('bump', 'lucky_cat_title', 24, true);
				menu_character.updateHitbox();
				menu_character.scale.set(1.3, 1.3);
				menu_character.animation.play('bump');
				add(menu_character);
		}

		line = new FlxSprite().loadGraphic(Paths.image('menubg/line2'));
		line.scrollFactor.set(0, 0);
		line.updateHitbox();
		line.screenCenter();
		line.antialiasing = true;
		add(line);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.set(0, yScroll);
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		magenta.color = 0xFFfd719b;
		add(magenta);

		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 1;
		/*if(optionShit.length > 6) {
			scale = 10 / optionShit.length;
		}*/

		for (i in 0...optionShit.length)
			// Story Mode
			var offset:Float = 108 - (Math.max(optionShit.length, 5) - 4) * 80;
		var menuItem:FlxSprite = new FlxSprite(100, 57);
		menuItem.scale.x = scale;
		menuItem.scale.y = scale;
		menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[0]);
		menuItem.animation.addByPrefix('idle', optionShit[0] + " basic", 24);
		menuItem.animation.addByPrefix('selected', optionShit[0] + " white", 24);
		menuItem.animation.play('idle');
		menuItem.ID = 0;
		menuItem.angle = 5;
		menuItem.setGraphicSize(Std.int(menuItem.width * 0.80));
		// menuItem.screenCenter(X);
		menuItems.add(menuItem);
		var scr:Float = (optionShit.length - 4) * 0.135;
		if (optionShit.length < 6)
			scr = 0;
		menuItem.scrollFactor.set(0, scr);
		menuItem.antialiasing = ClientPrefs.globalAntialiasing;
		// menuItem.setGraphicSize(Std.int(menuItem.width * 0.68));
		FlxTween.tween(menuItem, {x: 120}, 2.5, {ease: FlxEase.backOut});
		menuItem.updateHitbox();

		// FreePlay Mode
		var offset:Float = 108 - (Math.max(optionShit.length, 5) - 4) * 80;
		var menuItem:FlxSprite = new FlxSprite(100, 187);
		menuItem.scale.x = scale;
		menuItem.scale.y = scale;
		menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[1]);
		menuItem.animation.addByPrefix('idle', optionShit[1] + " basic", 24);
		menuItem.animation.addByPrefix('selected', optionShit[1] + " white", 24);
		menuItem.animation.play('idle');
		menuItem.ID = 1;
		menuItem.angle = 2;
		menuItem.setGraphicSize(Std.int(menuItem.width * 0.80));
		// menuItem.screenCenter(X);
		menuItems.add(menuItem);
		var scr:Float = (optionShit.length - 4) * 0.135;
		if (optionShit.length < 6)
			scr = 1;
		menuItem.scrollFactor.set(1, scr);
		menuItem.antialiasing = ClientPrefs.globalAntialiasing;
		// menuItem.setGraphicSize(Std.int(menuItem.width * 0.68));
		FlxTween.tween(menuItem, {x: 120}, 2.5, {ease: FlxEase.backOut});
		menuItem.updateHitbox();

		// Credits
		var offset:Float = 108 - (Math.max(optionShit.length, 5) - 4) * 80;
		var menuItem:FlxSprite = new FlxSprite(100, 320);
		menuItem.scale.x = scale;
		menuItem.scale.y = scale;
		menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[2]);
		menuItem.animation.addByPrefix('idle', optionShit[2] + " basic", 24);
		menuItem.animation.addByPrefix('selected', optionShit[2] + " white", 24);
		menuItem.animation.play('idle');
		menuItem.ID = 2;
		menuItem.angle = -2;
		menuItem.setGraphicSize(Std.int(menuItem.width * 0.80));
		// menuItem.screenCenter(X);
		menuItems.add(menuItem);
		var scr:Float = (optionShit.length - 4) * 0.135;
		if (optionShit.length < 6)
			scr = 2;
		menuItem.scrollFactor.set(2, scr);
		menuItem.antialiasing = ClientPrefs.globalAntialiasing;
		// menuItem.setGraphicSize(Std.int(menuItem.width * 0.68));
		FlxTween.tween(menuItem, {x: 120}, 2.5, {ease: FlxEase.backOut});
		menuItem.updateHitbox();

		// Options
		var offset:Float = 108 - (Math.max(optionShit.length, 5) - 4) * 80;
		var menuItem:FlxSprite = new FlxSprite(100, 450);
		menuItem.scale.x = scale;
		menuItem.scale.y = scale;
		menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[3]);
		menuItem.animation.addByPrefix('idle', optionShit[3] + " basic", 24);
		menuItem.animation.addByPrefix('selected', optionShit[3] + " white", 24);
		menuItem.animation.play('idle');
		menuItem.ID = 3;
		menuItem.angle = -5;
		menuItem.setGraphicSize(Std.int(menuItem.width * 0.80));
		// menuItem.screenCenter(X);
		menuItems.add(menuItem);
		var scr:Float = (optionShit.length - 4) * 0.135;
		if (optionShit.length < 6)
			scr = 3;
		menuItem.scrollFactor.set(3, scr);
		menuItem.antialiasing = ClientPrefs.globalAntialiasing;
		// menuItem.setGraphicSize(Std.int(menuItem.width * 0.68));
		FlxTween.tween(menuItem, {x: 120}, 2.5, {ease: FlxEase.backOut});
		menuItem.updateHitbox();

		// Gallery
		var offset:Float = 108 - (Math.max(optionShit.length, 5) - 4) * 80;
		var menuItem:FlxSprite = new FlxSprite(100, 570);
		menuItem.scale.x = scale;
		menuItem.scale.y = scale;
		menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_gallery');
		menuItem.animation.addByPrefix('idle', 'gallery basic', 24);
		menuItem.animation.addByPrefix('selected', 'gallery white', 24);
		menuItem.animation.play('idle');
		menuItem.ID = 4;
		menuItem.angle = -7;
		menuItem.setGraphicSize(Std.int(menuItem.width * 0.80));
		// menuItem.screenCenter(X);
		menuItems.add(menuItem);
		var scr:Float = (optionShit.length - 4) * 0.135;
		if (optionShit.length < 6)
			scr = 4;
		menuItem.scrollFactor.set(4, scr);
		menuItem.antialiasing = ClientPrefs.globalAntialiasing;
		// menuItem.setGraphicSize(Std.int(menuItem.width * 0.68));
		FlxTween.tween(menuItem, {x: 120}, 2.5, {ease: FlxEase.backOut});
		menuItem.updateHitbox();

		// FlxG.camera.follow(camFollowPos, null, 2);

		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18)
		{
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if (!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2]))
			{ // It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		super.create();
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement()
	{
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if (FreeplayState.vocals != null)
				FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));
		line.x += 10;
		FlxTween.tween(line, {x: -840}, 2.5, {ease: FlxEase.expoOut});

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					// if(ClientPrefs.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story_mode':
										MusicBeatState.switchState(new StoryMenuState());
									case 'freeplay':
										MusicBeatState.switchState(new FreeplayState());
									#if MODS_ALLOWED
									case 'mods':
										MusicBeatState.switchState(new ModsMenuState());
									#end
									case 'awards':
										MusicBeatState.switchState(new AchievementsMenuState());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'gallery':
										MusicBeatState.switchState(new GalleryState());
									case 'options':
										LoadingState.loadAndSwitchState(new options.OptionsState());
								}
							});
						}
					});
				}
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			// spr.screenCenter(X);
		});
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				var add:Float = 0;
				if (menuItems.length > 5)
				{
					add = menuItems.length * 8;
				}
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				spr.centerOffsets();
			}
		});
	}
}
