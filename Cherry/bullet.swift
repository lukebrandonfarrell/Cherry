//
//  bullet.swift
//  Cherry
//
//  Created by Luke Farrell on 22/05/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class bullet : ShapeObject {
    override init() {
        super.init()
        
        self.strokeColor = Game.GameInvertedColour ? UIColor.black : UIColor(red: 234, green: 234, blue: 234);
        self.fillColor = Game.GameInvertedColour ? UIColor.black : UIColor(red: 234, green: 234, blue: 234);
        self.physicsBody = SKPhysicsBody(circleOfRadius: Game.GetX(value: 0.008));
        self.physicsBody?.categoryBitMask = PhysicsCategory.bullet;
        self.physicsBody?.contactTestBitMask = PhysicsCategory.None;
        self.physicsBody?.mass = 0.5;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
