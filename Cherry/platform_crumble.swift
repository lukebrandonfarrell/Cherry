//
//  platform-crumble.swift
//  Cherry
//
//  Created by Luke Farrell on 19/05/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class platform_crumble : Platform {
    
    var crumbleTimer:NSTimer!;
    var crumble_emmiter:SKEmitterNode!;
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        let crumble_effect:NSString = Game.GameInvertedColour ? NSBundle.mainBundle().pathForResource("crumble_inverted", ofType: "sks")! : NSBundle.mainBundle().pathForResource("crumble", ofType: "sks")!
        crumble_emmiter = NSKeyedUnarchiver.unarchiveObjectWithFile(crumble_effect as String) as! SKEmitterNode;
        
        crumble_emmiter.position = CGPointMake(0, 0)
        crumble_emmiter.zPosition = 1
        crumble_emmiter.targetNode = self
        crumble_emmiter.particlePositionRange = CGVector(dx: self.size.width ,dy: 0);
        crumble_emmiter.particleBirthRate = 5;
        
        self.addChild(crumble_emmiter)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func Touched() {
        if(!hasTouched){
            Game.soundManager.playSound("crumble");
            
            crumble_emmiter.particleBirthRate = 25;
            
            crumbleTimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(platform_crumble.startCrumble), userInfo: nil, repeats: true);
        
            super.Touched();
        }
    }
    
    func startCrumble(){
        if(self.alpha > 0.2){
            self.alpha = self.alpha - 0.2;
        }else{
            crumbleTimer.invalidate();
            self.removeFromParent();
        }
    }
}