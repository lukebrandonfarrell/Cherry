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
        
        developers_text.setup(text: "A GAME BY ANDRE & LUKE", name: "developer", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.54), size: 90, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        _url.setup(text: "cherrythegame.com", name: "names", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.42), size: 75, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        
        back_btn.setup(text: "BACK", name: "back", x: Game.GetX(value: 0.04), y: Game.GetY(value: 0.05), size: 60, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.left, zPos: 1);
        
        addChild(developers_text);
        addChild(_url);
        
        addChild(back_btn);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view);
    }
    
    override func updateBackgroundColour() {
        super.updateBackgroundColour();
        
        developers_text.getColour();
        _url.getColour();
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
            Game.skView.presentScene(Game.scenes_settings!, transition: SKTransition.fade(with: UIColor.black, duration: TimeInterval(Game.SceneFade)));
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event);
    }
}
