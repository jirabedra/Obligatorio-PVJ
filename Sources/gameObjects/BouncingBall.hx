package gameObjects;
import com.framework.utils.Entity;
import com.gEngine.display.Sprite;
import kha.math.FastVector2;
import com.collision.platformer.CollisionBox;
import com.collision.platformer.CollisionGroup;
import com.gEngine.display.Layer;
import js.html.Console;

class BouncingBall extends Entity {

    var ball : Sprite;
    var velocity:FastVector2;
    var position:FastVector2;
    private static inline var RADIO = 20;
    public var collision:CollisionBox;



	public function new(x:Float, y:Float, layer:Layer, collisionGroup:CollisionGroup) {
		super();
        ball = new Sprite("ball");
        ball.offsetX=-RADIO;
        ball.offsetY=-RADIO;
        ball.x=x;
        ball.y=y;
        layer.addChild(ball);

        collision = new CollisionBox();
		collision.width = 2 * RADIO;
		collision.height = 2 * RADIO;
        collision.x=x;
        collision.y=y;
        collisionGroup.add(collision);
		collision.userData = this;


	}

	override function update(dt:Float) {
		super.update(dt);
		collision.update(dt);
	}

	override function render() {
        super.render();
        ball.x = collision.x + collision.width * 0.5;
		ball.y = collision.y + collision.height * 0.5;
	}

    override function destroy() {
		super.destroy();
        ball.removeFromParent();
        collision.removeFromParent();


	}
}
