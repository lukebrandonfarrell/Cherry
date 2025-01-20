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
        let path:CGMutablePath = CGMutablePath();
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: Game.sceneWidth, y: 0))
        
        let pattern: [CGFloat] = [10.0, 10.0]
        let dashedpath = path.copy(dashingWithPhase: 0,
                                  lengths: pattern)
        
        line.path = dashedpath
        line.lineWidth = 2;
        line.fillColor = SKColor.white;
        line.strokeColor = SKColor.white;
        
        addChild(line)
        
        linetext.setup(text: "0", name: "linetext", x: 0, y: Game.GetY(value: 0.01), size: 35, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.left, zPos: 1)
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
