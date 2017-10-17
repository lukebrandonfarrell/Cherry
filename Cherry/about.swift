//
//  about.swift
//  Cherry
//
//  Created by Luke Farrell on 12/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class about : cherrymenu {
    var developers_text : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    var _url : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    
    var back_btn : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    
    override init(size: CGSize) {
        super.init(size: size);
        loadBackground();
        loadHint(); //If scene uses hints, load this
        
        developers_text.setup("A GAME BY ANDRE & LUKE", name: "developer", x: Game.GetX(0.5), y: Game.GetY(0.54), size: 90, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Center, zPos: 1);
        _url.setup("cherrythegame.com", name: "names", x: Game.GetX(0.5), y: Game.GetY(0.42), size: 75, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Center, zPos: 1);
        
        back_btn.setup("BACK", name: "back", x: Game.GetX(0.04), y: Game.GetY(0.05), size: 60, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Left, zPos: 1);
        
        addChild(developers_text);
        addChild(_url);
        
        addChild(back_btn);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view);
    }
    
    override func updateBackgroundColour() {
        super.updateBackgroundColour();
        
        developers_text.getColour();
        _url.getColour();
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
            Game.skView.presentScene(Game.scenes_settings!, transition: SKTransition.fadeWithColor(UIColor.blackColor(), duration: NSTimeInterval(Game.SceneFade)));
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event);
    }
}