//
//  TiltTutorial.swift
//  Cherry
//
//  Created by Luke Farrell on 14/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class TiltTutorial: PopUp {
    var tilt_text : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    var start_text : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size);
        
        let backgroundfaded : ShapeObject = ShapeObject(rect: CGRect(x: 0, y: 0, width: Game.sceneWidth, height: Game.sceneHeight));
        backgroundfaded.fillColor = SKColor.black;
        backgroundfaded.alpha = 0.4;
        backgroundfaded.lineWidth = 0.0;
        backgroundfaded.name = "resume";
        addChild(backgroundfaded);
        
        tilt_text.setup(text: "tilt to move + tap to jump", name: "tilt", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.75), size: 45, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 4);
        
        addChild(tilt_text);
        
        
        start_text.setup(text: "tap to start", name: "start", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.1), size: 45, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 4);
        
        addChild(start_text);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
