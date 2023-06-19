package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import haxe.Timer;
import lime.app.Future;
import lime.app.Promise;
import openfl.display.BitmapData;
import sys.FileSystem.readDirectory as getAssets;

using StringTools;

class Cache extends MusicBeatState
{
	// Components (Don't touch!!)
	var initialized:Bool;
	var totalAssets:Int;
	var curAssets:Int;
	var shitz:FlxText;

	// Sources
	var gallerySource:String = "mods/images/exciting/gallery/images";
	var creditIconsSource:String = "assets/images/credits";

	// Processings
	var loadingGallery:Future<Map<String, BitmapData>>;
	var loadingCreditIcons:Future<Map<String, BitmapData>>;

	// Targets
	public static var gallery:Map<String, BitmapData> = [];
	public static var creditIcons:Map<String, BitmapData> = [];

	override function create()
	{
		super.create();
		FlxG.mouse.visible = initialized = false;
		curAssets = totalAssets = 0;

		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('loading/loading-' + FlxG.random.int(1, 5)));
		menuBG.screenCenter();
		add(menuBG);

		shitz = new FlxText(12, 12, 0, "", 32);
		shitz.scrollFactor.set();
		shitz.setFormat("G.B.BOOT", 32, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
		add(shitz);

		new FlxTimer().start(function(tmr)
		{
			loadingGallery = loadBitmapListFrom(gallerySource);
			loadingGallery.onComplete(bmaps -> gallery = bmaps);
			loadingGallery.onError(e -> trace(e));

			loadingCreditIcons = loadBitmapListFrom(creditIconsSource);
			loadingCreditIcons.onComplete(bmaps -> creditIcons = bmaps);
			loadingCreditIcons.onError(e -> trace(e));

			initialized = true;
		});
	}

	function traceProgress()
	{
		trace('Loading... ($curAssets/$totalAssets)');
	}

	function loadBitmapListFrom(src:String):Future<Map<String, BitmapData>>
	{
		var loadedBmaps:Map<String, BitmapData> = [];
		var loader:Promise<Map<String, BitmapData>> = new Promise<Map<String, BitmapData>>();
		var srcContent = getAssets(src);
		var timer:Timer = new Timer(250);
		var total:Int = srcContent.length;
		var counter:Int = 0;

		function cancel(pos:Int)
		{
			loader.error('Graphics load failed from "$src" at item $pos');
			timer.stop();
		}

		totalAssets += total;
		timer.run = function()
		{
			var newName:String = srcContent[counter];

			if (!newName.endsWith('.png'))
			{
				cancel(counter);
				return;
			}

			var newBmp:Null<BitmapData> = BitmapData.fromFile('$src/${newName}');

			if (newBmp == null)
			{
				cancel(counter);
				return;
			}

			loadedBmaps.set(newName.replace('.png', ''), newBmp);
			counter++;
			curAssets++;
			loader.progress(counter, total);
			traceProgress();

			if (counter == total)
			{
				loader.complete(loadedBmaps);
				timer.stop();
			};
		};
		return loader.future;
	}

	override function update(elapsed)
	{
		super.update(elapsed);

		if (initialized)
		{
			shitz.text = 'GAME IS LOADING\nPLEASE WAIT... ($curAssets/$totalAssets)';

			if (loadingGallery.isComplete && loadingCreditIcons.isComplete)
			{
				initialized = false;
				shitz.color = FlxColor.LIME;
				shitz.text = '\nGAME LOADED!!';
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxFlicker.flicker(shitz, 1, true, false, flk -> MusicBeatState.switchState(new TitleState()));
			}

			if (loadingGallery.isError || loadingCreditIcons.isError)
			{
				initialized = false;
				shitz.color = FlxColor.RED;
				shitz.text = '\nGAME FAILED TO LOAD!';
				FlxG.sound.play(Paths.sound('cancelMenu'));
				new FlxTimer().start(5, tmr -> Sys.exit(1));
			}
		}
	}
}
