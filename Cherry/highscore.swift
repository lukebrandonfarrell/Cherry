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
        
        highscore.setup(text: "HIGH SCORES", name: "highscores", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.78), size: 150, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        
        highscore_one.setup(text: "1. " + String(Game.highscore[0]), name: "h1", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.55), size: 100, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        highscore_two.setup(text: "2. " + String(Game.highscore[1]), name: "h2", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.4), size: 100, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        highscore_three.setup(text: "3. " + String(Game.highscore[2]), name: "h3", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.25), size: 100, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        
        globalscore_btn.setup(text: "GLOBAL SCORE", name: "GL", x: Game.GetX(value: 0.96), y: Game.GetY(value: 0.05), size: 60, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.right, zPos: 1);
        
        back_btn.setup(text: "BACK", name: "back", x: Game.GetX(value: 0.04), y: Game.GetY(value: 0.05), size: 60, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.left, zPos: 1);
        
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
    
    override func didMove(to view: SKView) {
        super.didMove(to: view);
        
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var node:SKNode = SKNode();
        if let touch = touches.first {
            let location = touch.location(in: self);
            node = self.atPoint(location);
            touchStartLoc = location; //Variable we need for swipeable background
        }
        
        if(node.name == "back"){
            Game.soundManager.playSound(str: "click");
            Game.skView.presentScene(Game.scenes_mainmenu!, transition: SKTransition.fade(with: UIColor.black, duration: TimeInterval(Game.SceneFade)));
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event);
    }
}
