package states;

import js.html.Console;
import haxe.Exception;
import js.html.svg.Number;
import com.loading.basicResources.JoinAtlas;
import com.loading.basicResources.SparrowLoader;
import com.loading.Resources;
import com.collision.platformer.ICollider;
import com.collision.platformer.CollisionEngine;
import gameObjects.Invader;
import com.gEngine.display.Layer;
import gameObjects.Player;
import com.framework.utils.State;
import com.collision.platformer.CollisionBox;

import com.gEngine.display.Layer;
import com.gEngine.helpers.RectangleDisplay;

class SpaceInvader extends State {
	var simulationLayer:Layer;
	var player:Player;
	var invader:Invader;
	var collisionTop : CollisionBox;
	var collisionBottom : CollisionBox;
	var collisionLeft : CollisionBox;
	var collisionRight : CollisionBox;
	static var screenWidth : Int = 1280;
	static var screenHeight : Int = 720;


	var display:RectangleDisplay;
	
	override function init() {
		simulationLayer = new Layer();
		stage.addChild(simulationLayer);
		player = new Player(100, 100, simulationLayer);
		addChild(player);

		invader = new Invader(300, 300, simulationLayer);
		addChild(invader);

		collisionTop = new CollisionBox();
		collisionTop.width = screenWidth;
		collisionTop.height = 3;
		collisionTop.x = 0;
		collisionTop.y = -1;
		collisionTop.staticObject=true;
		
	
        

		collisionBottom = new CollisionBox();
		collisionBottom.width = screenWidth;
		collisionBottom.height = 3;
		collisionBottom.x = -1;
		collisionBottom.y = screenHeight+1;
		collisionBottom.staticObject=true;

		display = new RectangleDisplay();
		display.setColor(12, 220, 105);
		display.scaleX = screenWidth;
		display.scaleY = 1;
		display.x = collisionBottom.x;
		display.y =  collisionBottom.y;
		simulationLayer.addChild(display);

		collisionLeft = new CollisionBox();
		collisionLeft.width = 3;
		collisionLeft.height = screenHeight;
		collisionLeft.x = -1;
		collisionLeft.y = 0;
		collisionLeft.staticObject=true;

		collisionRight = new CollisionBox();
		collisionRight.width = 3;
		collisionRight.height = screenHeight;
		collisionRight.x = screenWidth+1;
		collisionRight.y = 0;
		collisionRight.staticObject=true;
	}

	override function update(dt:Float) {
		super.update(dt);
		collisionTop.update(dt);
        CollisionEngine.collide(player.collision,invader.collision,playerVsInvader);
		CollisionEngine.collide(player.collision,collisionTop,playerVsTopEdge);
		CollisionEngine.collide(player.collision,collisionBottom,playerVsBottomEdge);
		CollisionEngine.collide(player.collision,collisionLeft,playerVsLeftEdge);
		CollisionEngine.collide(player.collision,collisionRight,playerVsRightEdge);
	
	}
    function playerVsInvader(playerC:ICollider,invaderC:ICollider) {
      ///  player.die();
    }

	function playerVsTopEdge(playerC:ICollider,invaderC:ICollider){
		
	}

	function playerVsBottomEdge(playerC:ICollider,invaderC:ICollider){
		
	}

	function playerVsLeftEdge(playerC:ICollider,invaderC:ICollider){
		
	}

	function playerVsRightEdge(playerC:ICollider,invaderC:ICollider){
		
	}

}
