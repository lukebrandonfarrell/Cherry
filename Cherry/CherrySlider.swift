//
//  Slider.swift
//  Cherry
//
//  Created by Luke Farrell on 24/05/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class CherrySlider : GameObject {
    var line : ShapeObject = ShapeObject(rect: CGRect(x: 0, y: 0, width: Game.GetX(value: 0.2), height: Game.GetY(value: 0.02)));
    var slider : ShapeObject = ShapeObject(circleOfRadius: Game.GetX(value: 0.02));
    var type:String = "slider";
    
    var value : CGFloat = 0.5;
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        line.fillColor = SKColor.white;
        slider.fillColor = SKColor.white;
        
        slider.position.x = line.frame.midX;
        line.position.y = slider.frame.midY - 2;
        
        addChild(line);
        addChild(slider);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveSlider(x : CGFloat) {
        slider.position.x = x;
        
        value = (x/line.frame.width);
    }
    
    func getValue(Mult:CGFloat = 1.0, fudge:CGFloat = 0.0) -> CGFloat {
        return (value + fudge) * Mult;
    }
    
    func reset(v:CGFloat = 1.0){
        slider.position.x = line.frame.midX;
        value = v;
    }
    
    func getColour(){
        line.fillColor = Game.MenuInvertedColour ? SKColor.black : SKColor.white;
        slider.fillColor = Game.MenuInvertedColour ? SKColor.black : SKColor.white;
    }
}
