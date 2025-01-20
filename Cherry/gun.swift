//
//  gun.swift
//  Cherry
//
//  Created by Luke Farrell on 22/05/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit;
import Darwin;

class gun : Platform {
    var gun_base:GameObject!;
    var gun_barrel:GameObject!;
    
    var opposite : CGFloat = 0;
    var adjacent : CGFloat = 0;
    var hypotenuse : CGFloat = 0;
    
    var radians : CGFloat = 0;
    
    let diameter : CGFloat = Game.GetX(value: 0.06);
    
    var bulletforce : CGFloat = 400;
    var bullettimer:Timer!;
    var maximumradius:CGFloat = 0;
    
    var bullet_array:[bullet] = [];
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        let gunbase_texture:SKTexture = Game.GameInvertedColour ? Game.textures.gun_base_inverted()
            : Game.textures.gun_base();
        let gunbarrel_texture:SKTexture = Game.GameInvertedColour ? Game.textures.gun_barrel_inverted()
            : Game.textures.gun_barrel();
        
        gun_base = GameObject(texture: gunbase_texture);
        gun_barrel = GameObject(texture: gunbarrel_texture);
        
        gun_base.size.width = diameter; gun_base.size.height = diameter;
        gun_barrel.size.width = diameter * 2; gun_barrel.size.height = diameter / 4;
        
        addChild(gun_barrel);
        addChild(gun_base);
        
        //Maximum Radius
        maximumradius = Game.GetX(value: 0.2);
        
        let gunradius:ShapeObject = ShapeObject(circleOfRadius: maximumradius);
        addChild(gunradius);
        gunradius.lineWidth = 1.5;
        gunradius.strokeColor = Game.GameInvertedColour ? UIColor.black : UIColor.white;
        gunradius.xScale = 0.1;
        gunradius.yScale = 0.1;
        
        let resize:SKAction = SKAction.scale(to: 1.0, duration: 0.8);
        gunradius.run(resize);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func stop() {
        for bullet in bullet_array {
            bullet.removeFromParent()
        }
        bullet_array.removeAll()

        bullettimer.invalidate();
    }
    override func start() {
        bullettimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(gun.shoot), userInfo: nil, repeats: true);
    }
    
    override func update() {
        super.update();
        
        opposite = Game.player.position.y - self.position.y;
        adjacent = Game.player.position.x - self.position.x;
        
        hypotenuse = sqrt(opposite * opposite + adjacent * adjacent);
        
        //Look at player
        if(hypotenuse < maximumradius){
            radians = atan2(opposite, adjacent);
            gun_barrel.zRotation = radians;
        }
    }
    
    @objc func shoot () {
        if(hypotenuse < maximumradius){
            Game.soundManager.playSound(str: "shoot");
            
            let newbullet:bullet = bullet(circleOfRadius: Game.GetX(value: 0.008));
            Game.scenes_gamescene?.addChild(newbullet);
            bullet_array.append(newbullet);
            
            newbullet.position.x = self.position.x + (34 * cos(radians) - 8 * sin(radians));
            newbullet.position.y = self.position.y + (34 * sin(radians) + 8 * cos(radians));
            newbullet.physicsBody?.applyImpulse(CGVector(dx: adjacent / hypotenuse * bulletforce, dy: opposite / hypotenuse * bulletforce));
        }
    }
}
