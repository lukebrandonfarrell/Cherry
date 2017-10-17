//
//  Banana.swift
//  Cherry
//
//  Created by Luke Farrell on 15/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class Banana : Pickup {
    override func pickup(){
        var jumps : Int = 2;
        if(Game.sweetfruit_active){ Game.banana_stackSweetFruit = true; }
        jumps = Game.sweetfruit_active ? 3 : 2;
        if(Game.banana_stackSweetFruit){
            jumps = 3;
        }
        
        Game.player.multipleJump = jumps;
        Game.powerup_bar.activatePowerup("banana");
        Stats.bananasCollected += 1;
        
        Game.soundManager.playSound("banana");
        
        super.pickup();
    }
}