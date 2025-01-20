//
//  TextObject.swift
//  Hedgehog Dash
//
//  Created by Luke on 2/23/16.
//  Copyright © 2016 Puzzled. All rights reserved.
//

import Foundation
import SpriteKit

//This class is the root of all gameobjects

class TextObject : SKLabelNode {
    override init() {
        super.init()
    }
    
    override init(fontNamed fontName: String!) {
        super.init(fontNamed: fontName);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(text:String, name:String, x:CGFloat, y:CGFloat, size:CGFloat, color:SKColor, align:SKLabelHorizontalAlignmentMode, zPos:CGFloat){
        self.text = text;
        self.name = name;
        self.fontSize = size * Game.scale_value
        self.fontColor = color
        self.position = CGPoint(x: x, y: y)
        self.horizontalAlignmentMode = align
        self.zPosition = zPos;
        
        let HitBox:SKShapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: self.frame.width * 1.5, height: self.frame.height * 1.5));
        HitBox.position = CGPoint(x: -HitBox.frame.width/2, y: -HitBox.frame.height/4);
        HitBox.fillColor = SKColor.black;
        HitBox.lineWidth = 0.0;
        HitBox.zPosition = zPos;
        HitBox.name = name;
        HitBox.alpha = 0;
        self.addChild(HitBox);
    }
    
    func getColour(){
        self.fontColor = Game.MenuInvertedColour ? SKColor.black : SKColor.white;
    }
}
