//
//  Pickup.swift
//  Cherry
//
//  Created by Luke Farrell on 15/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class Pickup : GameObject {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        self.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.size.width, height: self.size.height));
        self.physicsBody?.dynamic = true;
        self.physicsBody?.affectedByGravity = false;
        self.physicsBody?.categoryBitMask = PhysicsCategory.pickup;
        self.physicsBody?.collisionBitMask = PhysicsCategory.None;
        self.physicsBody?.contactTestBitMask = PhysicsCategory.player;
        self.physicsBody?.restitution = 0;
        self.physicsBody?.fieldBitMask = PhysicsCategory.magnetic_player;
        self.physicsBody?.charge = 100;
        self.physicsBody?.mass = 0.1;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update() {
        super.update();
    }
    
    func pickup(){
        if(Game.sweetfruit_active){ Game.ability_bar.deactivateAbility("sweetfruit"); } //Deactivate ability
        self.removeFromParent();
    }
    
    
   func fruitbowl_Move(){  //Move all fruit to player
        if(Game.player != nil){
            let playerpos:CGPoint = Game.player.position;
            let animate = SKAction.moveTo(playerpos, duration: 0.1);
            self.runAction(animate);
        }
    }
}