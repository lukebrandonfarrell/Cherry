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
        areyousure.setup("Are you sure you", name: "areyousure",
                         x: Game.GetX(0.5), y: Game.GetY(0.65), size: 80, color: SKColor.whiteColor(),
                         align: SKLabelHorizontalAlignmentMode.Center, zPos: 4);
        wanttobuy.setup("want to buy", name: "wanttobuy",
                         x: Game.GetX(0.5), y: areyousure.frame.minY - areyousure.frame.height, size: 80, color: SKColor.whiteColor(),
                         align: SKLabelHorizontalAlignmentMode.Center, zPos: 4);
        itemname.setup("'" + item + "'?", name: "item",
                        x: Game.GetX(0.5), y: wanttobuy.frame.minY - wanttobuy.frame.height, size: 80, color: SKColor.whiteColor(),
                        align: SKLabelHorizontalAlignmentMode.Center, zPos: 4);
        
        cancel.setup("Cancel", name: "cancel_item",
                         x: Game.GetX(0.25), y: Game.GetY(0.28), size: 80, color: SKColor.whiteColor(),
                         align: SKLabelHorizontalAlignmentMode.Left, zPos: 4);
        
        buy.setup("Buy", name: "buy_item",
                  x: Game.GetX(0.75), y: Game.GetY(0.28), size: 80, color: SKColor.whiteColor(),
                  align: SKLabelHorizontalAlignmentMode.Right, zPos: 4);
        
        self.alpha = 1.0;
        getColour();
    }
    
    func getColour(){
        if(Game.MenuBackgroundColor == 0x000000){
            backgroundshape.fillColor = SKColor.whiteColor()
            
            areyousure.fontColor = SKColor.blackColor();
            wanttobuy.fontColor = SKColor.blackColor();
            itemname.fontColor = SKColor.blackColor();
            buy.fontColor = SKColor.blackColor();
            cancel.fontColor = SKColor.blackColor();
        }else{
            backgroundshape.fillColor = SKColor.blackColor()
            
            areyousure.fontColor = SKColor.whiteColor()
            wanttobuy.fontColor = SKColor.whiteColor()
            itemname.fontColor = SKColor.whiteColor()
            buy.fontColor = SKColor.whiteColor()
            cancel.fontColor = SKColor.whiteColor()
        }
    }

    override func close() {
        self.alpha = 0.0;
    }
}