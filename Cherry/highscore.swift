//
//  highscore.swift
//  Cherry
//
//  Created by Luke Farrell on 12/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class highscore : cherrymenu {
    var highscore : TextObject = TextObject(fontNamed: "AvenirNext-Heavy");
    
    var highscore_one : TextObject = TextObject(fontNamed: "AvenirNext-DemiBold");
    var highscore_two : TextObject = TextObject(fontNamed: "AvenirNext-DemiBold");
    var highscore_three : TextObject = TextObject(fontNamed: "AvenirNext-DemiBold");
    
    var globalscore_btn : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    var back_btn : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    
    override init(size: CGSize) {
        super.init(size: size);
        loadBackground();
        loadHint(); //If scene uses hints, load this
        
        highscore.setup("HIGH SCORES", name: "highscores", x: Game.GetX(0.5), y: Game.GetY(0.78), size: 150, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Center, zPos: 1);
        
        highscore_one.setup("1. " + String(Game.highscore[0]), name: "h1", x: Game.GetX(0.5), y: Game.GetY(0.55), size: 100, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Center, zPos: 1);
        highscore_two.setup("2. " + String(Game.highscore[1]), name: "h2", x: Game.GetX(0.5), y: Game.GetY(0.4), size: 100, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Center, zPos: 1);
        highscore_three.setup("3. " + String(Game.highscore[2]), name: "h3", x: Game.GetX(0.5), y: Game.GetY(0.25), size: 100, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Center, zPos: 1);
        
        globalscore_btn.setup("GLOBAL SCORE", name: "GL", x: Game.GetX(0.96), y: Game.GetY(0.05), size: 60, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Right, zPos: 1);
        
        back_btn.setup("BACK", name: "back", x: Game.GetX(0.04), y: Game.GetY(0.05), size: 60, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Left, zPos: 1);
        
        addChild(highscore);
        
        addChild(highscore_one);
        addChild(highscore_two);
        addChild(highscore_three);

        addChild(globalscore_btn);
        addChild(back_btn);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view);
        
        highscore_one.text = "1. " + String(Game.highscore[0]);
        highscore_two.text = "2. " + String(Game.highscore[1]);
        highscore_three.text = "3. " + String(Game.highscore[2]);
    }
    
    override func updateBackgroundColour() {
        super.updateBackgroundColour();
        
        highscore.getColour();
        highscore_one.getColour();
        highscore_two.getColour();
        highscore_three.getColour();
        globalscore_btn.getColour();
        back_btn.getColour();
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var node:SKNode = SKNode();
        if let touch = touches.first {
            let location = touch.locationInNode(self);
            node = self.nodeAtPoint(location);
            touchStartLoc = location; //Variable we need for swipeable background
        }
        
        if(node.name == "back"){
            Game.soundManager.playSound("click");
            Game.skView.presentScene(Game.scenes_mainmenu!, transition: SKTransition.fadeWithColor(UIColor.blackColor(), duration: NSTimeInterval(Game.SceneFade)));
        }
        
        if(node.name == "GL"){
            EGC.showGameCenterLeaderboard(leaderboardIdentifier: "cherry.highscores");
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event);
    }
}