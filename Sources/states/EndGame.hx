package states;

import com.gEngine.display.Sprite;
import com.loading.basicResources.ImageLoader;
import kha.input.KeyCode;
import com.framework.utils.Input;
import com.gEngine.helpers.Screen;
import com.gEngine.GEngine;
import com.gEngine.display.Text;
import com.loading.basicResources.FontLoader;
import com.loading.basicResources.JoinAtlas;
import com.loading.Resources;
import com.framework.utils.State;
import states.GameState;

class EndGame extends State {

    var score:Float;
    var winState:Bool;
    public function new(winState:Bool, score:Float){
        this.winState = winState;
        this.score = score;
        super();
    }
    override function load(resources:Resources) {
        var atlas=new JoinAtlas(512,512);
        atlas.add(new FontLoader("Kenney_Thick",20));
        atlas.add(new ImageLoader("gameOver"));
        resources.add(atlas);
    }

    override function init() {
        this.stageColor(0.5,0.5,0.5);
        if(winState){
          
        }else{
            var gameOverText=new Text("Kenney_Thick");
            gameOverText.smooth=true;
            gameOverText.x = Screen.getWidth()*0.5-150;
            gameOverText.y = Screen.getHeight()*0.5;
            gameOverText.text="Game Over"; 

            var scoreText=new Text("Kenney_Thick");
            scoreText.smooth=true;
            scoreText.x = Screen.getWidth()*0.5-150;
            scoreText.y = Screen.getHeight()*0.5 + 25;
            scoreText.text="Score " + score; 
       

            var continueText=new Text("Kenney_Thick");
            continueText.smooth=true;
            continueText.x = Screen.getWidth()*0.5-150;
            continueText.y = Screen.getHeight()*0.5 + 50;
            continueText.text="Press space to play again" ; 

            stage.addChild(gameOverText);
            stage.addChild(scoreText);
            stage.addChild(continueText);
        }
       
    }
    override function update(dt:Float) {
        super.update(dt);
        if(Input.i.isKeyCodePressed(KeyCode.Space)){
           this.changeState(new GameState());
        }
    }
}