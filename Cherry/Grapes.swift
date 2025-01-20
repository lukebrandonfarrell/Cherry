//
//  Grapes.swift
//  Cherry
//
//  Created by Luke Farrell on 15/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class Grapes : Pickup {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.name = "grapes"
    }
    
    @MainActor required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func pickup(){
        var slowmo : CGFloat = 0.75;
        if(Game.sweetfruit_active){ Game.grape_stackSweetFruit = true; }
        slowmo = Game.sweetfruit_active ? 0.5 : 0.75;
        if(Game.grape_stackSweetFruit){
            slowmo = 0.5;
        }
        
        Game.gamescene_speed = slowmo;
        Game.scenes_gamescene?.physicsWorld.speed = slowmo;
        Game.powerup_bar.activatePowerup(powerup: "grapes");
        Stats.grapesCollected += 1;
        
        Game.soundManager.playSound(str: "grape");
        
        super.pickup();
    }
}
