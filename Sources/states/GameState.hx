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

import com.loading.basicResources.FontLoader;
import com.loading.basicResources.JoinAtlas;
import com.gEngine.display.Text;
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

	var scoreText : Text;
	var simulationLayer: Layer;
	var player: Player;

	var enemyCollision:CollisionGroup=new CollisionGroup();
	var frame: Frame;

	var display: RectangleDisplay;

	var gottaSpawnNewBalls = false;
	var nextSpawnPosition : FastVector2;
	
	var score = 0;
	override function init() {
		simulationLayer = new Layer();
		stage.addChild(simulationLayer);

		GlobalGameData.simulationLayer = simulationLayer;
	

		player = new Player(screenWidth / 2, screenHeight - 30, simulationLayer);
		addChild(player);
		GlobalGameData.player=player;

		spawnBall(screenWidth / 2, screenHeight / 2, new FastVector2(1,1));

		frame = new Frame(screenHeight, screenWidth);

		scoreText=new Text("Kenney_Thick");
		scoreText.smooth=true;
		scoreText.x = screenWidth-250;
		scoreText.y = 25;
		scoreText.text="Score " + score; 
		stage.addChild(scoreText);

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
		var atlas=new JoinAtlas(512,512);
		atlas.add(new FontLoader("Kenney_Thick",20));
		resources.add(atlas);
    }

	override function update(dt:Float) {
		super.update(dt);

		frame.update(dt);
		frame.collide(player.collision, playerVsFrame);
		frame.collide(enemyCollision, ballVsFrame);
		
		CollisionEngine.overlap(player.collision, enemyCollision, playerVsEnemy);
		CollisionEngine.collide(player.bulletsCollision, enemyCollision, bulletVsBall);

		if(gottaSpawnNewBalls){
			gottaSpawnNewBalls = false;
			spawnBall(nextSpawnPosition.x, nextSpawnPosition.y, new FastVector2(0,-1));
			spawnBall(nextSpawnPosition.x, nextSpawnPosition.y, new FastVector2(1,-1));
			spawnBall(nextSpawnPosition.x, nextSpawnPosition.y, new FastVector2(-1,-1));
		}
	}


	function playerVsFrame(playerC:ICollider,invaderC:ICollider){
		Console.log("Collided with edge");
	}

	function bulletVsBall(bulletC:ICollider,ballC:ICollider){
		var bullet:Bullet=cast bulletC.userData;
		var ball:BouncingBall=cast ballC.userData;
		bullet.die();
		ball.die();
		gottaSpawnNewBalls = true;
		nextSpawnPosition = new FastVector2(ball.x, ball.y);
		scoreText.text = "Score " + ++score;
		Console.log(score);
	}

	function ballVsFrame(enemyC:ICollider, frame){
		var enemy:BouncingBall=cast enemyC.userData;
		var frame:String=cast frame.userData;
		enemy.bounce(frame);
	}

	function playerVsEnemy(playerC:ICollider, invaderC:ICollider) {
		changeState(new EndGame(false, score));
	}
}
