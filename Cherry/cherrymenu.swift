//
//  cherrymenu.swift
//  Cherry
//
//  Created by Luke Farrell on 02/06/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class cherrymenu : cherryscene {
    var touchStartLoc:CGPoint!;
    var touchEndLoc:CGPoint!;
    
    var BGselection:Int = 0;
    var BGPrevColour:ShapeObject!;
    
    var slide:SKAction!;
    var change:SKAction!;
    var sequence_array:[SKAction]!;
    
    override init(size: CGSize) {
        super.init(size: size);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadBackground(){ //Loads the constants we need for changeable backgrounds
        BGPrevColour = ShapeObject(rect: CGRect(x: 0, y: 0, width: Game.sceneWidth, height: Game.sceneHeight));
        BGPrevColour.setup(-Game.sceneWidth, y: 0, size: 1.0, zPos: 1);
        BGPrevColour.lineWidth = 0.0;
        addChild(BGPrevColour);
        
        //Actions
        slide = SKAction.moveToX(0, duration: 0.2);
        
        change = SKAction.runBlock { () -> Void in
            Game.MenuBackgroundColor = Game.bgColours[self.BGselection];
            Game.saveGame.saveInteger(Game.MenuBackgroundColor, key: Game.saveGame.keyBGColour); //Save BG Colour
            self.backgroundColor = UIColor(netHex: Game.MenuBackgroundColor);
            self.updateBackgroundColour()
            self.BGPrevColour.alpha = 0.0;
        }
        
        sequence_array = [slide, change];
    }
    
    override func didMoveToView(view: SKView) {        
        backgroundColor = UIColor(netHex: Game.MenuBackgroundColor);
        
        for(var i=0; i<Game.bgColours.count; i += 1){
            if(Game.bgColours[i] == Game.MenuBackgroundColor){
                BGselection = i;
            }
        }
        Game.saveGame.saveInteger(Game.MenuBackgroundColor, key: Game.saveGame.keyBGColour) //Save current background colour
        
        updateBackgroundColour()
    }
    
    func updateBackgroundColour(){ //Because BG colour can be changed, we need to check it when its changed to update colour of other objects
        //Colour checking / changing code goes here
        if(Game.MenuBackgroundColor == 0xFFFFFF){Game.MenuInvertedColour = true;}else{Game.MenuInvertedColour = false;}
        hint.fontColor = Game.MenuInvertedColour ? SKColor.blackColor() : SKColor.whiteColor();
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self);
            touchEndLoc = location;
            
            let direction:CGFloat = touchStartLoc.x - touchEndLoc.x;
            BGPrevColour.removeAllActions();

            if(direction > 120)
            {
                if(BGselection < Game.levelmanager.MaxLevel){
                    BGPrevColour.alpha = 1.0;
                    BGPrevColour.position.x = Game.sceneWidth * 2;
                    BGselection += 1;
                    BGPrevColour.fillColor = UIColor(netHex: Game.bgColours[BGselection])
                    BGPrevColour.runAction(SKAction.sequence(sequence_array), withKey: "slide");
                }
            }
            else if(direction < -120)
            {
                if(BGselection > 0){
                    BGPrevColour.alpha = 1.0;
                    BGselection -= 1;
                    BGPrevColour.position.x = -Game.sceneWidth;
                    BGPrevColour.fillColor = UIColor(netHex: Game.bgColours[BGselection])
                    BGPrevColour.runAction(SKAction.sequence(sequence_array), withKey: "slide");
                }
                
            }
        }
    }
}