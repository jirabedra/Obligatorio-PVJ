package states;

import js.html.Console;
import gameObjects.Frame;
import com.collision.platformer.ICollider;
import com.collision.platformer.CollisionEngine;
import gameObjects.Invader;
import gameObjects.Player;
import com.framework.utils.State;

import com.gEngine.display.Layer;
import com.gEngine.helpers.RectangleDisplay;

class GameState extends State {
	static var screenWidth: Int = 1280;
	static var screenHeight: Int = 720;

	var simulationLayer: Layer;
	var player: Player;
	var invader: Invader;
	var frame: Frame;

	var display: RectangleDisplay;
	
	override function init() {
		simulationLayer = new Layer();
		stage.addChild(simulationLayer);
		player = new Player(100, 100, simulationLayer);
		addChild(player);

		invader = new Invader(300, 300, simulationLayer);
		addChild(invader);

		frame = new Frame(screenHeight, screenWidth);
	}

	override function update(dt:Float) {
		super.update(dt);

		frame.update(dt);
		frame.collide(player.collision, playerVsFrame);
		
        CollisionEngine.collide(player.collision,invader.collision,playerVsInvader);
	}

    function playerVsInvader(playerC:ICollider,invaderC:ICollider) {
      ///  player.die();
    }

	function playerVsFrame(playerC:ICollider,invaderC:ICollider){
		Console.log("Collided with edge");
	}

}
