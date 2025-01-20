//
//  Powerup.swift
//  Cherry
//
//  Created by Luke Farrell on 16/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

struct PowerupData {
    var time: CGFloat
    var object: GameObject
}

class PowerupBar : GameObject {
    var cherry_powerup:GameObject = GameObject(texture: Game.textures.cherry());
    var banana_powerup:GameObject = GameObject(texture: Game.textures.banana());
    var grapes_powerup:GameObject = GameObject(texture: Game.textures.grapes());
    var pinapple_powerup:GameObject = GameObject(texture: Game.textures.pineapple());
    
    var activePowerups: [String: PowerupData]!
    var powerPositions:[CGFloat] = [];
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size);
        
        print("PowerupBar initializing...")
        
        cherry_powerup.name = "cherry_powerup"
        banana_powerup.name = "banana_powerup"
        grapes_powerup.name = "grapes_powerup"
        pinapple_powerup.name = "pineapple_powerup"
        
        cherry_powerup.setup(x: 0, y: 0, size: 1.0, zPos: 1); addChild(cherry_powerup); cherry_powerup.alpha = 0;
        banana_powerup.setup(x: 0, y: 0, size: 1.0, zPos: 1); addChild(banana_powerup); banana_powerup.alpha = 0;
        grapes_powerup.setup(x: 0, y: 0, size: 1.0, zPos: 1); addChild(grapes_powerup); grapes_powerup.alpha = 0;
        pinapple_powerup.setup(x: 0, y: 0, size: 1.0, zPos: 1); addChild(pinapple_powerup); pinapple_powerup.alpha = 0;
        
        // Initialize with PowerupData structs
        activePowerups = [
            "cherry": PowerupData(time: 0, object: cherry_powerup),
            "banana": PowerupData(time: 0, object: banana_powerup),
            "grapes": PowerupData(time: 0, object: grapes_powerup),
            "pineapple": PowerupData(time: 0, object: pinapple_powerup)
        ]
        
        print("PowerupBar initialized with powerups and types:")
        for (name, powerupData) in activePowerups {
            print("\(name): time type = \(type(of: powerupData.time)), object type = \(type(of: powerupData.object))")
        }
        
        for p in 0..<4 {
            powerPositions.append((cherry_powerup.size.width + (cherry_powerup.size.width/2)) * CGFloat(p))
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func inView() {
        deactivatePowerup(powerup: "cherry", obj: cherry_powerup);
        deactivatePowerup(powerup: "banana", obj: banana_powerup);
        deactivatePowerup(powerup: "grapes", obj: grapes_powerup);
        deactivatePowerup(powerup: "pineapple", obj: pinapple_powerup);
    }
    
    override func update() {
        for (name, var powerupData) in activePowerups {
            if powerupData.time > 0 {
                powerupData.time -= 0.25
                activePowerups[name] = powerupData
                
                if powerupData.time < 35 {
                    if !powerupData.object.isBlinking {
                        blink(obj: powerupData.object)
                        powerupData.object.isBlinking = true
                    }
                }
                
                if powerupData.time <= 1 {
                    deactivatePowerup(powerup: name, obj: powerupData.object)
                }
            }
        }
    }
    
    func loadPowerup(){
        print("Loading powerup bar with active powerups:")
        var avaliblePositions:[CGFloat] = powerPositions;
        
        for (name, powerupData) in activePowerups {
            print("Powerup \(name): time = \(powerupData.time)")
        }
        
        for (name, powerupData) in activePowerups {
            if powerupData.time == 100 || powerupData.time == 200 {
                powerupData.object.alpha = 1.0;
                print("Setting powerup visible")
            }
            
            if(powerupData.time > 0){
                powerupData.object.position.x = avaliblePositions[0];
                avaliblePositions.removeFirst();
            }
        }
    }
    
    func activatePowerup(powerup: String) {
        print("Attempting to activate powerup: \(powerup)")
        
        guard var powerupData = activePowerups[powerup] else {
            print("No powerup found for: \(powerup)")
            return
        }
        
        let time: CGFloat = Game.fruitadox_active ? 200.0 : 100.0
        powerupData.time += time
        
        activePowerups[powerup] = powerupData
        powerupData.object.removeAllActions()
        powerupData.object.isBlinking = false
        powerupData.object.alpha = 1.0
        
        loadPowerup()
    }
    
    func deactivatePowerup(powerup: String, obj: GameObject) {
        if var powerupData = activePowerups[powerup] {
            powerupData.time = 0
            activePowerups[powerup] = powerupData
        }
        
        obj.removeAllActions()
        obj.isBlinking = false
        
        switch powerup {
        case "cherry":
            Game.score_multi = 1
            cherry_powerup.alpha = 0.0
            Game.cherry_stackSweetFruit = false
        case "banana":
            Game.player.multipleJump = 0
            banana_powerup.alpha = 0.0
            Game.cherry_stackSweetFruit = false
        case "grapes":
            Game.gamescene_speed = 1.0
            if !Game.gamepaused {
                Game.scenes_gamescene?.physicsWorld.speed = 1.0
            }
            grapes_powerup.alpha = 0.0
            Game.grape_stackSweetFruit = false
        case "pineapple":
            Game.player.xScale = 1
            Game.player.yScale = 1
            Game.player.calculateMovementSpeeds(newmass: 1.0)
            pinapple_powerup.alpha = 0.0
            Game.pineapple_stackSweetFruit = false
        default:
            break
        }
        
        loadPowerup()
    }
    
    /*Blink*/
    func blink(obj:GameObject) {
        
        let fade: SKAction = SKAction.run { () -> Void in obj.alpha = 0.2; Game.soundManager.playSound(str: "flash");
}
        let nofade: SKAction = SKAction.run { () -> Void in obj.alpha = 1.0; }
        let wait: SKAction = SKAction.wait(forDuration: 0.2)
        
        let flash_sequence: SKAction = SKAction.sequence([
            fade,
            wait,
            nofade,
            wait
        ]);
        
        obj.run(SKAction.repeatForever(flash_sequence));
    }
    
    /*Invert Colours*/
    func getColour(){
        cherry_powerup.texture = Game.GameInvertedColour ? Game.textures.cherry_Invert() : Game.textures.cherry();
        banana_powerup.texture = Game.GameInvertedColour ? Game.textures.banana_Invert() : Game.textures.banana();
        grapes_powerup.texture = Game.GameInvertedColour ? Game.textures.grapes_Invert() : Game.textures.grapes();
        pinapple_powerup.texture = Game.GameInvertedColour ? Game.textures.pineapple_Invert() : Game.textures.pineapple();
    }
}
