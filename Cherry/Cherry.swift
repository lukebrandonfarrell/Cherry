//
//  Cherry.swift
//  Cherry
//
//  Created by Luke Farrell on 13/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class Cherry : Pickup {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.name = "cherry"
    }
    
    @MainActor required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func pickup(){
        var multiplier : Int = 2;
        if(Game.sweetfruit_active){ Game.cherry_stackSweetFruit = true; }
        multiplier = Game.sweetfruit_active ? 3 : 2;
        if(Game.cherry_stackSweetFruit){
            multiplier = 3;
        }

        Game.score_multi = multiplier;
        Game.powerup_bar.activatePowerup(powerup: "cherry");
        Stats.cheriesCollected += 1;
        
        Game.soundManager.playSound(str: "cherry");
        
        super.pickup();
    }
}
