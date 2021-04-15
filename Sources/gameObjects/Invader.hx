package gameObjects;

import com.collision.platformer.CollisionBox;
import com.gEngine.display.Layer;
import com.helpers.Rectangle;
import com.gEngine.helpers.RectangleDisplay;
import com.framework.utils.Entity;

class Invader extends Entity {
	var display:RectangleDisplay;
	public var collision:CollisionBox;

	public function new(x:Float, y:Float, layer:Layer) {
		super();
		display = new RectangleDisplay();
		display.scaleX = 10;
		display.scaleY = 10;
		display.x = x;
		display.y = y;
		display.setColor(0, 255, 0);
		layer.addChild(display);

		collision = new CollisionBox();
		collision.width = 10;
		collision.height = 10;
        collision.x=x;
        collision.y=y;
        collision.staticObject=true;
	}

	override function update(dt:Float) {
		super.update(dt);
		collision.update(dt);
	}

	override function render() {
		super.render();
		display.x = collision.x;
		display.y = collision.y;
	}
}
