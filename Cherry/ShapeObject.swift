//
//  ShapeObject.swift
//  Cherry
//
//  Created by Luke Farrell on 12/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class ShapeObject : SKShapeNode {
    override init() {
        super.init();
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
    }
    
    func inView(){ //This is called when the object appears on the screen, we can rest game objects to there original properties using this method
        
    }
}