package gameObjects;

import com.collision.platformer.CollisionEngine;
import com.collision.platformer.ICollider;
import com.collision.platformer.CollisionBox;

class Frame {
    private var _screenHeight: Int;
    private var _screenWidth: Int;
    private var _edges = {
        top: null,
        left: null,
        bottom: null,
        right: null,
    };

    public function new(screenHeight: Int, screenWidth: Int) {
        _screenHeight = screenHeight;
        _screenWidth = screenWidth;

        _edges.top = initCollisionBox("top", 'horizontal', { x: 0, y: 0 });
        _edges.left = initCollisionBox("left", 'vertical', { x: 0, y: 0 });
        _edges.bottom = initCollisionBox("bottom", 'horizontal', { x: 0, y: screenHeight });
        _edges.right = initCollisionBox("right", 'vertical', { x: screenWidth, y: 0 });
    }

    private function initCollisionBox(name:String, orientation: String, position: { x: Int, y: Int }) {
		var box = new CollisionBox();
        box.userData = name;

        box.width = orientation == 'horizontal' ? _screenWidth : 0;
		box.height = orientation == 'vertical' ? _screenHeight : 0;
		box.x = position.x;
		box.y = position.y;
		box.staticObject=true;

        return box;
    }

    public function update(dt:Float) {
        _edges.top.update(dt);
        _edges.left.update(dt);
        _edges.bottom.update(dt);
        _edges.right.update(dt);
    }

    public function collide(collider:ICollider, ?notifyCallback:(ICollider, ICollider) -> Void): Bool {
        var collidedTop = CollisionEngine.collide(collider, _edges.top, notifyCallback);
        var collidedLeft = CollisionEngine.collide(collider, _edges.left, notifyCallback);
        var collidedBottom = CollisionEngine.collide(collider, _edges.bottom, notifyCallback);
        var collidedRight = CollisionEngine.collide(collider, _edges.right, notifyCallback);

        return collidedTop
            || collidedLeft
            || collidedBottom
            || collidedRight;
    }
}
