package states;

import com.loading.basicResources.ImageLoader;
import com.loading.Resources;
import com.gEngine.GEngine;
import js.html.Console;
import kha.math.FastVector2;
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

	var display: RectangleDisplay;
	
	override function init() {
		simulationLayer = new Layer();
		stage.addChild(simulationLayer);

		GlobalGameData.simulationLayer = simulationLayer;
	

		player = new Player(screenWidth / 2, screenHeight - 30, simulationLayer);
		addChild(player);
		GlobalGameData.player=player;

		spawnBall(screenWidth / 2, screenHeight / 2, new FastVector2(1,1));

		frame = new Frame(screenHeight, screenWidth);

	}


	function spawnBall(x:Float, y:Float, velocity:FastVector2){
		var ball = new BouncingBall(x, y, simulationLayer, enemyCollision );
		ball.velocity = velocity;
		addChild(ball);
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
		frame.collide(enemyCollision, ballVsFrame);
		
		CollisionEngine.overlap(player.collision, enemyCollision, playerVsEnemy);
		CollisionEngine.collide(player.bulletsCollision, enemyCollision, bulletVsBall);
	}


	function playerVsFrame(playerC:ICollider,invaderC:ICollider){
		Console.log("Collided with edge");
	}

	function bulletVsBall(bulletC:ICollider,ballC:ICollider){
		var bullet:Bullet=cast bulletC.userData;
		var ball:BouncingBall=cast ballC.userData;
		bullet.die();
		ball.die();
		//La linea siguiente es la que causa quilombo!
		spawnBall(ball.x, ball.y, new FastVector2(ball.velocity.x,ball.velocity.y));
	}

	function ballVsFrame(enemyC:ICollider, frame){
		var enemy:BouncingBall=cast enemyC.userData;
		var frame:String=cast frame.userData;
		enemy.bounce(frame);
	}

	function playerVsEnemy(playerC:ICollider, invaderC:ICollider) {
		changeState(new EndGame(false));
	}
}
