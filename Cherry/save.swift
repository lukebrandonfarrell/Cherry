//
//  save.swift
//  Cherry
//
//  Created by Luke Farrell on 01/06/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class save {
    //Core
    let saved = UserDefaults.standard;
    
    //Save
        func saveObject<T>(data: T, key: String) {
            saved.set(data, forKey: key)
        }

        func saveBool(data:Bool, key:String){
            saved.set(data, forKey: key);
        }
    
        func saveInteger(data:Int, key:String){
            saved.set(data, forKey: key);
        }

        func saveFloat(data:CGFloat, key:String){
            saved.set(Float(data), forKey: key);
        }
    
    //load
        func loadObject(key:String) -> AnyObject? {
            return saved.object(forKey: key) as? AnyObject
        }

        func loadBool(key:String) -> Bool? {
            if saved.object(forKey: key) != nil {
                return saved.bool(forKey: key)
            }
            return nil
        }
    
        func loadArray(key: String) -> [Int]? {
            return saved.array(forKey: key) as? [Int]
        }

        func loadInteger(key:String) -> Int? {
            if saved.object(forKey: key) != nil {
                return saved.integer(forKey: key)
            }
            return nil
        }
    
        func loadFloat(key:String) -> CGFloat? {
            if saved.object(forKey: key) != nil {
                return CGFloat(saved.float(forKey: key))
            }
            return nil
        }


    //Keys
        //Settings
        let keyHighscore = "cherry-highscores"
        let keySoundFX = "cherry-soundfx"
        let keyMusic = "cherry-music"
        let keyAutoplay = "cherry-autoplay"
        let keyHanded = "cherry-handed"
        
        //BG Colour
        let keyBGColour = "cherry-bgcolour"
        let keyMaxLevel = "cherry-maxlevel";
        
        //Fruit
        let keyCherry = "cherry-fruit_cherry"
        let keyBanana = "cherry-fruit_banana"
        let keyPineapple = "cherry-fruit_pineapple"
        let keyGrape = "cherry-fruit_grape"
        
        //Abilities
        let keyPurchasedAbilities = "cherry-abilityarray"
    
        //Stats
        let keyNumOfDeaths = "cherry-numofdeaths";
        let keyTimePlayed = "cherry-timeplayed";
    
        //Controls
        let keyControls = "cherry-controls";
        let keyTiltMovement = "cherry-tilt";
    
        //Physics
            //Save Physics values
            let keyCurrentBallspeed = "cherry-physics_currentballspeed";
            let keyCurrentJump = "cherry-physics_currentjump";
            let keyCurrentGravity = "cherry-physics_currentgravity";
            let keyCurrentTilt = "cherry-physics_currenttilt";
        
            //Save Slider positions
            let keyBallspeed = "cherry-physics_ballspeed";
            let keyJump = "cherry-physics_jump";
            let keyGravity = "cherry-physics_gravity";
            let keyTilt = "cherry-physics_tilt";
            let keyWalls = "cherry-physics_walls";
    
    //Specific to game
        func getAllData(){
            if let highscore = saved.array(forKey: keyHighscore) as? [Int] {
                Game.highscore = highscore
            }
            
            if let purchaseabilities = saved.dictionary(forKey: keyPurchasedAbilities) as? [String: Int] {
                Game.avalible_ablities = purchaseabilities
            }
            
            var bgcolour:Int? = loadInteger(key: keyBGColour);
            let maxlevel:Int? = loadInteger(key: keyMaxLevel);
            
            let cherries:Int? = loadInteger(key: keyCherry);
            let bananas:Int? = loadInteger(key: keyBanana);
            let pineapples:Int? = loadInteger(key: keyPineapple);
            let grapes:Int? = loadInteger(key: keyGrape);

            let numofdeaths:Int? = loadInteger(key: keyNumOfDeaths);
            let timeplayed:Int? = loadInteger(key: keyTimePlayed);
            
            let controls:Int? = loadInteger(key: keyControls);
            let tiltmov:Int? = loadInteger(key: keyTiltMovement);
            
            //Load Physics values
            /*let physicsballspeedX:CGFloat? = loadFloat(keyBallspeed);
            let physicsjumpX:CGFloat? = loadFloat(keyJump);
            let physicsgravityX:CGFloat? = loadFloat(keyGravity);
            let physicstiltX:CGFloat? = loadFloat(keyTilt);*/
            
            if saved.object(forKey: keySoundFX) != nil {
                Game.soundFX = saved.bool(forKey: keySoundFX)
            }

            if saved.object(forKey: keyAutoplay) != nil {
                Game.autoplayON = saved.bool(forKey: keyAutoplay)
            }
            
            if saved.object(forKey: keyHanded) != nil {
                Game.ability_bar.orientation = saved.bool(forKey: keyHanded)
            }
            
            if(bgcolour != nil){
                if(bgcolour == 0){
                    bgcolour = 0xC91240;
                }
                Game.MenuBackgroundColor = bgcolour!;
            }
            
            if(maxlevel != nil){
                Game.levelmanager.MaxLevel = maxlevel!;
            }

            if(cherries != nil){
                Stats.cheriesCollected = cherries!;
            }
            if(bananas != nil){
                Stats.bananasCollected = bananas!;
            }
            if(pineapples != nil){
                Stats.pineapplesCollected = pineapples!;
            }
            if(grapes != nil){
                Stats.grapesCollected = grapes!;
            }
            
            if(numofdeaths != nil){
                Stats.numberOfDeaths = numofdeaths!;
            }
            if(timeplayed != nil){
                Stats.timePlayed = timeplayed!;
            }
            
            if(controls != nil){
                if(controls == 1){
                    Game.controlsOFF = true;
                }
            }
            
            if(tiltmov != nil){
                if(tiltmov == 0){
                    Game.tiltmovement = false;
                }else{
                    Game.tiltmovement = true;
                }
            }
            
            /*if(physicscurrentballspeed != nil){
                if(physicscurrentballspeed != 0){
                    Physics.ballspeed = physicscurrentballspeed!;
                }
            }
            if(physicscurrentjump != nil){
                if(physicscurrentjump != 0){
                    Physics.jump = physicscurrentjump!;
                }
            }
            if(physicscurrentgravity != nil){
                if(physicscurrentgravity != 0){
                    Physics.gravity = physicscurrentgravity!;
                }
            }
            if(physicscurrenttilt != nil){
                if(physicscurrenttilt != 0){
                    Physics.tilt = physicscurrenttilt!;
                }
            }
            
            if(physicsballspeedX != nil){
                Physics.ballspeedX = physicsballspeedX!;
            }
            if(physicsjumpX != nil){
                Physics.jumpX = physicsjumpX!;
            }
            if(physicsgravityX != nil){
                Physics.gravityX = physicsgravityX!;
            }
            if(physicstiltX != nil){
                Physics.tiltX = physicstiltX!;
            }
            if let physicswalls: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey(keyWalls){
                Physics.walls = physicswalls as! Bool;
            }*/
        }
    
    func saveMenuData() {
        saveInteger(data: (Game.tiltmovement ? 1 : 0), key: keyTiltMovement);
        saveBool(data: Game.musicON, key: keyMusic)
        saveBool(data: Game.soundFX, key: keySoundFX);
        saveBool(data: Game.autoplayON, key: keyAutoplay)
        saveBool(data: Game.ability_bar.orientation, key: keyHanded)
    }
    
    func saveEndGameData(){
        saveInteger(data: Game.MenuBackgroundColor, key: keyBGColour)
        saveObject(data: Game.highscore, key: keyHighscore);
        
        saveInteger(data: Stats.numberOfDeaths, key: keyNumOfDeaths);
        saveInteger(data: Stats.timePlayed, key: keyTimePlayed);
        
        saveFruit();
    }
    
    func saveFruit(){
        saveInteger(data: Stats.cheriesCollected, key: keyCherry);
        saveInteger(data: Stats.bananasCollected, key: keyBanana);
        saveInteger(data: Stats.pineapplesCollected, key: keyPineapple);
        saveInteger(data: Stats.grapesCollected, key: keyGrape);
    }
    
    func savePhysicsData(){
        saveFloat(data: Physics.ballspeed, key: keyCurrentBallspeed)
        saveFloat(data: Physics.jump, key: keyCurrentJump)
        saveFloat(data: Physics.gravity, key: keyCurrentGravity)
        saveFloat(data: Physics.tilt, key: keyCurrentTilt)
        
        saveBool(data: Physics.walls, key: keyWalls)
        
        saveFloat(data: Physics.ballspeedX, key: keyBallspeed);
        saveFloat(data: Physics.jumpX, key: keyJump);
        saveFloat(data: Physics.gravityX, key: keyGravity)
        saveFloat(data: Physics.tiltX, key: keyTilt)
    }
}
