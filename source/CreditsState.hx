package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import haxe.Json;
import haxe.Timer;
import sys.io.File;

using StringTools;

#if desktop
import Discord.DiscordClient;
#end

typedef CreditSection =
{
	title:String,
	members:Array<CreditMember>
}

typedef CreditMember =
{
	name:String,
	?icon:String,
	desc:String,
	link:String
}

class CreditCard extends FlxSpriteGroup
{
	var iconSprite:Null<FlxSprite>;
	var username:FlxTypeText;
	var bumpToLeft:Bool = true;
	var link:String;

	public var desc:String;
	public var mouseOver:Bool;
	public var bumpHost:Timer;

	public function new(x:Float, y:Float, data:CreditMember)
	{
		super(x, y);
		this.link = data.link;
		this.desc = data.desc;
		mouseOver = false;
		antialiasing = ClientPrefs.globalAntialiasing;

		username = new FlxTypeText(0, 100, Std.int(FlxG.width * 0.15), data.name, 24);
		username.setFormat(Paths.font('Gbboot.ttf'), 24, CENTER, OUTLINE, FlxColor.BLACK);
		username.antialiasing = ClientPrefs.globalAntialiasing;
		username.start();
		add(username);

		var daSprite = Cache.creditIcons.get(data.icon != null ? data.icon : data.name.toLowerCase());

		if (daSprite != null)
		{
			iconSprite = new FlxSprite(username.width / 2).loadGraphic(daSprite);
			iconSprite.setGraphicSize(100, 100);
			iconSprite.updateHitbox();
			iconSprite.antialiasing = ClientPrefs.globalAntialiasing;
			iconSprite.x -= iconSprite.width / 2;
			add(iconSprite);
		}

		bumpHost = new Timer(Conductor.crochet);
		bumpHost.run = bump;
	}

	function bump()
	{
		if (iconSprite != null)
		{
			FlxTween.cancelTweensOf(iconSprite);
			FlxTween.angle(iconSprite, 15 * (bumpToLeft ? -1 : 1), 0, (Conductor.stepCrochet * 3) / 1000, {ease: FlxEase.quadOut});
			bumpToLeft = !bumpToLeft;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.overlaps(this))
		{
			color = FlxColor.YELLOW;
			mouseOver = true;

			if (FlxG.mouse.justPressed)
				CoolUtil.browserLoad(link);
		}
		else
		{
			color = FlxColor.WHITE;
			mouseOver = false;
		}
	}
}

class CreditsState extends MusicBeatState
{
	var curSelected:Int = 0;
	var source:Array<CreditSection>;
	var cardGroup:FlxTypedGroup<CreditCard>;
	var titleBar:FlxText;
	var descBar:FlxText;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Credits", null);
		#end

		FlxG.mouse.visible = true;
		super.create();
		source = cast Json.parse(File.getContent(Paths.json('credits')));

		var chess = new ChessBG();
		add(chess);

		cardGroup = new FlxTypedGroup<CreditCard>();
		add(cardGroup);

		titleBar = new FlxText(0, 32, FlxG.width, "", 40);
		titleBar.setFormat(Paths.font('pixel.otf'), 40, CENTER, OUTLINE, FlxColor.BLACK);
		titleBar.borderSize = 3;
		add(titleBar);

		descBar = new FlxText(0, FlxG.height - 60, FlxG.width, "", 40);
		descBar.setFormat(Paths.font('MauritzSans.otf'), 40, CENTER);
		add(descBar);

		forEachOfType(FlxText, function(txt)
		{
			txt.screenCenter(X);
			txt.antialiasing = ClientPrefs.globalAntialiasing;
		});
		changeSelection();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.BACK)
		{
			FlxG.mouse.visible = false;
			FlxG.sound.play(Paths.sound('cancelMenu'));
			cardGroup.forEach(card -> card.bumpHost.stop());
			MusicBeatState.switchState(new MainMenuState());
		}

		if (controls.UI_LEFT_P)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			changeSelection(-1);
		}

		if (controls.UI_RIGHT_P)
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));
			changeSelection(1);
		}

		var descAssigned:Bool = false;
		cardGroup.forEach(function(card)
		{
			if (!descAssigned)
			{
				if (card.mouseOver)
				{
					descBar.text = card.desc;
					descAssigned = true;
				}
				else
					descBar.text = "";
			}
		});
	}

	function changeSelection(change:Int = 0)
	{
		curSelected += change;

		if (curSelected < 0)
			curSelected = source.length - 1;
		if (curSelected >= source.length)
			curSelected = 0;

		cardGroup.clear();
		var currentScene = source[curSelected];
		titleBar.text = '< ${currentScene.title} >';

		for (data in 0...currentScene.members.length)
		{
			var daCard = new CreditCard(0, FlxG.height * 0.27, currentScene.members[data]);
			daCard.y += (daCard.height + 12) * Math.floor(data / 4);
			daCard.ID = data;
			cardGroup.add(daCard);
		}

		var da4Groups:Int = Math.floor(currentScene.members.length / 4);
		var daLeftItems:Int = currentScene.members.length % 4;
		var curGroup:Int = 0;

		for (i in 0...da4Groups)
		{
			var curCard:Int = 0;
			cardGroup.forEach(function(card)
			{
				if (curCard >= 4)
					return;

				if (card.ID == Std.int(curCard + (4 * i)))
				{
					switch (curCard)
					{
						case 0:
							card.x = FlxG.width * 0.10;
						case 1:
							card.x = FlxG.width * 0.32;
						case 2:
							card.x = FlxG.width * 0.53;
						case 3:
							card.x = FlxG.width * 0.75;
						default:
					}
					curCard++;
				}
			});

			curGroup++;
		}

		for (i in 0...daLeftItems)
		{
			cardGroup.forEach(function(card)
			{
				if (card.ID == (4 * curGroup) + i)
					switch (daLeftItems)
					{
						case 1:
							card.x = (FlxG.width / 2) - (card.width / 2);
						case 2:
							card.x = (FlxG.width * 0.33) * (1 + i) - (card.width / 2);
						case 3:
							card.x = (FlxG.width * 0.25) * (1 + i) - (card.width / 2);
						default:
					}
			});
		}
	}
}
