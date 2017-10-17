//
//  File.swift
//  Cherry
//
//  Created by Luke Farrell on 12/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class Player : ShapeObject {
    var motion:MotionKit = MotionKit();
    
    var canBounce:Bool = false; //Is the player allowed to bounce
    
    var canJump:Bool = false; //Is the player allowed to jump
    var isJumping:Bool = false; //Is the player currently jumping
    var isFalling:Bool = false; //Is the player falling
    var screendirection:Int = 0; //Direction for screen controlls, 0 = none, 1 = left, 2 = right
    
    var canDoubleJump:Bool = false;
    var multipleJump:Int = 0;
    var JumpCount:Int = 0; //Count our Jumps
    
    var FirstContact:Bool = false; //Has the player had contact with first platform
    
    var callonce:Bool = false;
    var justContact:Bool = false;
    
    //This var is used to calculate where the player jumped from to seperate jumping and falling, if the player jumps into a fall
    var playerFallFromPosition:CGFloat = 0;
    
    //Caluclate player jump and speeed depending on device size
    var jumpforce:CGFloat = 0;
    var moveforce:CGFloat = 0;
    
    var propossedMass:CGFloat = 1.0; //Because this mass, dencity system is stupid
    
    var invertedControls:Double = 1.0;
    var deviceInvertedValue:Double = 0.0;
    
    //Teleport
    var teleport_emmiter:SKEmitterNode!;
    
    //Powerup Magnetic field
    let powerupField:SKFieldNode = SKFieldNode.radialGravityField()
    
    override init() {
        super.init()
        
        self.fillColor = UIColor.whiteColor();
        self.physicsBody = SKPhysicsBody(circleOfRadius: Game.GetX(0.01));
        self.physicsBody?.categoryBitMask = PhysicsCategory.player;
        self.physicsBody?.collisionBitMask = PhysicsCategory.platform | PhysicsCategory.bullet | PhysicsCategory.walls;
        self.physicsBody?.contactTestBitMask = PhysicsCategory.All;
        self.physicsBody?.fieldBitMask = PhysicsCategory.None;
        self.physicsBody?.linearDamping = 0.8;
        self.physicsBody?.restitution = 0;
        self.physicsBody?.friction = 0.0;
        self.physicsBody?.mass = 1;
        powerupField.region = SKRegion(radius: Float(Game.GetX(1.0)));
        powerupField.categoryBitMask = PhysicsCategory.None;
        powerupField.strength = 4;
        powerupField.falloff = 2;
        powerupField.minimumRadius = 0;
        powerupField.enabled = true;
        self.addChild(powerupField);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func calculateMovementSpeeds(newmass:CGFloat = 1.0){
        self.physicsBody?.mass = newmass;
        propossedMass = newmass;

        jumpforce = (Physics.jump * Game.GetY(0.1));
        moveforce = (Physics.ballspeed * Game.GetX(0.04));
        
        if(propossedMass >= 2.0){
            jumpforce = jumpforce * propossedMass;
            moveforce = moveforce * propossedMass;
        }
    }
    
    override func inView() {
        calculateMovementSpeeds();
        
        self.xScale = 1;
        self.yScale = 1;
        multipleJump = 0;
        
        screendirection = 0;
        
        FirstContact = false;
        canJump = false;
        
        if(Game.tiltmovement){
            motion.getDeviceMotionObject { (deviceMotion) -> () in
                if(self.FirstContact && !Game.gamepaused){
                    self.deviceInvertedValue = deviceMotion.attitude.roll;
                    if(Game.hasRotated){ //No change direction in game
                        if(self.deviceInvertedValue < 0){
                            self.invertedControls = -1.0;
                        }else{
                            self.invertedControls = 1.0;
                        }
                        Game.hasRotated = false
                    }
                
                    var y = deviceMotion.gravity.y;
                    y = y  * self.invertedControls
                  
                    if(y > -Double(Physics.tilt) || y < Double(Physics.tilt)){
                        if(abs((self.physicsBody?.velocity.dx)!) < 200){
                            self.physicsBody?.applyForce(CGVector(dx: CGFloat(y) * self.moveforce, dy: 0 ));
                        }
                    }
                }
            }
        }
    }
    
    var accel:Double = 0.01;
    override func update() {
        if(self.physicsBody?.velocity.dy < -5 && !isJumping){
            isFalling = true;
            justContact = true;
            callonce = false;
        }else{
            isFalling = false;
        }
        
        if(!Game.tiltmovement){
            if(screendirection != 0){
                var y:Double = 0.1;
                if(screendirection == 1){ //Left
                    y = -0.05 + -accel;
                } else if(screendirection == 2){ //Right
                    y = 0.05 + accel;
                }
                
                if(accel < 0.1){
                    accel = accel + 0.0001;
                }
                
                y = y  * invertedControls;
                if(y > -Double(Physics.tilt) || y < Double(Physics.tilt)){
                    if(abs((self.physicsBody?.velocity.dx)!) < 200){
                        self.physicsBody?.applyForce(CGVector(dx: CGFloat(y) * self.moveforce, dy: 0 ));
                    }
                }
            }else{
                accel = 0;
            }
        }
    }
    
    func NoDamp() {justContact = false;}
    
    func bounce(){
        if(canBounce){
            self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 1.0));
            canBounce = false;
        }
    }
    
    func jump(){
        if(canJump && !isFalling && !Game.gamepaused){
            self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: jumpforce));
            playerFallFromPosition = self.position.y;
            canJump = false;
            justContact = true;
            callonce = false;
            isJumping = true;
            canDoubleJump = true;
            JumpCount = 0;
            JumpCount += 1;
            Game.soundManager.playSound("jump");
        }else if(multipleJump > JumpCount){
            var extraBoost:CGFloat = 0;
            let v:CGFloat = (self.physicsBody?.velocity.dy)!;
            extraBoost = -(v) * propossedMass;
            if(extraBoost > 1000){extraBoost = extraBoost/1.5;}
            
            self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: jumpforce + extraBoost));
            
            if(playerFallFromPosition > self.position.y){
                playerFallFromPosition = self.position.y;
            }
            JumpCount += 1;
            if(multipleJump == JumpCount){
                canDoubleJump = false;
            }
            Game.soundManager.playSound("multiplejump");
        }
    }
    
    func teleport(p:CGPoint){
        Game.soundManager.playSound("teleport");
        
        self.position.x = p.x;
        self.position.y = p.y;
        
        let teleport_effect:NSString = Game.GameInvertedColour ? NSBundle.mainBundle().pathForResource("teleport_inverted", ofType: "sks")! : NSBundle.mainBundle().pathForResource("teleport", ofType: "sks")!
        teleport_emmiter = NSKeyedUnarchiver.unarchiveObjectWithFile(teleport_effect as String) as! SKEmitterNode;
        
        teleport_emmiter.position = CGPointMake(self.position.x, self.position.y)
        if(Game.scenes_gamescene != nil){
            teleport_emmiter.targetNode = Game.scenes_gamescene!
            Game.scenes_gamescene!.addChild(teleport_emmiter)
        }
    }
    
    func Die(){
        motion.stopDeviceMotionUpdates();
        self.removeFromParent();
    }
    
    func getColour(){
        self.fillColor = Game.GameInvertedColour ? SKColor.blackColor() : SKColor.whiteColor();
        self.strokeColor = Game.GameInvertedColour ? SKColor.blackColor() : SKColor.whiteColor();
    }
}