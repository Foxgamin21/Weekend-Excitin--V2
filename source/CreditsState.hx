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
	var iconSprite:FlxSprite;
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

		iconSprite = new FlxSprite(username.width / 2).loadGraphic(Paths.image('credits/${data.icon != null ? data.icon : data.name.toLowerCase()}'));
		iconSprite.setGraphicSize(100, 100);
		iconSprite.updateHitbox();
		iconSprite.antialiasing = ClientPrefs.globalAntialiasing;
		iconSprite.x -= iconSprite.width / 2;
		add(iconSprite);

		bumpHost = new Timer(Conductor.crochet);
		bumpHost.run = bump;
	}

	function bump()
	{
		FlxTween.cancelTweensOf(iconSprite);
		FlxTween.angle(iconSprite, 15 * (bumpToLeft ? -1 : 1), 0, (Conductor.stepCrochet * 3) / 1000, {ease: FlxEase.quadOut});
		bumpToLeft = !bumpToLeft;
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

<<<<<<< HEAD
		persistentUpdate = true;
		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat2'));
		add(bg);
		bg.screenCenter();
		
		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		#if MODS_ALLOWED
		var path:String = 'modsList.txt';
		if(FileSystem.exists(path))
		{
			var leMods:Array<String> = CoolUtil.coolTextFile(path);
			for (i in 0...leMods.length)
			{
				if(leMods.length > 1 && leMods[0].length > 0) {
					var modSplit:Array<String> = leMods[i].split('|');
					if(!Paths.ignoreModFolders.contains(modSplit[0].toLowerCase()) && !modsAdded.contains(modSplit[0]))
					{
						if(modSplit[1] == '1')
							pushModCreditsToList(modSplit[0]);
						else
							modsAdded.push(modSplit[0]);
					}
				}
			}
		}

		var arrayOfFolders:Array<String> = Paths.getModDirectories();
		arrayOfFolders.push('');
		for (folder in arrayOfFolders)
		{
			pushModCreditsToList(folder);
		}
		#end

		var pisspoop:Array<Array<String>> = [ //Name - Icon name - Description - Link - BG Color
			["Weekend Excitin' mod Team"],
			['foxgaamin_',			'foxgamin',			"Main Programmer/Artist/Animator/Composer of Weekend Excitin'",	'https://twitter.com/foxgamin_',		'F3992F'],
			['Kitsuism',			'kitsuism',			"Programmer of Weekend Excitin', helped with dialogue writing and grammar",					'https://twitter.com/Kitsuism',			'D70000'],
			['Gamerpablito',		'gamerpablito',		"Programmer of Weekend Excitin'",								'https://twitter.com/GamerPablito1',	'66AFE6'],
			['Mupvof',				'mupvof',			"Icon artist of Weekend Excitin'",								'https://twitter.com/Mupvof26',			'BEAEFA'],
			['Noza',				'noza',				"Composer for Weekend Excitin'",								'https://www.youtube.com/@Noza37131',	'2986CC'],
			['Bluusagi370',			'bluusagi370',		"Composer for Weekend Excitin'",								'https://twitter.com/bluusagi370',		'C0FF31'],
			['Heartly',				'heartly',			'Voice actor of Kochi',											'https://heartlyartist.carrd.co/',		'FF8AD0'],
			['el_la0323',			'el_la0323',		'Voice actor of Hika',											'https://twitter.com/ellsira33',		'93C47D'],
			['adriarts19',			'adriarts19',		'Voice actor of Tsubasa',										'https://twitter.com/adriarts19',		'FF3277'],
			['Zahaire',				'zahaire',			'Voice actor of Ren',											'https://twitter.com/Zahaire15',		'2D38F8'],
			['Psych Engine Team'],
			['Shadow Mario',		'shadowmario',		'Main Programmer of Psych Engine',								'https://twitter.com/Shadow_Mario_',	'444444'],
			['RiverOaken',			'river',			'Main Artist/Animator of Psych Engine',							'https://twitter.com/RiverOaken',		'B42F71'],
			['shubs',				'shubs',			'Additional Programmer of Psych Engine',						'https://twitter.com/yoshubs',			'5E99DF'],
			[''],
			['Former Engine Members'],
			['bb-panzu',			'bb',				'Ex-Programmer of Psych Engine',								'https://twitter.com/bbsub3',			'3E813A'],
			[''],
			['Engine Contributors'],
			['iFlicky',				'flicky',			'Composer of Psync and Tea Time\nMade the Dialogue Sounds',		'https://twitter.com/flicky_i',			'9E29CF'],
			['SqirraRNG',			'sqirra',			'Crash Handler and Base code for\nChart Editor\'s Waveform',	'https://twitter.com/gedehari',			'E1843A'],
			['PolybiusProxy',		'proxy',			'.MP4 Video Loader Library (hxCodec)',							'https://twitter.com/polybiusproxy',	'DCD294'],
			['KadeDev',				'kade',				'Fixed some cool stuff on Chart Editor\nand other PRs',			'https://twitter.com/kade0912',			'64A250'],
			['Keoiki',				'keoiki',			'Note Splash Animations',										'https://twitter.com/Keoiki_',			'D2D2D2'],
			['Nebula the Zorua',	'nebula',			'LUA JIT Fork and some Lua reworks',							'https://twitter.com/Nebula_Zorua',		'7D40B2'],
			['Smokey',				'smokey',			'Sprite Atlas Support',											'https://twitter.com/Smokey_5_',		'483D92'],
			[''],
			["Funkin' Crew"],
			['ninjamuffin99',		'ninjamuffin99',	"Programmer of Friday Night Funkin'",							'https://twitter.com/ninja_muffin99',	'CF2D2D'],
			['PhantomArcade',		'phantomarcade',	"Animator of Friday Night Funkin'",								'https://twitter.com/PhantomArcade3K',	'FADC45'],
			['evilsk8r',			'evilsk8r',			"Artist of Friday Night Funkin'",								'https://twitter.com/evilsk8r',			'5ABD4B'],
			['kawaisprite',			'kawaisprite',		"Composer of Friday Night Funkin'",								'https://twitter.com/kawaisprite',		'378FC7']
		];
		
		for(i in pisspoop){
			creditsStuff.push(i);
		}
	
		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			optionText.yAdd -= 70;
			if(isSelectable) {
				optionText.x -= 70;
			}
			optionText.forceX = optionText.x;
			//optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(isSelectable) {
				if(creditsStuff[i][5] != null)
				{
					Paths.currentModDirectory = creditsStuff[i][5];
				}

				var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][1]);
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
				Paths.currentModDirectory = '';

				if(curSelected == -1) curSelected = i;
			}
		}
		
		descBox = new AttachedSprite();
		descBox.makeGraphic(1, 1, FlxColor.BLACK);
		descBox.xAdd = -10;
		descBox.yAdd = -10;
		descBox.alphaMult = 0.6;
		descBox.alpha = 0.6;
		add(descBox);

		descText = new FlxText(50, FlxG.height + offsetThing - 25, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER/*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		descText.scrollFactor.set();
		//descText.borderSize = 2.4;
		descBox.sprTracker = descText;
		add(descText);

		bg.color = getCurrentBGColor();
		intendedColor = bg.color;
		changeSelection();
=======
		FlxG.mouse.visible = true;
>>>>>>> bdf949602e57f591d7ab801bd63773dd8f24e735
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
			var daCard = new CreditCard(0, FlxG.height * 0.275, currentScene.members[data]);
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
					}
			});
		}
	}
}
