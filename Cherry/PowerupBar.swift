//
//  Powerup.swift
//  Cherry
//
//  Created by Luke Farrell on 16/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class PowerupBar : GameObject {
    var cherry_powerup:GameObject = GameObject(texture: Game.textures.cherry());
    var banana_powerup:GameObject = GameObject(texture: Game.textures.banana());
    var grapes_powerup:GameObject = GameObject(texture: Game.textures.grapes());
    var pinapple_powerup:GameObject = GameObject(texture: Game.textures.pineapple());
    
    var activePowerups:[String : Array<AnyObject>]!;
    var powerPositions:[CGFloat] = [];
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size);
        
        cherry_powerup.setup(0, y: 0, size: 1.0, zPos: 1); addChild(cherry_powerup); cherry_powerup.alpha = 0;
        banana_powerup.setup(0, y: 0, size: 1.0, zPos: 1); addChild(banana_powerup); banana_powerup.alpha = 0;
        grapes_powerup.setup(0, y: 0, size: 1.0, zPos: 1); addChild(grapes_powerup); grapes_powerup.alpha = 0;
        pinapple_powerup.setup(0, y: 0, size: 1.0, zPos: 1); addChild(pinapple_powerup); pinapple_powerup.alpha = 0;
        
        activePowerups = ["cherry" : [0.0, cherry_powerup], "banana": [0.0, banana_powerup], "grapes" : [0.0, grapes_powerup], "pineapple" : [0.0, pinapple_powerup]];
        powerPositions = [];
        
        for(var p=0; p<4; p += 1){
            powerPositions.append((cherry_powerup.size.width + (cherry_powerup.size.width/2)) * CGFloat(p));
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func inView() {
        deactivatePowerup("cherry", obj: cherry_powerup);
        deactivatePowerup("banana", obj: banana_powerup);
        deactivatePowerup("grapes", obj: grapes_powerup);
        deactivatePowerup("pineapple", obj: pinapple_powerup);
    }
    
    override func update() {
        for(name, object) in activePowerups {
            var time:CGFloat = object[0] as! CGFloat;
            let obj:GameObject = object[1] as! GameObject;
            
            if(time > 0){
                if(activePowerups[name] != nil){
                    activePowerups[name]![0] = (activePowerups[name]![0] as! CGFloat) - 0.25;
                    time -= 0.2;
                }
                
                if(time < 35){
                    if(!obj.isBlinking){
                        blink(obj);
                        obj.isBlinking = true;
                    }
                }
                
                if(time <= 1){
                    time = 0;
                    deactivatePowerup(name, obj: obj);
                }
            }
        }
    }
    
    func loadPowerup(){
        var avaliblePositions:[CGFloat] = powerPositions;
        
        for(_, object) in activePowerups {
            let time:CGFloat = object[0] as! CGFloat;
            let obj:GameObject = object[1] as! GameObject;
            
            if(time == 100 || time == 200){
                obj.alpha = 1.0;
            }
            
            if(time > 0){
                obj.position.x = avaliblePositions[0];
                avaliblePositions.removeFirst();
            }
        }
    }
    
    func activatePowerup(powerup:String){
        if(activePowerups[powerup] != nil){
            let time : CGFloat = Game.fruitadox_active ? 200 : 100; //Fruitadox Ability
            if(Game.fruitadox_active){ Game.ability_bar.deactivateAbility("fruitadox"); } //Deactivate ability
            
            activePowerups[powerup]![0] = (activePowerups[powerup]![0] as! CGFloat) + time;
            
            //Remove blinking if powerup is already active and running out, now its not :)
            let object:GameObject = activePowerups[powerup]![1] as! GameObject;
            object.removeAllActions();
            object.isBlinking = false;
            object.alpha = 1.0;
        }
        
        loadPowerup();
    }
    
    func deactivatePowerup(powerup:String, obj:GameObject){
        activePowerups[powerup]![0] = 0;
        obj.removeAllActions();
        obj.isBlinking = false;
        
        if(powerup == "cherry"){
            Game.score_multi = 1;
            cherry_powerup.alpha = 0.0;
            Game.cherry_stackSweetFruit = false;
        }else if(powerup == "banana"){
            Game.player.multipleJump = 0;
            banana_powerup.alpha = 0.0;
            Game.cherry_stackSweetFruit = false;
        }else if(powerup == "grapes"){
            Game.gamescene_speed = 1.0;
            if(!Game.gamepaused){Game.scenes_gamescene?.physicsWorld.speed = 1.0;}
            grapes_powerup.alpha = 0.0;
            Game.grape_stackSweetFruit = false;
        }else if(powerup == "pineapple"){
            Game.player.xScale = 1;
            Game.player.yScale = 1;
            Game.player.calculateMovementSpeeds(1.0);
            
            pinapple_powerup.alpha = 0.0;
            Game.pineapple_stackSweetFruit = false;
        }
        
        loadPowerup();
    }
    
    /*Blink*/
    func blink(obj:GameObject) {
        
        let fade: SKAction = SKAction.runBlock { () -> Void in obj.alpha = 0.2; Game.soundManager.playSound("flash");
}
        let nofade: SKAction = SKAction.runBlock { () -> Void in obj.alpha = 1.0; }
        let wait: SKAction = SKAction.waitForDuration(0.2)
        
        let flash_sequence: SKAction = SKAction.sequence([
            fade,
            wait,
            nofade,
            wait
        ]);
        
        obj.runAction(SKAction.repeatActionForever(flash_sequence));
    }
    
    /*Invert Colours*/
    func getColour(){
        cherry_powerup.texture = Game.GameInvertedColour ? Game.textures.cherry_Invert() : Game.textures.cherry();
        banana_powerup.texture = Game.GameInvertedColour ? Game.textures.banana_Invert() : Game.textures.banana();
        grapes_powerup.texture = Game.GameInvertedColour ? Game.textures.grapes_Invert() : Game.textures.grapes();
        pinapple_powerup.texture = Game.GameInvertedColour ? Game.textures.pineapple_Invert() : Game.textures.pineapple();
    }
}