//
//  PopUp.swift
//  Cherry
//
//  Created by Luke Farrell on 13/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class PopUp : GameObject {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size);
    }
    
    let backgroundshape : ShapeObject = ShapeObject();
    let backgroundfaded : ShapeObject = ShapeObject(rect: CGRect(x: 0, y: 0, width: Game.sceneWidth, height: Game.sceneHeight));
    
    func setupBG(){
        backgroundshape.path = UIBezierPath(roundedRect: CGRect(x: Game.GetX(value: 0.2), y: Game.GetY(value: 0.2), width: Game.GetX(value: 0.6), height: Game.GetY(value: 0.6)), cornerRadius: 25).cgPath;
        backgroundshape.fillColor = SKColor.black;
        backgroundshape.alpha = 0.4;
        addChild(backgroundshape);
        backgroundshape.lineWidth = 0.0;
        backgroundshape.zPosition = 3;
        
        backgroundfaded.fillColor = SKColor.black;
        backgroundfaded.alpha = 0.4;
        backgroundfaded.lineWidth = 0.0;
        addChild(backgroundfaded);
        backgroundfaded.zPosition = 2;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func close(){
        Game.gamepaused = false;
        Game.scenes_gamescene!.physicsWorld.speed = 1.0;
        self.removeFromParent();
    }
}
