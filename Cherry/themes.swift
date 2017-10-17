//
//  themes.swift
//  Cherry
//
//  Created by Luke Farrell on 12/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class themes : cherryscene {
    var themestitle : TextObject = TextObject(fontNamed: "AvenirNext-Heavy");
    var default_theme : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    var comingsoon : GameObject = GameObject(imageNamed: "coming_soon");
    var comingsoon_two : GameObject = GameObject(imageNamed: "coming_soon");
    
    var back_btn : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    
    override init(size: CGSize) {
        super.init(size: size);
        loadHint(); //If scene uses hints, load this
        
        backgroundColor = UIColor(netHex: 0xC91240);
        
        themestitle.setup("THEMES", name: "themes", x: Game.GetX(0.5), y: Game.GetY(0.78), size: 150, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Center, zPos: 1);
        default_theme.setup("DEFAULT", name: "default", x: Game.GetX(0.5), y: Game.GetY(0.5), size: 100, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Center, zPos: 1);
        comingsoon.setup(Game.GetX(0.5), y: Game.GetY(0.4), size: Game.GetX(0.00042), zPos: 1);
        comingsoon_two.setup(Game.GetX(0.5), y: Game.GetY(0.275), size: Game.GetX(0.00042), zPos: 1);
        
        back_btn.setup("BACK", name: "back", x: Game.GetX(0.04), y: Game.GetY(0.05), size: 60, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Left, zPos: 1);
        
        addChild(themestitle);
        addChild(default_theme);
        addChild(comingsoon);
        addChild(comingsoon_two);
        
        addChild(back_btn);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var node:SKNode = SKNode();
        if let touch = touches.first {
            let location = touch.locationInNode(self);
            node = self.nodeAtPoint(location);
        }
        
        if(node.name == "back"){
            Game.soundManager.playSound("click");
            Game.skView.presentScene(Game.scenes_mainmenu!, transition: SKTransition.fadeWithColor(UIColor.blackColor(), duration: NSTimeInterval(Game.SceneFade)));
        }
    }

}