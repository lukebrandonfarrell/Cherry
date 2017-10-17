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
        
        newscored.setup("NEW HIGH SCORE!", name: "newscore", x: Game.GetX(0.5), y: Game.GetY(0.75), size:90, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Center, zPos: 1);
        score.setup("0", name: "score", x: Game.GetX(0.5), y: Game.GetY(0.56), size: 155, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Center, zPos: 1);
        playagain_btn.setup("PLAY AGAIN", name: "playagain", x: Game.GetX(0.5), y: Game.GetY(0.3), size: 80, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Center, zPos: 1);
        quit_btn.setup("QUIT", name: "quit", x: Game.GetX(0.5), y: Game.GetY(0.18), size: 80, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Center, zPos: 1);
        
        autoresume_btn.setup("AUTOPLAY OFF", name: "autoplay", x: Game.GetX(0.5), y: Game.GetY(0.42), size: 80, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Center, zPos: 1)
        addChild(autoresume_btn);
        
        addChild(newscored);
        addChild(score);
        addChild(playagain_btn);
        addChild(quit_btn);
        
        backgroundshape.path = UIBezierPath(roundedRect: CGRect(x: Game.GetX(0.15), y: Game.GetY(0.1), width: Game.GetX(0.7), height: Game.GetY(0.8)), cornerRadius: 25).CGPath;
        backgroundshape.fillColor = SKColor.blackColor();
        backgroundshape.alpha = 0.15;
        backgroundshape.lineWidth = 0.0;
        addChild(backgroundshape);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        backgroundColor = UIColor(netHex: Game.GameOverBackgroundColor);
        
        score.text = String(Game.score);
        isNewhighscore = false;
        
        //Check if highscore is higher than one of the current highscores
        for(var n=0; n<Game.highscore.count; n += 1){
            if(Game.score > Game.highscore[n]){
                isNewhighscore = true;
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
            newscored.fontColor = SKColor.blackColor();
            score.fontColor = SKColor.blackColor();
            autoresume_btn.fontColor = SKColor.blackColor();
            playagain_btn.fontColor = SKColor.blackColor();
            quit_btn.fontColor = SKColor.blackColor();
        }else{
            newscored.fontColor = SKColor.whiteColor();
            score.fontColor = SKColor.whiteColor();
            autoresume_btn.fontColor = SKColor.whiteColor();
            playagain_btn.fontColor = SKColor.whiteColor();
            quit_btn.fontColor = SKColor.whiteColor();
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var node:SKNode = SKNode();
        if let touch = touches.first {
            let location = touch.locationInNode(self);
            node = self.nodeAtPoint(location);
        }
        
        if(node.name == "playagain"){
            Game.soundManager.playSound("click");
            Game.skView.presentScene(Game.scenes_gamescene!, transition: SKTransition.fadeWithColor(UIColor.blackColor(), duration: NSTimeInterval(Game.SceneFade)));
        }
        
        if(node.name == "quit"){
            Game.soundManager.playSound("click");
            Game.skView.presentScene(Game.scenes_mainmenu!, transition: SKTransition.fadeWithColor(UIColor.blackColor(), duration: NSTimeInterval(Game.SceneFade)));
        }
        
        if(node.name == "autoplay"){
            if(Game.autoplayON){
                autoresume_btn.text = "AUTOPLAY OFF";
                Game.autoplayON = false;
            }else{
                autoresume_btn.text = "AUTOPLAY ON";
                Game.autoplayON = true;
            }
            Game.soundManager.playSound("click");
            
            Game.saveGame.saveBool(Game.autoplayON, key: Game.saveGame.keyAutoplay);
        }
    }
}