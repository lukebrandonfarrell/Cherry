//
//  controls.swift
//  Cherry
//
//  Created by Luke Farrell on 11/08/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class controls : cherrymenu {
    
    var like_to_play_txt : TextObject = TextObject(fontNamed: "AvenirNext-Heavy");
    var can_change : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    
    var tiltControls:controlsOption = controlsOption(texture: Game.textures.screencontrol());
    var touchControls:controlsOption = controlsOption(texture: Game.textures.tapcontrol());
    
    override init(size: CGSize) {
        super.init(size: size);
        
        like_to_play_txt.setup(text: "HOW WOULD YOU LIKE TO PLAY?", name: "to_play", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.82), size: 85, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        can_change.setup(text: "You can change this in settings", name: "can_change", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.08), size: 60, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        
        addChild(like_to_play_txt);
        addChild(can_change);
        
        tiltControls.name = "tiltcontrols";
        touchControls.name = "touchcontrols";
        
        tiltControls.setup(x: Game.GetX(value: 0.26), y: Game.GetY(value: 0.45), size: Game.GetX(value: 0.0018), zPos: 1);
        tiltControls.setupText(title_string: "TILT", info_string: "Control the ball by tilting the screen");
        
        touchControls.setup(x: Game.GetX(value: 0.74), y: Game.GetY(value: 0.45), size: Game.GetX(value: 0.0018), zPos: 1);
        touchControls.setupText(title_string: "TOUCH", info_string: "Use touch screen to control the ball");
        
        addChild(tiltControls);
        addChild(touchControls);
        
        //let pre = NSLocale.preferredLanguages()[0]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        Game.controlsOFF = true
        Game.saveGame.saveInteger(data: (Game.controlsOFF ? 1 : 0), key: Game.saveGame.keyControls)
    }
    
    override func updateBackgroundColour() {
        super.updateBackgroundColour();
        
        like_to_play_txt.getColour();
        can_change.getColour();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var node: SKNode = SKNode()
        if let touch = touches.first {
            let location = touch.location(in: self)
            node = self.atPoint(location)
            touchStartLoc = location //Variable we need for swipeable background
        
            if(node.name == "tiltcontrols"){
                Game.tiltmovement = true
                Game.soundManager.playSound(str: "click")
                Game.skView.presentScene(Game.scenes_mainmenu!,
                                         transition: SKTransition.fade(with: .black,
                                                                   duration: TimeInterval(Game.SceneFade)))
                Game.saveGame.saveInteger(data: (Game.tiltmovement ? 1 : 0), key: Game.saveGame.keyTiltMovement)
            } else if(node.name == "touchcontrols"){
                Game.tiltmovement = false
                Game.soundManager.playSound(str: "click")
                Game.skView.presentScene(Game.scenes_mainmenu!, 
                                         transition: SKTransition.fade(with: .black, 
                                                                   duration: TimeInterval(Game.SceneFade)))
                Game.saveGame.saveInteger(data: (Game.tiltmovement ? 1 : 0), key: Game.saveGame.keyTiltMovement)
            }
        }
    }
}
