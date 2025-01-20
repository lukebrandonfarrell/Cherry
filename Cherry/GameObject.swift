//
//  GameObject.swift
//  Hedgehog Dash
//
//  Created by Luke on 2/23/16.
//  Copyright © 2016 Puzzled. All rights reserved.
//

import Foundation
import SpriteKit

//This class is the root of all gameobjects

class GameObject : SKSpriteNode {
    var isBlinking:Bool = false;
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(x:CGFloat, y:CGFloat, size:CGFloat, zPos:CGFloat){
        //setup will position an object and make it the right size
        self.position = CGPoint(x: x, y: y);
        self.setScale(size);
        self.zPosition = zPos;
    }
    
    func update(){
        //Update will loop through an objects logic
        MoveUp();
    }
    
    private func MoveUp(){
        self.position.y += Game.platform_spawner.platformSpeed * (Game.scenes_gamescene?.physicsWorld.speed)!;
        
        if(self.position.y > Game.sceneHeight){
            self.removeFromParent();
        }
    }
    
    func inView(){ //This is called when the object appears on the screen, we can rest game objects to there original properties using this method
    }
    func outView(){ //Called when object moves out of view
    }
        
    func MakeHitBox(name:String){
        let HitBox:SKShapeNode = SKShapeNode(rect: CGRect(x: 0, y: 0, width: self.size.width * 15, height: self.size.height * 10));
        HitBox.position = CGPoint(x: -HitBox.frame.width/2, y: -HitBox.frame.height/2);
        HitBox.fillColor = SKColor.black;
        HitBox.lineWidth = 0.0;
        HitBox.zPosition = 0;
        HitBox.name = name;
        HitBox.alpha = 0;
        self.addChild(HitBox);
    }
}
