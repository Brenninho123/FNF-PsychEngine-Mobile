package mobile.controls;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;

class Hitbox extends FlxSpriteGroup
{
	public var buttons:Array<HitboxButton> = [];

	public function new()
	{
		super();

		var directions:Array<String> = ["left", "down", "up", "right"];
		var buttonWidth:Float = FlxG.width / directions.length;

		for (i in 0...directions.length)
		{
			var button:HitboxButton = new HitboxButton(i * buttonWidth, 0, buttonWidth, FlxG.height, directions[i]);
			buttons.push(button);
			add(button);
		}
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

	var wasPressed:Bool = false;

	public function new(x:Float, y:Float, width:Float, height:Float, direction:String)
	{
		super(x, y);

		this.direction = direction;

		makeGraphic(Std.int(width), Std.int(height), FlxColor.TRANSPARENT);
		solid = false;
		immovable = true;
		scrollFactor.set();
	}

	public function checkTouches():Void
	{
		wasPressed = pressed;
		pressed = false;

		for (touch in FlxG.touches.list)
		{
			if (touch.overlaps(this))
			{
				pressed = true;
				break;
			}
		}

		justPressed = pressed && !wasPressed;
		justReleased = !pressed && wasPressed;
	}
}
