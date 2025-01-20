//
//  cherryscene.swift
//  Cherry
//
//  Created by Luke Farrell on 03/06/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class cherryscene : SKScene {
    var hint : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    
    var fadeactions:[SKAction]!;
    var allactions:[SKAction]!;
    
    var closeactions:[SKAction]!;
    
    var hint_action:SKAction!;
    var close_action:SKAction!;
    
    override init(size: CGSize) {
        super.init(size: size);
        
        fadeactions = [SKAction.fadeIn(withDuration: 2.0), SKAction.fadeOut(withDuration: 2.0)];
        allactions = [SKAction.repeatForever(SKAction.sequence(fadeactions))];
        closeactions = [SKAction.wait(forDuration: 2.0), SKAction.run( { () -> Void in
            self.hint.text = "";
        })];
        
        hint_action = SKAction.sequence(allactions);
        close_action = SKAction.sequence(closeactions);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadHint(){
        hint.setup(text: "", name: "hint", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.05),
                   size: 50, color: SKColor.white,
                   align: SKLabelHorizontalAlignmentMode.center, zPos: 6.5);
        addChild(hint);
    }
    
    func addHint(text:String, flash:Bool = true){
        hint.text = text;
        hint.removeAllActions()
        
        if(flash){
            if(hint_action != nil){ hint.run(hint_action); };
        }else{
            if(close_action != nil){ hint.run(close_action); };
        }
    }
    
    func removeHint(){
        hint.removeAllActions()
        hint.text = "";
    }
}
