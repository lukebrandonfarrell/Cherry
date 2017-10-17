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
        let saved = NSUserDefaults.standardUserDefaults();
    
    //Save
        func saveObject(data:AnyObject, key:String){
            saved.setObject(data, forKey: key);
        }

        func saveBool(data:Bool, key:String){
            saved.setBool(data, forKey: key);
        }
    
        func saveInteger(data:Int, key:String){
            saved.setInteger(data, forKey: key);
        }

        func saveFloat(data:CGFloat, key:String){
            saved.setFloat(Float(data), forKey: key);
        }
    
    //load
        func loadObject(key:String) -> AnyObject? {
            if let data:AnyObject = saved.objectForKey(key) {
                return data;
            }else{
                return nil;
            }
        }

        func loadBool(key:String) -> AnyObject? {
            if let data:Bool = saved.boolForKey(key) {
                return data;
            }else{
                return nil;
            }
        }
    
        func loadArray(key:String) -> Array<AnyObject>? {
            if let data:Array<AnyObject> = saved.arrayForKey(key) {
                return data;
            }else{
                return nil;
            }
        }

        func loadInteger(key:String) -> Int? {
            if let data:Int = saved.integerForKey(key) {
                return data;
            }else{
                return nil;
            }
        }
    
        func loadFloat(key:String) -> CGFloat? {
            if let data:CGFloat = CGFloat(saved.floatForKey(key)) {
                return data;
            }else{
                return nil;
            }
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
            let highscore:AnyObject? = loadArray(keyHighscore);
            let purchaseabilities:AnyObject? = loadObject(keyPurchasedAbilities);
            
            var bgcolour:Int? = loadInteger(keyBGColour);
            let maxlevel:Int? = loadInteger(keyMaxLevel);
            
            let cherries:Int? = loadInteger(keyCherry);
            let bananas:Int? = loadInteger(keyBanana);
            let pineapples:Int? = loadInteger(keyPineapple);
            let grapes:Int? = loadInteger(keyGrape);

            let numofdeaths:Int? = loadInteger(keyNumOfDeaths);
            let timeplayed:Int? = loadInteger(keyTimePlayed);
            
            let controls:Int? = loadInteger(keyControls);
            let tiltmov:Int? = loadInteger(keyTiltMovement);
            
            //Load Physics values
            /*let physicsballspeedX:CGFloat? = loadFloat(keyBallspeed);
            let physicsjumpX:CGFloat? = loadFloat(keyJump);
            let physicsgravityX:CGFloat? = loadFloat(keyGravity);
            let physicstiltX:CGFloat? = loadFloat(keyTilt);
            
            //Load Slider positions
            let physicscurrentballspeed:CGFloat? = loadFloat(keyCurrentBallspeed);
            let physicscurrentjump:CGFloat? = loadFloat(keyCurrentJump);
            let physicscurrentgravity:CGFloat? = loadFloat(keyCurrentGravity);
            let physicscurrenttilt:CGFloat? = loadFloat(keyCurrentTilt);*/
            
            if(highscore != nil){
                Game.highscore = highscore! as! [Int];
            }
            
            if(purchaseabilities != nil){
                Game.avalible_ablities = purchaseabilities! as! [String : Int];
            }

            if let soundfx: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey(keySoundFX) {
                Game.soundFX = soundfx as! Bool;
            }

            if let autoplay: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey(keyAutoplay){
                Game.autoplayON = autoplay as! Bool;
            }
            
            if let handed: AnyObject = NSUserDefaults.standardUserDefaults().objectForKey(keyHanded){
                Game.ability_bar.orientation = handed as! Bool;
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
        saveInteger((Game.tiltmovement ? 1 : 0), key: keyTiltMovement);
        saveBool(Game.musicON, key: keyMusic)
        saveBool(Game.soundFX, key: keySoundFX);
        saveBool(Game.autoplayON, key: keyAutoplay)
        saveBool(Game.ability_bar.orientation, key: keyHanded)
    }
    
    func saveEndGameData(){
        saveInteger(Game.MenuBackgroundColor, key: keyBGColour)
        saveObject(Game.highscore, key: keyHighscore);
        
        saveInteger(Stats.numberOfDeaths, key: keyNumOfDeaths);
        saveInteger(Stats.timePlayed, key: keyTimePlayed);
        
        saveFruit();
    }
    
    func saveFruit(){
        saveInteger(Stats.cheriesCollected, key: keyCherry);
        saveInteger(Stats.bananasCollected, key: keyBanana);
        saveInteger(Stats.pineapplesCollected, key: keyPineapple);
        saveInteger(Stats.grapesCollected, key: keyGrape);
    }
    
    func savePhysicsData(){
        saveFloat(Physics.ballspeed, key: keyCurrentBallspeed)
        saveFloat(Physics.jump, key: keyCurrentJump)
        saveFloat(Physics.gravity, key: keyCurrentGravity)
        saveFloat(Physics.tilt, key: keyCurrentTilt)
        
        saveBool(Physics.walls, key: keyWalls)
        
        saveFloat(Physics.ballspeedX, key: keyBallspeed);
        saveFloat(Physics.jumpX, key: keyJump);
        saveFloat(Physics.gravityX, key: keyGravity)
        saveFloat(Physics.tiltX, key: keyTilt)
    }
}