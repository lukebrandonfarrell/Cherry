//
//  physicsroom.swift
//  Cherry
//
//  Created by Luke Farrell on 22/05/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class physicsroom : cherrymenu {
    var physcisroomtitle : TextObject = TextObject(fontNamed: "AvenirNext-Heavy")
    var tagline : TextObject = TextObject(fontNamed: "AvenirNext-Bold")
    
    var ballspeed_text : TextObject = TextObject(fontNamed: "AvenirNext-Bold")
    var jump_text : TextObject = TextObject(fontNamed: "AvenirNext-Bold")
    var walls_text : TextObject = TextObject(fontNamed: "AvenirNext-Bold")
    
    var tilt_text : TextObject = TextObject(fontNamed: "AvenirNext-Bold")
    var gravity_text : TextObject = TextObject(fontNamed: "AvenirNext-Bold")
    var reset_text : TextObject = TextObject(fontNamed: "AvenirNext-Bold")
    
    
    var ballspeed_slider : CherrySlider = CherrySlider();
    var jump_slider : CherrySlider = CherrySlider();
    var gravity_slider : CherrySlider = CherrySlider();
    var tilt_slider : CherrySlider = CherrySlider();

    var accel_slider : CherrySlider = CherrySlider();
    var walls_checkbox : CherryCheckbox = CherryCheckbox();
    
    var back_btn : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    
    var temp_slider:CherrySlider! = nil;
    
    override init(size: CGSize) {
        super.init(size: size);
        loadBackground();
        loadHint(); //If scene uses hints, load this
        
        physcisroomtitle.setup(text: "PHYSICS ROOM", name: "physicsroom", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.8), size: 150, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        tagline.setup(text: "If only you could alter physics. oh wait! You can…", name: "tagline", x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.7), size:55, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        
        
        ballspeed_text.setup(text: "Speed", name: "ballspeed",
                             x: Game.GetX(value: 0.22), y: Game.GetY(value: 0.54),
                             size: 55, color: SKColor.white,
                             align: SKLabelHorizontalAlignmentMode.right, zPos: 1);
        jump_text.setup(text: "Jump", name: "jump",
                        x: Game.GetX(value: 0.22), y: Game.GetY(value: 0.38),
                        size: 55, color: SKColor.white,
                        align: SKLabelHorizontalAlignmentMode.right, zPos: 1);
        walls_text.setup(text: "Walls", name: "walls",
                         x: Game.GetX(value: 0.22), y: Game.GetY(value: 0.20),
                         size: 55, color: SKColor.white,
                         align: SKLabelHorizontalAlignmentMode.right, zPos: 1);
        
        
        tilt_text.setup(text: "tilt", name: "tilt",
                        x: Game.GetX(value: 0.62), y: Game.GetY(value: 0.54),
                        size: 55, color: SKColor.white,
                        align: SKLabelHorizontalAlignmentMode.right, zPos: 1);
        gravity_text.setup(text: "Gravity", name: "gravity",
                           x: Game.GetX(value: 0.62), y: Game.GetY(value: 0.38),
                           size: 55, color: SKColor.white,
                           align: SKLabelHorizontalAlignmentMode.right, zPos: 1);
        
        reset_text.setup(text: "RESET", name: "reset",
                         x: Game.GetX(value: 0.96), y: Game.GetY(value: 0.05),
                         size: 60, color: SKColor.white,
                         align: SKLabelHorizontalAlignmentMode.right, zPos: 1);
       
        
        back_btn.setup(text: "BACK", name: "back", x: Game.GetX(value: 0.04), y: Game.GetY(value: 0.05), size: 60, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.left, zPos: 1);
        
        addChild(physcisroomtitle);
        addChild(tagline);
        
        addChild(ballspeed_text);
        addChild(jump_text);
        addChild(gravity_text);
        addChild(tilt_text);
        addChild(walls_text);
        addChild(reset_text);
        
        ballspeed_slider.name = "slider";
        ballspeed_slider.type = "slider_ballspeed";
        ballspeed_slider.position.x = Game.GetX(value: 0.27);
        ballspeed_slider.position.y = ballspeed_text.frame.midY;
        addChild(ballspeed_slider);
        
        jump_slider.name = "slider";
        jump_slider.type = "slider_jump";
        jump_slider.position.x = Game.GetX(value: 0.27);
        jump_slider.position.y = jump_text.frame.midY;
        addChild(jump_slider);
        
        gravity_slider.name = "slider";
        gravity_slider.type = "slider_gravity";
        gravity_slider.position.x = Game.GetX(value: 0.67);
        gravity_slider.position.y = gravity_text.frame.midY;
        addChild(gravity_slider);
        
        
        tilt_slider.value = 0.25;
        tilt_slider.name = "slider";
        tilt_slider.type = "slider_tilt";
        tilt_slider.position.x = Game.GetX(value: 0.67);
        tilt_slider.position.y = tilt_text.frame.midY;
        addChild(tilt_slider);
        
        walls_checkbox.position.x = Game.GetX(value: 0.26);
        walls_checkbox.position.y = walls_text.frame.midY;
        addChild(walls_checkbox);
        
        addChild(back_btn);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view);
        
        if(Physics.ballspeedX == 0){
            ballspeed_slider.reset();
        }else{
            ballspeed_slider.moveSlider(x: Physics.ballspeedX);
        }
        
        if(Physics.jumpX == 0){
            jump_slider.reset();
        }else{
            jump_slider.moveSlider(x: Physics.jumpX);
        }
        
        if(Physics.gravityX == 0){
            gravity_slider.reset();
        }else{
            gravity_slider.moveSlider(x: Physics.gravityX)
        }
        
        if(Physics.tiltX == 0){
            tilt_slider.reset();
        }else{
            tilt_slider.moveSlider(x: Physics.tiltX)
        }
        
        if(Physics.walls){
            walls_checkbox.check();
        }else{
            walls_checkbox.reset();
        }
    }
    
    override func updateBackgroundColour() {
        super.updateBackgroundColour();
        
        physcisroomtitle.getColour();
        tagline.getColour();
        
        ballspeed_text.getColour();
        jump_text.getColour();
        gravity_text.getColour();
        tilt_text.getColour();
        walls_text.getColour();
        reset_text.getColour();
        
        ballspeed_slider.getColour();
        jump_slider.getColour();
        gravity_slider.getColour();
        tilt_slider.getColour();
        walls_checkbox.getColour();
        
        back_btn.getColour();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var node:SKNode = SKNode();
        if let touch = touches.first {
            let location = touch.location(in: self);
            node = self.atPoint(location);
            touchStartLoc = location; //Variable we need for swipeable background

            if(node.name == "cherry_checkbox"){
                let temp_checkbox : CherryCheckbox = node.parent as! CherryCheckbox;
                temp_checkbox.checkBox();
                Physics.walls = temp_checkbox.checked;
            }else if(node.name == "reset"){
                ballspeed_slider.reset(v: 0.5);
                jump_slider.reset(v: 0.5);
                gravity_slider.reset(v: 0.5);
                tilt_slider.reset(v: 0.25);
                walls_checkbox.reset();
                Physics.walls = false;
                
                Physics.ballspeedX = 0;
                Physics.jumpX = 0;
                Physics.gravityX = 0;
                Physics.tiltX = 0;
                
                UpdateValues();
            }else if(node.name == "back"){
                Game.saveGame.savePhysicsData();
                Game.skView.presentScene(Game.scenes_settings!,
                                         transition: SKTransition.fade(with: UIColor.black,
                                                                       duration: TimeInterval(Game.SceneFade)));
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var node:SKNode = SKNode();
        if let touch = touches.first {
            let location = touch.location(in: self);
            node = self.atPoint(location);
            
            if(node.name == "slider"){
                temp_slider = node as? CherrySlider;
            }
            
            if(temp_slider != nil){
                let minX:CGFloat = temp_slider.frame.minX;
                let maxX:CGFloat = temp_slider.frame.minX + temp_slider.line.frame.width;
                var newx : CGFloat = 0;
                
                if(location.x > minX && location.x < maxX){
                    newx = location.x - minX;
                    temp_slider.moveSlider(x: newx);
                    
                    //Save slider values temporarily
                    if(temp_slider.type == "slider_ballspeed"){
                        Physics.ballspeedX = newx;
                    }
                    if(temp_slider.type == "slider_jump"){
                        Physics.jumpX = newx;
                    }
                    if(temp_slider.type == "slider_gravity"){
                        Physics.gravityX = newx;
                    }
                    if(temp_slider.type == "slider_tilt"){
                        Physics.tiltX = newx;
                    }
                }
                
                UpdateValues();
            }
        }
    }
    
    func UpdateValues(){
        //Calculate Values everytime we move a slider
        Physics.ballspeed = Physics.default_ballspeed * ballspeed_slider.getValue(Mult: 1.0, fudge: 0.5);
        Physics.jump = Physics.default_jump * jump_slider.getValue(Mult: 1.0, fudge: 0.5);
        Physics.gravity = Physics.default_gravity * gravity_slider.getValue(Mult: 1.0, fudge: 0.5);
        Physics.tilt = Physics.default_tilt * tilt_slider.getValue(Mult: 4.0);
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //We don't want slideing backgrounds on physics room
        
        temp_slider = nil;
    }
}
