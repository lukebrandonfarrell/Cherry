//
//  platformpool.swift
//  Cherry
//
//  Created by Luke Farrell on 11/06/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit;

class platform_pool {
    var platformSize : CGSize = CGSize(width: Game.GetX(value: 0.1), height: Game.GetY(value: 0.025));
    
    var platforms:[Platform] = [];
    var platforms_bouncy:[platform_bouncy] = [];
    var platforms_crumble:[platform_crumble] = [];
    var platforms_gun:[gun] = [];
    
    var getCount:Int = 0;
    
    func makePlatforms(){
        for _ in 0..<20 {
            let platform:Platform = Platform(color: UIColor.white, size: platformSize);
            platforms.append(platform);
        }
        
        for _ in 0..<5 {
            let platform:Platform = Platform(color: UIColor.white, size: platformSize);
            platforms.append(platform);
        }

        
        for _ in 0..<5 {
            let platform:Platform = Platform(color: UIColor.white, size: platformSize);
            platforms.append(platform);
        }

        
        for _ in 0..<5 {
            let platform:Platform = Platform(color: UIColor.white, size: platformSize);
            platforms.append(platform);
        }
    }
    
    func getPlatform() -> Platform {
        if(platforms.count > 0){
            let plat:Platform = platforms[0];
            platforms.removeFirst();
            return plat;
        }else{
            let plat:Platform = Platform();
            return plat;
        }
    }
    
    func returnPlatform(plat:Platform){
        platforms.append(plat);
    }
}
