//
//  UIcheckbox.swift
//  Cherry
//
//  Created by Luke Farrell on 24/05/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit;

class CherryCheckbox : GameObject {
    var box : ShapeObject = ShapeObject(rect: CGRect(x: 0, y: 0, width: Game.GetX(value: 0.04), height: Game.GetX(value: 0.04)));
    var checkedColour:SKColor = SKColor.white;
    var checked : Bool = false;
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        box.lineWidth = 4.0;
        box.fillColor = UIColor(netHex: Game.MenuBackgroundColor);
        box.name = "cherry_checkbox";
        box.position.y = (box.position.y - box.frame.height/2) + 2;
        addChild(box);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func checkBox() {
        if(checked){
            checked = false;
            box.fillColor = UIColor(netHex: Game.MenuBackgroundColor);
        }else{
            checked = true;
            box.fillColor = checkedColour;
        }
    }
    
    func check(){
        checked = true;
        box.fillColor = checkedColour;
    }
    
    func reset(){
        checked = false;
        box.fillColor = UIColor(netHex: Game.MenuBackgroundColor);
    }
    
    func getColour(){
        if(Game.MenuBackgroundColor == 0xFFFFFF){
            box.strokeColor = SKColor.black;
            box.fillColor = SKColor.black;
            checkedColour = SKColor.black;
        }else{
            box.strokeColor = SKColor.white;
            box.fillColor = SKColor.white;
            checkedColour = SKColor.white;
        }
        
        if(!checked){
            box.fillColor = UIColor(netHex: Game.MenuBackgroundColor);
        }
    }
}
