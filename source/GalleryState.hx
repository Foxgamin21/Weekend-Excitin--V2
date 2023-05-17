package; 

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.FlxObject;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.input.gamepad.FlxGamepad;
import lime.app.Application;
import flixel.addons.display.FlxBackdrop;
import openfl.utils.Assets as OpenFlAssets;

#if sys
import sys.FileSystem;
#end

using StringTools;

class GalleryState extends MusicBeatState
{
    var curSprite:Int = 0;
    var descriptionText:FlxText;
    var curSpriteTxt:FlxText;
    var chess:FlxBackdrop;
    var leftArrow:FlxSprite;
    var rightArrow:FlxSprite;

    var galSprite:FlxSprite;

    var folder:String = Paths.mods('images/exciting/gallery/images');

    var spritesPushed:Array<String> = [];
    var spriteAmount:Int = 0;

    var textList:Array<String> = [
        'The Weekend Excitin',//0
        'Ref of Kochi',//1
        'Ref of Hika',//2
        'Ref of Tsubasa',//3
        'Ref of Ren',//4
        'Weekend Excitin thumbnail',//5
        'Sketch',//6
        'I hope she made lotsa spaghetti',//7

    ];

    override function create()
    {
        #if desktop
        DiscordClient.changePresence("In Gallery", null);
        #end
        var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG_b'));
		bg.scrollFactor.set();
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

        chess = new FlxBackdrop(Paths.image('mebg'), 0, 0, true, false);
		chess.scrollFactor.set(0, 0.8);
		chess.y -= 80;
		add(chess);

		chess.offset.x -= 0;
		chess.offset.y += 0;
		chess.velocity.x = 20;
		
	var outline = new FlxSprite().loadGraphic(Paths.image('title/outline'));
		outline.scrollFactor.set(0,0);
		outline.updateHitbox();
		outline.screenCenter();
		outline.antialiasing = true;
		add(outline);

        galSprite = new FlxSprite().loadGraphic(Paths.image('exciting/gallery/images/' + 'weekend' + curSprite));
        galSprite.scrollFactor.set();
        galSprite.updateHitbox();
        galSprite.screenCenter();
        galSprite.antialiasing = ClientPrefs.globalAntialiasing;
        add(galSprite);
        galSprite.setGraphicSize(FlxG.width, FlxG.height);

        var black:FlxSprite = new FlxSprite(0, 600).makeGraphic(FlxG.width, 200, FlxColor.BLACK);
        black.alpha = 0.7;
        add(black);

	var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
	var bgYellow:FlxSprite = new FlxSprite(0, 56).makeGraphic(FlxG.width, 386, 0xFFF9CF51);

        descriptionText = new FlxText(100, 630, 0, "Hi", 32);
        descriptionText.setFormat(Paths.font("PressStartK.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        descriptionText.scrollFactor.set();
	descriptionText.scale.set(0.8, 0.8);
        add(descriptionText);

        curSpriteTxt = new FlxText(1120, 20, 0, "Hi", 32);     
        curSpriteTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        curSpriteTxt.scrollFactor.set();
        curSpriteTxt.scale.set(1.5, 1.5);
        add(curSpriteTxt);

        var returnText = new FlxText(50, 20, 0, 'Press ESC to return.', 24);
        returnText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        returnText.borderSize = 2;
	returnText.scale.set(1.3, 1.3);
        add(returnText);

        leftArrow = new FlxSprite(60, 0);
        leftArrow.frames = ui_tex;
        leftArrow.animation.addByPrefix('idle', "arrow left");
	leftArrow.animation.addByPrefix('press', "arrow push left", 24, false);
	leftArrow.animation.play('idle');
        leftArrow.screenCenter(Y);
        add(leftArrow);

        rightArrow = new FlxSprite(1280 - 35 - 60, 0);
        rightArrow.frames = ui_tex;
        rightArrow.animation.addByPrefix('idle', "arrow right");
	rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
	rightArrow.animation.play('idle');
        rightArrow.screenCenter(Y);
        add(rightArrow);


        if(FileSystem.exists(folder))
        {
            for (file in FileSystem.readDirectory(folder))
            {
                if(!spritesPushed.contains(file))
                {
                    spritesPushed.push(file);
                }
            }
        }

        spriteAmount = spritesPushed.length - 1;
    }

    override function update(elapsed:Float) 
    {
        if (controls.BACK)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
			}

        if (controls.UI_RIGHT_P)
		    {
			    FlxG.sound.play(Paths.sound('scrollMenu'));
				    changeSprite(1);

		    }
        if (controls.UI_LEFT_P)
            {
                FlxG.sound.play(Paths.sound('scrollMenu'));
                changeSprite(-1);
            } 
	var gamepad:FlxGamepad = FlxG.gamepads.lastActive;
 	
	if (controls.UI_LEFT || (gamepad != null && gamepad.pressed.DPAD_LEFT))

		leftArrow.animation.play('press');
        else
           	leftArrow.animation.play('idle');
	       
        if (controls.UI_RIGHT || (gamepad != null && gamepad.pressed.DPAD_RIGHT))

	    rightArrow.animation.play('press');
        else
            rightArrow.animation.play('idle');

        
	descriptionText.text = textList[curSprite];
        
        
        curSpriteTxt.text = Std.string(1 + curSprite + '/' + (1 + spriteAmount));

        super.update(elapsed);  
    }

    function changeSprite(amount:Int)
    {
        curSprite += amount;
        if (curSprite < 0)  
            curSprite = spriteAmount;
        else if (curSprite > spriteAmount)
            curSprite = 0; 

        trace(curSprite);
        remove(galSprite);
        galSprite = new FlxSprite().loadGraphic(Paths.image('exciting/gallery/images/' + 'weekend' + curSprite));
        galSprite.setGraphicSize(FlxG.width, FlxG.height);
        galSprite.screenCenter();
        add(galSprite);
    }

       
   
}