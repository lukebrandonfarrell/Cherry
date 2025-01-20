//
//  essentials.swift
//  Cherry
//
//  Created by Luke Farrell on 12/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

struct Game {
    static var skView:SKView!;
    static let soundManager:SoundManager = SoundManager();
    static let saveGame:save = save();
    
    static let textures:texture = texture();
    
    static var scenes_mainmenu:SKScene? = nil;
    static var scenes_controls:SKScene? = nil;
        static var scenes_highscores:SKScene? = nil;
        static var scenes_themes:SKScene? = nil;
        static var scenes_settings:SKScene? = nil;
        static var scenes_about:SKScene? = nil;
    
    static var scenes_submenu:SKScene? = nil;
        static var scenes_physicsroom:SKScene? = nil;
        static var scenes_shop:SKScene? = nil;
    
        static var scenes_gamescene:SKScene? = nil;
        static var scenes_gameover:SKScene? = nil;
    
    static var SceneFade:CGFloat = 0.6;
    
    static var scale_value:CGFloat = 1.0
    
    static var sceneWidth:CGFloat = 0
    static var sceneHeight:CGFloat = 0
    
    static var XAlign_center:CGFloat = 0;
    static var YAlign_center:CGFloat = 0;
    
    static func setSceneValues(size:CGSize){
        Game.scale_value = (size.height/1000);

        sceneWidth = size.width;
        sceneHeight = size.height;
    
        Game.XAlign_center = size.width / 2;
        Game.YAlign_center = size.height / 2;
    }
    
    static func GetX(value:CGFloat) -> CGFloat {
        var value = value;
        value = Game.correctValue(v: value);
        return sceneWidth * value;
    }

    static func GetY(value:CGFloat) -> CGFloat {
        var value = value;
        value = Game.correctValue(v: value);
        return sceneHeight * value;
    }

    static func correctValue(v:CGFloat) -> CGFloat {
        var v = v;
        if(v < 0){v = 0;}else if(v > 1){v = 1;}
        return v;
    }
    
    static var hasRotated:Bool = true; //Has screen be rotated
    
    /* Game Changing Values */
    static var player:Player!;
    static var powerup_bar:PowerupBar = PowerupBar();
    static var ability_bar:AbilityBar = AbilityBar();
    static var fruit_bar:FruitBar = FruitBar();
    static var platform_spawner:PlatformSpawner = PlatformSpawner();
    static var levelmanager:LevelManager = LevelManager()
    static var currentPopup:GameObject?;
    
    static let modelName = UIDevice.current.modelName
    
    static var gamescene_speed:CGFloat = 1.0;

    //COLOURS
    //Invertation - what we mean by this is that the colour background no longer works well with white elements, lets use dark ones instead (e.g white background)
        static var MenuInvertedColour:Bool = false; //Has menu colour been inverted
        static var GameInvertedColour:Bool = false; //Has game colour been inverted
    
        static var MenuBackgroundColor:Int = 0xC91240; //What colour is the menu?
        static var GameColour:Int = 0xC91240; //What colour is the menu?
        static var GameOverBackgroundColor:Int = 0xC91240; //Game over menu colour, so we can display it when the user dies to show progress :)
        static var bgColours:[Int] = [0xC91240,0xB63A9B,0x4347ad,0x03A7FF,0x38C4C5,0xDDC246,0xDF560B,0x000000,0xFFFFFF]; //All our possible colours
    
    //SCORE
        static var score:Int = 0; //Current score
        static var highscore:[Int] = [0,0,0]; //Array which keeps the users high score
        static var score_multi:Int = 1; //What should the score go up by? If you pickup a cherry then it should go up by 2 etc.
    
    static var gamepaused:Bool = false;
    static var autopause:Int = 0;
    
    static var musicON:Bool = true;
    static var soundFX:Bool = true;
    
    static var autoplayON:Bool = false;
    
    static var tutorialON:Bool = true;
    static var controlsOFF:Bool = false;
    
    static var tiltmovement:Bool = false;
    
    //has player died?
    static var playerDead: Bool = false;
    
