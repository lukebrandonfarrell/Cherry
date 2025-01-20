//
//  mainmenu.swift
//  Cherry
//
//  Created by Luke Farrell on 12/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class mainmenu : cherrymenu {
    
    var play_btn : TextObject = TextObject(fontNamed: "AvenirNext-Heavy");
    var highscore_btn : TextObject = TextObject(fontNamed: "AvenirNext-Heavy");
    var settings_btn : TextObject = TextObject(fontNamed: "AvenirNext-Heavy");
    var shop_btn : TextObject = TextObject(fontNamed: "AvenirNext-Heavy");
    
    var beforeLevel:Int = 0; //Level before playing
    var newcolour:Bool = false; //New colour avalible?
    
    override init(size: CGSize) {
        super.init(size: size);
        //IMPORTNAT STUFF -- We do this because MainMenu is the firsts scene and always will be when the game is newly loaded
        Game.setSceneValues(size: self.size); //Sets constants which we can use to determain screen sizes
            Game.soundManager.SetupSounds(); //Setup our sound objects
            
            //Get saves
            loadBackground(); //Loads custom backgrounds. This is a parent 'cherrymenu' function
            loadHint(); //If scene uses hints, load this
        
            beforeLevel = Game.levelmanager.MaxLevel; //So we can display a hint when user unlocks a new colour
        //IMPORTANT STUFF
        
        play_btn.setup(text: "PLAY", name: "play", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.68), size: 130, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        highscore_btn.setup(text: "HIGH SCORES", name: "scores", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.52), size: 130, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        settings_btn.setup(text: "SETTINGS", name: "settings", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.36), size: 130, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        shop_btn.setup(text: "SHOP", name: "shop", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.20), size: 130, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        
        addChild(play_btn);
        addChild(highscore_btn);
        addChild(settings_btn);
        addChild(shop_btn);
        
        //let pre = NSLocale.preferredLanguages()[0]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view);
        
        if(beforeLevel < Game.levelmanager.MaxLevel){
            newcolour = true;
            beforeLevel = Game.levelmanager.MaxLevel;
            addHint(text: "New colour unlocked! Swipe left to show off")
        }
    }
    
    override func updateBackgroundColour() {
        super.updateBackgroundColour();
        
        play_btn.getColour();
        highscore_btn.getColour();
        settings_btn.getColour();
        shop_btn.getColour();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var node:SKNode = SKNode();
        if let touch = touches.first {
            let location = touch.location(in: self);
            node = self.atPoint(location);
            touchStartLoc = location; //Variable we need for swipeable background
        }
        
        if(node.name == "play"){
            Game.soundManager.playSound(str: "click");
            Game.skView.presentScene(Game.scenes_gamescene!,
                                     transition: SKTransition.fade(with: UIColor.black,
                                                                   duration: TimeInterval(Game.SceneFade)));
        }else if(node.name == "scores"){
            Game.soundManager.playSound(str: "click");
            Game.skView.presentScene(Game.scenes_highscores!, transition: SKTransition.fade(with: UIColor.black, duration: TimeInterval(Game.SceneFade)));
        }else if(node.name == "shop"){
            Game.soundManager.playSound(str: "click");
            Game.skView.presentScene(Game.scenes_shop!,
                                     transition: SKTransition.fade(with: UIColor.black,
                                                                            duration: TimeInterval(Game.SceneFade)));
        }else if(node.name == "settings"){
            Game.soundManager.playSound(str: "click");
            Game.skView.presentScene(Game.scenes_settings!, transition: SKTransition.fade(with: UIColor.black, duration: TimeInterval(Game.SceneFade)));
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event);
    
        //Remove the new background hint when the user looks ta their new background
        if(BGselection == Game.levelmanager.MaxLevel && newcolour){
            newcolour = false;
            removeHint();
        }

    }
}
