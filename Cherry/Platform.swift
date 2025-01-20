//
//  Platform.swift
//  Cherry
//
//  Created by Luke Farrell on 12/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class Platform : GameObject {
    
    var hasTouched : Bool = false; //Has ball landed on this platform already. This may be good info for some platform types
    var row:Int = 0;
    var scoreAdded:Bool = false;
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: self.size.height));
        self.physicsBody?.isDynamic = false;
        self.physicsBody?.categoryBitMask = PhysicsCategory.platform;
        self.physicsBody?.contactTestBitMask = PhysicsCategory.player;
        self.physicsBody?.restitution = 0;
        self.physicsBody?.friction = 0.0;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update() {
        super.update();
        
        if(self.frame.maxY > Game.player.position.y){
            if(!scoreAdded && row == Game.platform_spawner.currentPlatformRow && !Game.playerDead){
                Game.platform_spawner.currentPlatformRow += 1;
                Game.score += 1 * Game.score_multi;
                scoreAdded = false;
            }
            self.physicsBody?.categoryBitMask = PhysicsCategory.None;
            self.physicsBody?.collisionBitMask = PhysicsCategory.None;
            self.physicsBody?.contactTestBitMask = PhysicsCategory.None;
        }else{
            self.physicsBody?.categoryBitMask = PhysicsCategory.platform;
            self.physicsBody?.contactTestBitMask = PhysicsCategory.player;
            self.physicsBody?.collisionBitMask = PhysicsCategory.All;
        }
    }
    
    func Touched(){
        hasTouched = true;
        //Overide here? -- Triggers when ball has touched down on a platform
        
        if(row > Game.platform_spawner.currentPlatformRow){
            Game.platform_spawner.currentPlatformRow = row;
        }
    }
    
    func stop() {
        //Stop Platform actions, e.g. timers
    }
    func start(){
        //start platform actions, e.g. timers
    }
}