    //Abilities
        //Top screen barrier
        static var top : GameObject!;
    
        static var avalible_ablities:[String : Int] = ["topfruit" : 0,
                                                   "fruitadox" : 0,
                                                   "sweetfruit" : 0,
                                                   "fruitbowl" : 0,
                                                   "teleport" : 0,
                                                   "theripening" : 0];
    
        static var ability_cost:[String : [Int]] = ["topfruit" : [3, 0, 0, 0],
                                                    "fruitadox" : [3, 1, 0, 0],
                                                    "sweetfruit" : [3, 3, 0, 0],
                                                    "fruitbowl" : [5, 3, 0, 0],
                                                    "teleport" : [3, 2, 1, 0],
                                                    "theripening" : [3, 3, 2, 1]];
    
        static var topfruit_active:Bool = false;
        static var fruitadox_active:Bool = false;
        static var sweetfruit_active:Bool = false;
        static var fruitbowl_active:Bool = false;
        static var teleport_active:Bool = false;
        static var theripening_active:Bool = false;
    
    
        //Auto activate
        static var topfruit_auto_active:Int = 0;
        static var fruitadox_auto_active:Int = 0;
        static var sweetfruit_auto_active:Int = 0;
        static var fruitbowl_auto_active:Int = 0;
        static var teleport_auto_active:Int = 0;
        static var theripening_auto_active:Int = 0;
    
        //Specific to ability variables
    
        //These are used to keep track of sweetfruit reseting
        static var cherry_stackSweetFruit:Bool = false;
        static var banana_stackSweetFruit:Bool = false;
        static var pineapple_stackSweetFruit:Bool = false;
        static var grape_stackSweetFruit:Bool = false;
}

struct Stats {
    static var numberOfDeaths:Int = 0;
    static var timePlayed:Int = 0;
    
    static var cheriesCollected:Int = 0;
    static var bananasCollected:Int = 0;
    static var grapesCollected:Int = 0;
    static var pineapplesCollected:Int = 0;
    
    static var accumulatedScore:Int = 0;
}

struct Physics {
    //Current Preset
    static var ballspeed:CGFloat = 140.0;
    static var jump:CGFloat = 13.0;
    static var gravity:CGFloat = -14.0;
    static var tilt:CGFloat = 14.0;
    static var walls:Bool = false;
    
    //Default Preset
    static var default_ballspeed:CGFloat = 140.0; //44.0
    static var default_jump:CGFloat = 13.0; //3.6
    static var default_gravity:CGFloat = -14.0; //-12.0
    static var default_tilt:CGFloat = 14.0;
    
    //Slider
    static var ballspeedX:CGFloat = 0;
    static var jumpX:CGFloat = 0;
    static var gravityX:CGFloat = 0;
    static var tiltX:CGFloat = 0;
}

struct Calc {
    //Formatting numbers and formating time
    static func formatNumber(number:NSNumber) -> NSString{
        var num:Double = number.doubleValue;
        let sign = ((num < 0) ? "-" : "" );
        
        num = fabs(num);
        
        if (num < 1000.0){
            return "\(sign)\(Int(num))" as NSString;
        }
        
        let exp:Int = Int(log10(num) / 3.0 ); //log10(1000));
        
        let units:[String] = ["k","m","g","t","p","e"];
        
        let roundedNum:Double = round(10 * num / pow(1000.0,Double(exp))) / 10;
        
        return "\(sign)\(roundedNum)\(units[exp-1])" as NSString;
    }
    
    static func formatTime(number:Int) -> String{
        let seconds: Int = number
        let minutes: Int = (number / 60) % 60
        let hours: Int = number / 3600
        let days: Int = number / 86400
        
        if(seconds == 0){
            return "0";
        }
        
        if(seconds < 60){
            return "\(seconds)s";
        }
        
        if(minutes > 0 && hours == 0){
            return "\(minutes)m";
        }
        
        if(hours > 0 && days == 0){
            return "\(hours)h";
        }
        
        if(days > 0){
            return "\(days)d";
        }
        
        return "0";
    }
    
    //Random
    static func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}
