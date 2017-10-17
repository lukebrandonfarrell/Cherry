//
//  submenu.swift
//  Cherry
//
//  Created by Luke Farrell on 22/05/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class submenu : cherrymenu {
    
    var startgame_btn : TextObject = TextObject(fontNamed: "AvenirNext-Heavy");
    var physicsroom_btn : TextObject = TextObject(fontNamed: "AvenirNext-Heavy");
    var shop_btn : TextObject = TextObject(fontNamed: "AvenirNext-Heavy");
    
    /*var skull_stat:GameObject = GameObject(texture: Game.textures.skull());
    var hourglass_stat:GameObject = GameObject(texture: Game.textures.hourglass());
    
    var skull_text : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    var hourglass_text : TextObject = TextObject(fontNamed: "AvenirNext-Bold");*/
    
    var back_btn : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    
    override init(size: CGSize) {
        super.init(size: size);
        loadBackground();
        loadHint(); //If scene uses hints, load this
        
        startgame_btn.setup("START GAME", name: "startgame",
                            x: Game.GetX(0.5), y: Game.GetY(0.64),
                            size: 130, color: SKColor.whiteColor(),
                            align: SKLabelHorizontalAlignmentMode.Center, zPos: 1);
        
        physicsroom_btn.setup("PHYSICS ROOM", name: "physicsroom",
                              x: Game.GetX(0.5), y: Game.GetY(0.45),
                              size: 130, color: SKColor.whiteColor(),
                              align: SKLabelHorizontalAlignmentMode.Center, zPos: 1);
        
        shop_btn.setup("SHOP", name: "shop",
                       x: Game.GetX(0.5), y: Game.GetY(0.26),
                       size: 130, color: SKColor.whiteColor(),
                       align: SKLabelHorizontalAlignmentMode.Center, zPos: 1);
        
        let botY:CGFloat = Game.GetY(0.07);
        
        back_btn.setup("BACK", name: "back",
                       x: Game.GetX(0.04), y: Game.GetY(0.05),
                       size: 60, color: SKColor.whiteColor(),
                       align: SKLabelHorizontalAlignmentMode.Left, zPos: 1);
        
        addChild(startgame_btn);
        addChild(physicsroom_btn);
        addChild(shop_btn);
        
        addChild(back_btn);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view);
        
        //Configure Stats
     
    }
    
    override func updateBackgroundColour() {
        super.updateBackgroundColour();
        
                
        startgame_btn.getColour();
        physicsroom_btn.getColour();
        shop_btn.getColour();
        back_btn.getColour();
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var node:SKNode = SKNode();
        if let touch = touches.first {
            let location = touch.locationInNode(self);
            node = self.nodeAtPoint(location);
            touchStartLoc = location; //Variable we need for swipeable background
        }
        
        if(node.name == "startgame"){
            
            Game.skView.presentScene(Game.scenes_gamescene!,
                                     transition: SKTransition.fadeWithColor(UIColor.blackColor(),
                                        duration: NSTimeInterval(Game.SceneFade)));
            
        }else if(node.name == "physicsroom"){
            
            Game.skView.presentScene(Game.scenes_physicsroom!,
                                     transition: SKTransition.fadeWithColor(UIColor.blackColor(),
                                        duration: NSTimeInterval(Game.SceneFade)));
            
        }else if(node.name == "shop"){
            
            Game.skView.presentScene(Game.scenes_shop!,
                                     transition: SKTransition.fadeWithColor(UIColor.blackColor(),
                                        duration: NSTimeInterval(Game.SceneFade)));
        }else if(node.name == "back"){
            Game.skView.presentScene(Game.scenes_mainmenu!,
                                     transition: SKTransition.fadeWithColor(UIColor.blackColor(),
                                        duration: NSTimeInterval(Game.SceneFade)));
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event);
    }
}