//
//  Pineapple.swift
//  Cherry
//
//  Created by Luke Farrell on 15/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class Pineapple : Pickup {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.name = "pineapple"
    }
    
    @MainActor required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func pickup(){
        var scale : CGFloat = 1.5;
        var mass : CGFloat = 2.0;
        
        if(Game.sweetfruit_active){ Game.pineapple_stackSweetFruit = true; }
        scale = Game.sweetfruit_active ? 2.0 : 1.5;
        mass = Game.sweetfruit_active ? 3.0 : 2.0;
        
        if(Game.pineapple_stackSweetFruit){
            scale = 2.0;
            mass = 3.0;
        }
        
        Game.player.xScale = scale;
        Game.player.yScale = scale;
 
        Game.player.calculateMovementSpeeds(newmass: mass); //Increase players mass to increase resistance
        
        Game.powerup_bar.activatePowerup(powerup: "pineapple");
        Stats.pineapplesCollected += 1;
        
        Game.soundManager.playSound(str: "pineapple");
        
        super.pickup();
    }
}
