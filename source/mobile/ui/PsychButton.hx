package mobile.ui;

import flixel.FlxSprite;
import flixel.FlxG;

enum PsychButtonType
{
	PAUSE;
	BACK;
}

class PsychButton extends FlxSprite
{
	public var pressed:Bool = false;
	public var justPressed:Bool = false;
	public var justReleased:Bool = false;
	public var onClick:Void->Void = null;

	var wasPressed:Bool = false;

	public function new(x:Float, y:Float, type:PsychButtonType, ?onClick:Void->Void)
	{
		super(x, y);

		this.onClick = onClick;

		var imageKey:String;
		var framePrefix:String;

		switch(type)
		{
			case PAUSE:
				imageKey = 'pauseButton';
				framePrefix = 'pause';
			case BACK:
				imageKey = 'backButton';
				framePrefix = 'back';
		}

		frames = Paths.getSparrowAtlas(imageKey);
		animation.addByIndices('idle', framePrefix, [0], "", 24, false);
		animation.addByPrefix('press', framePrefix, 24, false);
		animation.play('idle');

		antialiasing = ClientPrefs.data.antialiasing;
		scrollFactor.set();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

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

		if (!pressed && FlxG.mouse.pressed && FlxG.mouse.overlaps(this))
			pressed = true;

		justPressed = pressed && !wasPressed;
		justReleased = !pressed && wasPressed;

		if (justPressed)
		{
			animation.play('press', true);
			if (onClick != null) onClick();
		}

		if (animation.name == 'press' && animation.finished)
			animation.play('idle');
	}
}
