//
//  platform-bouncy.swift
//  Cherry
//
//  Created by Luke Farrell on 19/05/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class platform_bouncy : Platform {
    var bounce_addon:GameObject = GameObject();
    
    var bounce_none_local:SKTexture!;
    var bounce_active_local:SKTexture!;
    
    var height : CGFloat = 0;
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)

        bounce_none_local = Game.GameInvertedColour ? Game.textures.bounce_none_inverted()
            : Game.textures.bounce_none();
        bounce_active_local = Game.GameInvertedColour ? Game.textures.bounce_active_inverted()
            : Game.textures.bounce_active();
        
        self.texture = bounce_none_local;
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        
        height = self.size.height;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func Touched() {
        resetBounce();
        
        Game.soundManager.playSound("bouncyplatform");
        
        Game.player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: Game.player.jumpforce));
        Game.player.canJump = false;
        Game.player.JumpCount = 1;
        
        let keepy = self.frame.minY; //Keep position on anchor point change
        self.anchorPoint = CGPoint(x: 0.5, y: 0);
        self.position.y = keepy;
        
        self.texture = bounce_active_local;
        self.size.height = self.size.height * 1.4;
        
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(platform_bouncy.resetBounce), userInfo: nil, repeats: false);
    }
    
    func resetBounce(){
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        self.size.height = height;
        self.texture = bounce_none_local;
    }
}