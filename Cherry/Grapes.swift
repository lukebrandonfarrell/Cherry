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
    override func pickup(){
        var slowmo : CGFloat = 0.75;
        if(Game.sweetfruit_active){ Game.grape_stackSweetFruit = true; }
        slowmo = Game.sweetfruit_active ? 0.5 : 0.75;
        if(Game.grape_stackSweetFruit){
            slowmo = 0.5;
        }
        
        Game.gamescene_speed = slowmo;
        Game.scenes_gamescene?.physicsWorld.speed = slowmo;
        Game.powerup_bar.activatePowerup("grapes");
        Stats.grapesCollected += 1;
        
        Game.soundManager.playSound("grape");
        
        super.pickup();
    }
}