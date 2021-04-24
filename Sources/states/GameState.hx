package states;

import com.loading.basicResources.ImageLoader;
import com.loading.Resources;
import com.gEngine.GEngine;
import js.html.Console;
import gameObjects.Frame;
import com.collision.platformer.ICollider;
import com.collision.platformer.CollisionGroup;
import com.collision.platformer.CollisionEngine;

import gameObjects.Player;
import gameObjects.Bullet;
import gameObjects.BouncingBall;
import com.framework.utils.State;
import com.framework.utils.Entity;

import com.gEngine.display.Layer;
import com.gEngine.helpers.RectangleDisplay;

class GameState extends State {
	static var screenWidth: Int = 1280;
	static var screenHeight: Int = 720;

	var simulationLayer: Layer;
	var player: Player;

	var enemyCollision:CollisionGroup=new CollisionGroup();
	var frame: Frame;
	var ball: BouncingBall;

	var display: RectangleDisplay;
	
	override function init() {
		simulationLayer = new Layer();
		stage.addChild(simulationLayer);

		GlobalGameData.simulationLayer = simulationLayer;
	

		player = new Player(screenWidth / 2, screenHeight - 30, simulationLayer);
		addChild(player);
		GlobalGameData.player=player;

		ball = new BouncingBall(screenWidth / 2, screenHeight / 2, simulationLayer, enemyCollision );
		addChild(ball);

		frame = new Frame(screenHeight, screenWidth);



	}

	override function load(resources:Resources) {
        resources.add(new ImageLoader("ball"));
        screenWidth = GEngine.i.width;
        screenHeight = GEngine.i.height;
    }

	override function update(dt:Float) {
		super.update(dt);

		frame.update(dt);
		frame.collide(player.collision, playerVsFrame);
		
		CollisionEngine.overlap(player.bulletsCollision, enemyCollision, bulletVsBall);
	}


	function playerVsFrame(playerC:ICollider,invaderC:ICollider){
		Console.log("Collided with edge");
	}

	function bulletVsBall(bulletC:ICollider,ballC:ICollider){
		Console.log("ONEGAI");
		var bullet:Bullet=cast bulletC.userData;
		bullet.die();
		var ball:BouncingBall=cast ballC.userData;
		ball.die();
	}
	
}
