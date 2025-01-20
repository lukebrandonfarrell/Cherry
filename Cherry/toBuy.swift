//
//  toBuy.swift
//  Cherry
//
//  Created by Luke Farrell on 03/06/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class toBuy : PopUp {
    var areyousure : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    var wanttobuy : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    var itemname : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    
    var buy : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    var cancel : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size);
        
        setupBG();
        addChild(areyousure);
        addChild(wanttobuy);
        addChild(itemname);
        
        addChild(buy)
        addChild(cancel)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func show(item:String){
        areyousure.setup(text: "Are you sure you", name: "areyousure",
                         x: Game.GetX(value: 0.5), y: Game.GetY(value: 0.65), size: 80, color: SKColor.white,
                         align: SKLabelHorizontalAlignmentMode.center, zPos: 4);
        wanttobuy.setup(text: "want to buy", name: "wanttobuy",
                        x: Game.GetX(value: 0.5), y: areyousure.frame.minY - areyousure.frame.height, size: 80, color: SKColor.white,
                        align: SKLabelHorizontalAlignmentMode.center, zPos: 4);
        itemname.setup(text: "'" + item + "'?", name: "item",
                       x: Game.GetX(value: 0.5), y: wanttobuy.frame.minY - wanttobuy.frame.height, size: 80, color: SKColor.white,
                       align: SKLabelHorizontalAlignmentMode.center, zPos: 4);
        
        cancel.setup(text: "Cancel", name: "cancel_item",
                     x: Game.GetX(value: 0.25), y: Game.GetY(value: 0.28), size: 80, color: SKColor.white,
                     align: SKLabelHorizontalAlignmentMode.left, zPos: 4);
        
        buy.setup(text: "Buy", name: "buy_item",
                  x: Game.GetX(value: 0.75), y: Game.GetY(value: 0.28), size: 80, color: SKColor.white,
                  align: SKLabelHorizontalAlignmentMode.right, zPos: 4);
        
        self.alpha = 1.0;
        getColour();
    }
    
    func getColour(){
        if(Game.MenuBackgroundColor == 0x000000){
            backgroundshape.fillColor = SKColor.white
            
            areyousure.fontColor = SKColor.black;
            wanttobuy.fontColor = SKColor.black;
            itemname.fontColor = SKColor.black;
            buy.fontColor = SKColor.black;
            cancel.fontColor = SKColor.black;
        }else{
            backgroundshape.fillColor = SKColor.black
            
            areyousure.fontColor = SKColor.white
            wanttobuy.fontColor = SKColor.white
            itemname.fontColor = SKColor.white
            buy.fontColor = SKColor.white
            cancel.fontColor = SKColor.white
        }
    }

    override func close() {
        self.alpha = 0.0;
    }
}
