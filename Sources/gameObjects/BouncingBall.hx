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
    public var velocity:FastVector2;
    private var RADIO = 20;
    public var collision:CollisionBox;
    public var speed:Float = 256;

    public var x(get, null):Float;
	private inline function get_x():Float{
		return ball.x;
	}

	public var y(get, null):Float;
	private inline function get_y():Float{
		return ball.y;
	}

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

        velocity = new FastVector2(1,1);

	}

	override function update(dt:Float) {
		super.update(dt);
		collision.update(dt);
        velocity.setFrom(velocity.normalized());

        collision.velocityX = velocity.x * speed;
		collision.velocityY = velocity.y * speed;
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

    public function bounce(name:String){
        switch(name){
            case "top": 
                velocity.y *= -1;
            case "bottom": 
                velocity.y *= -1;
            case "right": 
                velocity.x *= -1;
            case "left": 
                velocity.x *= -1;
        }
    }
}
