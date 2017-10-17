//
//  ScoreLine.swift
//  Cherry
//
//  Created by Luke Farrell on 06/06/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class ScoreLine : GameObject {
    var linetext:TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        let line:SKShapeNode = SKShapeNode()
        let path:CGMutablePathRef = CGPathCreateMutable();
        
        CGPathMoveToPoint(path, nil, 0, 0)
        CGPathAddLineToPoint(path, nil, Game.sceneWidth, 0)
        
        let pattern:[CGFloat] = [10.0, 10.0];
        let dashedpath = CGPathCreateCopyByDashingPath(path, nil, 0, pattern, 2);
        
        line.path = dashedpath
        line.lineWidth = 2;
        line.fillColor = SKColor.whiteColor();
        line.strokeColor = SKColor.whiteColor();
        
        addChild(line)
        
        linetext.setup("0", name: "linetext", x: 0, y: Game.GetY(0.01), size: 35, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Left, zPos: 1)
        addChild(linetext);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update() {
        super.update();
    }
    
    func addText(text:String){ //Add some text to our line
        linetext.text = text;
        
    }
}