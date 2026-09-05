package mobile.controls;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;

class Hitbox extends FlxSpriteGroup
{
	public var buttons:Array<HitboxButton> = [];

	static var directions:Array<String> = ["left", "down", "up", "right"];
	static var directionColors:Array<FlxColor> = [0xFFC24B99, 0xFF00FFFF, 0xFF12FA05, 0xFFF9393F];

	public function new()
	{
		super();

		for (i in 0...directions.length)
		{
			var button:HitboxButton = new HitboxButton(0, 0, 100, 100, directions[i], directionColors[i]);
			buttons.push(button);
			add(button);
		}
	}

	public function setLayout(positions:Array<Float>, y:Float, width:Float, height:Float):Void
	{
		for (i in 0...buttons.length)
			buttons[i].setup(positions[i] - (width / 2), y, width, height);
	}

	public function setVisualsAlpha(value:Float):Void
	{
		for (button in buttons)
			button.visualAlpha = value;
	}

	override public function update(elapsed:Float):Void
	{
		for (button in buttons)
			button.checkTouches();

		super.update(elapsed);
	}

	public function pressed(direction:String):Bool
	{
		for (button in buttons)
			if (button.direction == direction)
				return button.pressed;

		return false;
	}

	public function justPressed(direction:String):Bool
	{
		for (button in buttons)
			if (button.direction == direction)
				return button.justPressed;

		return false;
	}

	public function justReleased(direction:String):Bool
	{
		for (button in buttons)
			if (button.direction == direction)
				return button.justReleased;

		return false;
	}
}

class HitboxButton extends FlxSprite
{
	public var direction:String;
	public var pressed:Bool = false;
	public var justPressed:Bool = false;
	public var justReleased:Bool = false;

	public var visualAlpha(default, set):Float = 0.00001;

	var wasPressed:Bool = false;
	var heldTouchID:Int = -1;
	var baseColor:FlxColor;

	public function new(x:Float, y:Float, width:Float, height:Float, direction:String, color:FlxColor)
	{
		super(x, y);

		this.direction = direction;
		baseColor = color;

		makeGraphic(Std.int(width), Std.int(height), color);
		solid = false;
		immovable = true;
		scrollFactor.set();
		alpha = visualAlpha;
	}

	public function setup(x:Float, y:Float, width:Float, height:Float):Void
	{
		makeGraphic(Std.int(width), Std.int(height), baseColor);
		setPosition(x, y);
		alpha = visualAlpha;
	}

	function set_visualAlpha(value:Float):Float
	{
		visualAlpha = value;
		alpha = value;
		return value;
	}

	public function checkTouches():Void
	{
		wasPressed = pressed;
		pressed = false;

		if (heldTouchID != -1)
		{
			var touch = FlxG.touches.getByID(heldTouchID);
			if (touch != null && touch.pressed && touch.overlaps(this))
				pressed = true;
			else
				heldTouchID = -1;
		}

		if (!pressed)
		{
			for (touch in FlxG.touches.list)
			{
				if (touch.pressed && touch.overlaps(this))
				{
					pressed = true;
					heldTouchID = touch.touchPointID;
					break;
				}
			}
		}

		justPressed = pressed && !wasPressed;
		justReleased = !pressed && wasPressed;

		if (justPressed)
			flashPress();
	}

	function flashPress():Void
	{
		FlxTween.cancelTweensOf(scale);
		scale.set(1.15, 1.15);
		FlxTween.tween(scale, {x: 1, y: 1}, 0.15, {ease: FlxEase.quadOut});
	}
}
