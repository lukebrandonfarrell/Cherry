//
//  gameover.swift
//  Cherry
//
//  Created by Luke Farrell on 12/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class gameover : cherryscene {
    var newscored : TextObject = TextObject(fontNamed: "AvenirNext-Heavy");
    var score : TextObject = TextObject(fontNamed: "AvenirNext-Heavy");
    var playagain_btn : TextObject = TextObject(fontNamed: "AvenirNext-Heavy");
    var quit_btn : TextObject = TextObject(fontNamed: "AvenirNext-Heavy");
    
    var autoresume_btn : TextObject = TextObject(fontNamed: "AvenirNext-Heavy");
    
    var newhighscore: TextObject = TextObject(fontNamed: "AvenirNext-Heavy");
    
    var backgroundshape : ShapeObject = ShapeObject();
    
    var isNewhighscore:Bool = false;
    
    override init(size: CGSize) {
        super.init(size: size);
        loadHint(); //If scene uses hints, load this
        
        newscored.setup(text: "NEW HIGH SCORE!", name: "newscore", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.75), size:90, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        score.setup(text: "0", name: "score", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.56), size: 155, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        playagain_btn.setup(text: "PLAY AGAIN", name: "playagain", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.3), size: 80, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        quit_btn.setup(text: "QUIT", name: "quit", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.18), size: 80, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        
        autoresume_btn.setup(text: "AUTOPLAY OFF", name: "autoplay", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.42), size: 80, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1)
        addChild(autoresume_btn);
        
        addChild(newscored);
        addChild(score);
        addChild(playagain_btn);
        addChild(quit_btn);
        
        backgroundshape.path = UIBezierPath(roundedRect: CGRect(x: Game.GetX(value: 0.15), y: Game.GetY(value: 0.1), width: Game.GetX(value: 0.7), height: Game.GetY(value: 0.8)), cornerRadius: 25).cgPath;
        backgroundshape.fillColor = SKColor.black;
        backgroundshape.alpha = 0.15;
        backgroundshape.lineWidth = 0.0;
        addChild(backgroundshape);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(netHex: Game.GameOverBackgroundColor);
        
        score.text = String(Game.score);
        isNewhighscore = false;
        
        //Check if highscore is higher than one of the current highscores
        for score in Game.highscore {
            if Game.score > score {
                isNewhighscore = true
                break  // We can break once we find a new high score
            }
        }
        
        if(isNewhighscore){
            newscored.text = "NEW HIGH SCORE!";
        }else{
            newscored.text = "GAME OVER";
        }
        
        if(Game.autoplayON){
            autoresume_btn.text = "AUTOPLAY ON";
        }else{
            autoresume_btn.text = "AUTOPLAY OFF";
        }
        
        if(Game.GameOverBackgroundColor == 0xFFFFFF){
            newscored.fontColor = SKColor.black;
            score.fontColor = SKColor.black;
            autoresume_btn.fontColor = SKColor.black;
            playagain_btn.fontColor = SKColor.black;
            quit_btn.fontColor = SKColor.black;
        }else{
            newscored.fontColor = SKColor.white;
            score.fontColor = SKColor.white;
            autoresume_btn.fontColor = SKColor.white;
            playagain_btn.fontColor = SKColor.white;
            quit_btn.fontColor = SKColor.white;
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var node:SKNode = SKNode();
        if let touch = touches.first {
            let location = touch.location(in: self);
            node = self.atPoint(location);
        }
        
        if(node.name == "playagain"){
            Game.soundManager.playSound(str: "click");
            Game.skView.presentScene(Game.scenes_gamescene!, transition: SKTransition.fade(with: UIColor.black, duration: TimeInterval(Game.SceneFade)));
        }
        
        if(node.name == "quit"){
            Game.soundManager.playSound(str: "click");
            Game.skView.presentScene(Game.scenes_mainmenu!, transition: SKTransition.fade(with: UIColor.black, duration: TimeInterval(Game.SceneFade)));
        }
        
        if(node.name == "autoplay"){
            if(Game.autoplayON){
                autoresume_btn.text = "AUTOPLAY OFF";
                Game.autoplayON = false;
            }else{
                autoresume_btn.text = "AUTOPLAY ON";
                Game.autoplayON = true;
            }
            Game.soundManager.playSound(str: "click");
            
            Game.saveGame.saveBool(data: Game.autoplayON, key: Game.saveGame.keyAutoplay);
        }
    }
}
