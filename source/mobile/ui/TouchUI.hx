package mobile.ui;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxSwipe;
import flixel.input.touch.FlxTouch;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

enum abstract TouchButtonID(String) from String to String
{
	var LEFT = "left";
	var DOWN = "down";
	var UP = "up";
	var RIGHT = "right";
	var PAUSE = "pause";
	var ACCEPT = "accept";
	var BACK = "back";
}

class TouchButton extends FlxSprite
{
	public var id:TouchButtonID;
	public var pressed:Bool = false;
	public var justPressed:Bool = false;
	public var justReleased:Bool = false;

	var wasPressed:Bool = false;
	var touchPointer:Int = -1;

	public function new(id:TouchButtonID, x:Float, y:Float, graphicKey:String)
	{
		super(x, y);
		this.id = id;
		frames = Paths.getSparrowAtlas(graphicKey);
		animation.addByPrefix("normal", '${graphicKey}0', 24, false);
		animation.addByPrefix("press", '${graphicKey} press', 24, false);
		animation.play("normal");
		scrollFactor.set();
		alpha = 0.6;
		antialiasing = ClientPrefs.data.antialiasing;
	}

	public function updateState(isDown:Bool, pointerID:Int):Void
	{
		wasPressed = pressed;

		if (isDown && touchPointer == -1)
		{
			touchPointer = pointerID;
			pressed = true;
		}
		else if (!isDown && touchPointer == pointerID)
		{
			touchPointer = -1;
			pressed = false;
		}

		justPressed = pressed && !wasPressed;
		justReleased = !pressed && wasPressed;

		animation.play(pressed ? "press" : "normal");
		alpha = pressed ? 1 : 0.6;
	}
}

class TouchUI extends FlxSpriteGroup
{
	public static var instance:TouchUI;

	public var buttons:Map<TouchButtonID, TouchButton> = new Map();

	public var leftPressed(get, never):Bool;
	public var downPressed(get, never):Bool;
	public var upPressed(get, never):Bool;
	public var rightPressed(get, never):Bool;
	public var pausePressed(get, never):Bool;
	public var pauseJustPressed(get, never):Bool;
	public var acceptPressed(get, never):Bool;
	public var backPressed(get, never):Bool;

	public function new()
	{
		super();
		instance = this;

		if (!isMobilePlatform())
			return;

		addButton(LEFT, 90, FlxG.height - 150);
		addButton(DOWN, 220, FlxG.height - 150);
		addButton(UP, 350, FlxG.height - 150);
		addButton(RIGHT, 480, FlxG.height - 150);
		addButton(PAUSE, FlxG.width - 90, 40);
		addButton(ACCEPT, FlxG.width - 90, FlxG.height - 90);
		addButton(BACK, FlxG.width - 200, FlxG.height - 90);
	}

	function addButton(id:TouchButtonID, x:Float, y:Float):Void
	{
		var btn:TouchButton = new TouchButton(id, x, y, 'touch_${id}');
		buttons.set(id, btn);
		add(btn);
	}

	function isMobilePlatform():Bool
	{
		#if mobile
		return true;
		#else
		return false;
		#end
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (buttons.keys().hasNext())
			pollTouches();
	}

	function pollTouches():Void
	{
		for (btn in buttons)
			btn.updateState(false, -999);

		for (touch in FlxG.touches.list)
		{
			for (btn in buttons)
			{
				if (btn.overlapsPoint(FlxPoint.get(touch.x, touch.y)))
				{
					btn.updateState(true, touch.touchPointID);
					break;
				}
			}
		}
	}

	function get_leftPressed():Bool
		return buttons.exists(LEFT) && buttons.get(LEFT).pressed;

	function get_downPressed():Bool
		return buttons.exists(DOWN) && buttons.get(DOWN).pressed;

	function get_upPressed():Bool
		return buttons.exists(UP) && buttons.get(UP).pressed;

	function get_rightPressed():Bool
		return buttons.exists(RIGHT) && buttons.get(RIGHT).pressed;

	function get_pausePressed():Bool
		return buttons.exists(PAUSE) && buttons.get(PAUSE).pressed;

	function get_pauseJustPressed():Bool
		return buttons.exists(PAUSE) && buttons.get(PAUSE).justPressed;

	function get_acceptPressed():Bool
		return buttons.exists(ACCEPT) && buttons.get(ACCEPT).pressed;

	function get_backPressed():Bool
		return buttons.exists(BACK) && buttons.get(BACK).pressed;
}
