//
//  settings.swift
//  Cherry
//
//  Created by Luke Farrell on 12/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class settings : cherrymenu {
    var settings : TextObject = TextObject(fontNamed: "AvenirNext-Heavy");
    //var music_btn : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    var soundfx_btn : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    var autoresume_btn : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    //var physicsroom_btn : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    var handed_btn : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    var controls_btn : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    var about_btn : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    
    var back_btn : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    
    var skull_stat:GameObject = GameObject(texture: Game.textures.skull());
    var hourglass_stat:GameObject = GameObject(texture: Game.textures.hourglass());
    
    var skull_text : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    var hourglass_text : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    
    override init(size: CGSize) {
        super.init(size: size);
        loadBackground();
        loadHint(); //If scene uses hints, load this
        
        settings.setup(text: "SETTINGS", name: "settings", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.78), size: 150, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        //music_btn.setup("MUSIC ON", name: "music", x: Game.GetX(0.5), y: Game.GetY(0.6), size: 100, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Center, zPos: 1);
        soundfx_btn.setup(text: "SOUNDFX ON", name: "soundfx", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.62), size: 100, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        autoresume_btn.setup(text: "AUTOPLAY OFF", name: "autoplay", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.50), size: 100, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1)
        //physicsroom_btn.setup("PHYSICS ROOM", name: "physicsroom", x: Game.GetX(0.5), y: Game.GetY(0.3), size: 100, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Center, zPos: 1);
        handed_btn.setup(text: "RIGHT HANDED", name: "orientation", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.38), size: 100, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        controls_btn.setup(text: "TILT CONTROLS", name: "controls", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.26), size: 100, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        about_btn.setup(text: "ABOUT", name: "about", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.14), size: 100, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        
        back_btn.setup(text: "BACK", name: "back", x: Game.GetX(value: 0.04), y: Game.GetY(value: 0.05), size: 60, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.left, zPos: 1);
        
        addChild(settings);
        //addChild(music_btn);
        addChild(soundfx_btn);
        addChild(autoresume_btn);
        //addChild(physicsroom_btn);
        addChild(controls_btn);
        addChild(handed_btn);
        addChild(about_btn);
        
        addChild(back_btn);
        
        //Info bar
        var textsize:CGFloat = 60;
        if(UIDevice.current.isiPad()){
            textsize = 27;
        }

        skull_text.setup(text: "0", name: "skull_text",
                         x: Game.GetX(value: 0.96), y: Game.GetY(value: 0.05),
                         size: textsize, color: SKColor.white,
                         align: SKLabelHorizontalAlignmentMode.right, zPos: 1);
        
        hourglass_text.setup(text: "0", name: "hourglass_text",
                             x: 0, y: Game.GetY(value: 0.05),
                             size: textsize, color: SKColor.white,
                             align: SKLabelHorizontalAlignmentMode.right, zPos: 1);
        
        skull_stat.setup(x: 0, y: skull_text.frame.midY, size: 0.5, zPos: 1);
        hourglass_stat.setup(x: 0, y: hourglass_text.frame.midY, size: 0.5, zPos: 1);
        
        addChild(skull_stat)
        addChild(hourglass_stat)
        addChild(skull_text)
        addChild(hourglass_text)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view);
        
        /*if(Game.musicON){
            music_btn.text = "MUSIC ON";
        }else{
            music_btn.text = "MUSIC OFF";
        }*/
        
        if(Game.soundFX){
            soundfx_btn.text = "SOUNDFX ON";
        }else{
            soundfx_btn.text = "SOUNDFX OFF";
        }

        if(Game.autoplayON){
            autoresume_btn.text = "AUTOPLAY ON";
        }else{
            autoresume_btn.text = "AUTOPLAY OFF";
        }
        
        if(Game.ability_bar.orientation){
            handed_btn.text = "RIGHT HANDED";
        }else{
            handed_btn.text = "LEFT HANDED";
        }

        if(Game.tiltmovement){
            controls_btn.text = "TILT CONTROLS";
        }else{
            controls_btn.text = "TOUCH CONTROLS";
        }

        skull_stat.texture = Game.MenuInvertedColour ? Game.textures.skull_inverted() : Game.textures.skull();
        hourglass_stat.texture = Game.MenuInvertedColour ?  Game.textures.hourglass_inverted() : Game.textures.hourglass();
        
        skull_text.text = Calc.formatNumber(number: NSNumber(value: Stats.numberOfDeaths)) as String
        hourglass_text.text = Calc.formatTime(number: Stats.timePlayed);
        
        skull_stat.position.x = skull_text.frame.minX - skull_stat.size.width / 1.5;
        hourglass_text.position.x = skull_stat.frame.minX - skull_stat.size.width/2;
        hourglass_stat.position.x = hourglass_text.frame.minX - hourglass_stat.size.width / 1.5;
    }
    
    override func updateBackgroundColour() {
        super.updateBackgroundColour();
        
        settings.getColour();
        soundfx_btn.getColour();
        autoresume_btn.getColour();
        //physicsroom_btn.getColour();
        handed_btn.getColour();
        about_btn.getColour();
        back_btn.getColour();
        skull_text.getColour();
        hourglass_text.getColour();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var node:SKNode = SKNode();
        if let touch = touches.first {
            let location = touch.location(in: self);
            node = self.atPoint(location);
            touchStartLoc = location; //Variable we need for swipeable background
        }
        
        /*if(node.name == "music"){
            if(Game.musicON){
                music_btn.text = "MUSIC OFF";
                Game.musicON = false;
                Game.soundManager.stopMusic("song");
            }else{
                music_btn.text = "MUSIC ON";
                Game.musicON = true;
                Game.soundManager.playMusic("song");
            }
            Game.soundManager.playSound("click");
        }*/
        
        if(node.name == "soundfx"){
            if(Game.soundFX){
                soundfx_btn.text = "SOUNDFX OFF";
                Game.soundFX = false;
            }else{
                soundfx_btn.text = "SOUNDFX ON";
                Game.soundFX = true;
            }
            Game.soundManager.playSound(str: "click");
            Game.saveGame.saveMenuData();
        }

        if(node.name == "autoplay"){
            if(Game.autoplayON){
                autoresume_btn.text = "AUTOPLAY OFF";
                Game.autoplayON = false;
            }else{
                autoresume_btn.text = "AUTOPLAY ON";
                Game.autoplayON = true;
            }
            Game.soundManager.playSound(str: "click");
            Game.saveGame.saveMenuData();
        }
        
        if(node.name == "orientation"){
            Game.ability_bar.switchSides();
            
            if(Game.ability_bar.orientation){
                handed_btn.text = "RIGHT HANDED";
            }else{
                handed_btn.text = "LEFT HANDED";
            }
            Game.soundManager.playSound(str: "click");
        }
        
        if(node.name == "controls"){
            if(Game.tiltmovement){
                controls_btn.text = "TOUCH CONTROLS";
                Game.tiltmovement = false;
                Game.tutorialON = true;
            }else{
                controls_btn.text = "TILT CONTROLS";
                Game.tiltmovement = true;
                Game.tutorialON = true;
            }
            Game.soundManager.playSound(str: "click");
            Game.saveGame.saveMenuData();
        }

       /* if(node.name == "physicsroom"){
            Game.soundManager.playSound("click");
            Game.skView.presentScene(Game.scenes_physicsroom!, transition: SKTransition.fadeWithColor(UIColor.blackColor(), duration: NSTimeInterval(Game.SceneFade)));
        } */

        if(node.name == "about"){
            Game.soundManager.playSound(str: "click");
            Game.skView.presentScene(Game.scenes_about!, transition: SKTransition.fade(with: UIColor.black, duration: TimeInterval(Game.SceneFade)));
        }

        
        if(node.name == "back"){
            Game.soundManager.playSound(str: "click");
            Game.saveGame.saveMenuData();
            Game.skView.presentScene(Game.scenes_mainmenu!, transition: SKTransition.fade(with: UIColor.black, duration: TimeInterval(Game.SceneFade)));
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event);
    }
}
