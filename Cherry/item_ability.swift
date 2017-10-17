//
//  item_ability.swift
//  Cherry
//
//  Created by Luke Farrell on 02/06/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class item_ability : GameObject {
    var item_image:GameObject!;
    var item_image_texture:SKTexture!;
    var item_image_texture_inverted:SKTexture!;
    
    let item_amount : TextObject = TextObject(fontNamed: "AvenirNext-Bold")
    let item_title : TextObject = TextObject(fontNamed: "AvenirNext-Bold")
    let item_des : TextObject = TextObject(fontNamed: "AvenirNext-Bold")
    let item_cost : TextObject = TextObject(fontNamed: "AvenirNext-Bold")
    let item_button : TextObject = TextObject(fontNamed: "AvenirNext-Bold")
    
    let cherry_icon : GameObject = GameObject(texture: Game.textures.cherry());
    let banana_icon : GameObject = GameObject(texture: Game.textures.banana());
    let pineapple_icon : GameObject = GameObject(texture: Game.textures.pineapple());
    let grape_icon : GameObject = GameObject(texture: Game.textures.grapes());
    
    let cherry_score : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    let banana_score : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    let pineapple_score : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    let grape_score : TextObject = TextObject(fontNamed: "AvenirNext-Bold");

    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadItem(normalTexture:SKTexture, invertedTexture:SKTexture, title:String, description:String, cost:[Int]) {
        let buy_id:String = (title.lowercaseString).stringByReplacingOccurrencesOfString(" ", withString: "");
        
        item_image_texture = normalTexture;
        item_image_texture_inverted = invertedTexture;
        
        item_image = GameObject(texture: normalTexture, size: CGSize(width: Game.GetX(0.1), height: Game.GetX(0.1)))
        item_image.position.x = self.frame.minX;
        item_image.position.y = self.frame.maxY;
        
        item_amount.setup(String(Game.avalible_ablities[buy_id]!), name: "item_title",
                          x:self.frame.minX - Game.GetX(0.07), y: item_image.frame.midY - Game.GetY(0.05),
                          size: 100, color: SKColor.whiteColor(),
                          align: SKLabelHorizontalAlignmentMode.Right, zPos: 1);
        
        
        var titlesize:CGFloat = 60;
        if(UIDevice.currentDevice().isiPad()){
            titlesize = 45;
        }
        item_title.setup(title, name: "item_title",
                         x:item_image.position.x + Game.GetX(0.07), y: item_image.position.y + Game.GetY(0.035),
                         size: titlesize, color: SKColor.whiteColor(),
                         align: SKLabelHorizontalAlignmentMode.Left, zPos: 1);
        
        
        var descriptionsize:CGFloat = 45;
        if(Game.modelName == "iPhone 4" || Game.modelName == "iPhone 4s"){
            descriptionsize = 40;
        }else if(UIDevice.currentDevice().isiPad()){
            descriptionsize = 35;
        }
        item_des.setup(description, name: "item_des",
                       x:item_image.position.x + Game.GetX(0.07), y: item_image.position.y - Game.GetY(0.022),
                       size: descriptionsize, color: SKColor.whiteColor(),
                       align: SKLabelHorizontalAlignmentMode.Left, zPos: 1);
        
        //Cost
        var costsize:CGFloat = 50;
        if(UIDevice.currentDevice().isiPad()){
            costsize = 40;
        }
        item_cost.setup("cost:", name: "item_cost",
                        x:item_image.position.x + Game.GetX(0.07), y: item_image.position.y - Game.GetY(0.08),
                        size: costsize, color: SKColor.whiteColor(),
                        align: SKLabelHorizontalAlignmentMode.Left, zPos: 1);
            
            if(cost[0] > 0){ //Cherries
                cherry_icon.setup(item_cost.frame.maxX + Game.GetX(0.02), y: item_cost.frame.midY, size: Game.GetX(0.0006), zPos: 1);
                cherry_score.setup(String(cost[0]), name: "cherry_cost",
                                   x: cherry_icon.frame.maxX, y: cherry_icon.frame.midY - item_cost.frame.height/2,
                                   size: 50, color: SKColor.whiteColor(),
                                   align: SKLabelHorizontalAlignmentMode.Left, zPos: 1)
                
                self.addChild(cherry_icon);
                self.addChild(cherry_score);
            }
            if(cost[1] > 0){ //Bananas
                banana_icon.setup(cherry_score.frame.maxX + cherry_score.frame.width, y: item_cost.frame.midY, size: Game.GetX(0.0006), zPos: 1);
                banana_score.setup(String(cost[1]), name: "banana_cost",
                                   x: banana_icon.frame.maxX, y: banana_icon.frame.midY - item_cost.frame.height/2,
                                   size: 50, color: SKColor.whiteColor(),
                                   align: SKLabelHorizontalAlignmentMode.Left, zPos: 1)
                
                self.addChild(banana_icon);
                self.addChild(banana_score);
            }
            if(cost[2] > 0){ //Pineapples
                pineapple_icon.setup(banana_score.frame.maxX + banana_score.frame.width, y: item_cost.frame.midY, size: Game.GetX(0.0006), zPos: 1);
                pineapple_score.setup(String(cost[2]), name: "pineapple_cost",
                                      x: pineapple_icon.frame.maxX, y: pineapple_icon.frame.midY - item_cost.frame.height/2,
                                      size: 50, color: SKColor.whiteColor(),
                                      align: SKLabelHorizontalAlignmentMode.Left, zPos: 1)
                
                self.addChild(pineapple_icon);
                self.addChild(pineapple_score);
            }
            if(cost[3] > 0){ //Grapes
                grape_icon.setup(pineapple_score.frame.maxX + pineapple_score.frame.width, y: item_cost.frame.midY, size: Game.GetX(0.0006), zPos: 1);
                grape_score.setup(String(cost[3]), name: "grape_cost",
                                  x: grape_icon.frame.maxX, y: grape_icon.frame.midY - item_cost.frame.height/2,
                                  size: 50, color: SKColor.whiteColor(),
                                  align: SKLabelHorizontalAlignmentMode.Left, zPos: 1)
                
                self.addChild(grape_icon);
                self.addChild(grape_score);
            }
        
        item_button.setup("Buy", name: buy_id,
                          x:self.frame.maxX, y: item_image.position.y,
                          size: 90, color: SKColor.whiteColor(),
                          align: SKLabelHorizontalAlignmentMode.Left, zPos: 1);
        
        self.addChild(item_amount);
        self.addChild(item_image);
        self.addChild(item_title);
        self.addChild(item_des);
        self.addChild(item_cost);
        self.addChild(item_button);
    }
    
    func getLabel() -> TextObject{
        return item_amount;
    }
    
    func getColour(){
        var invertedColour:Bool = false;
        invertedColour = Game.MenuInvertedColour;
        
        item_image.texture = invertedColour ? item_image_texture_inverted : item_image_texture;
        
        item_amount.getColour();
        item_title.getColour();
        item_des.getColour();
        item_cost.getColour();
        item_button.getColour();
        
        cherry_icon.texture = invertedColour ? Game.textures.cherry_Invert() : Game.textures.cherry()
        banana_icon.texture = invertedColour ? Game.textures.banana_Invert() : Game.textures.banana()
        pineapple_icon.texture = invertedColour ? Game.textures.pineapple_Invert() : Game.textures.pineapple()
        grape_icon.texture = invertedColour ? Game.textures.grapes_Invert() : Game.textures.grapes()
        
        cherry_score.getColour();
        banana_score.getColour();
        pineapple_score.getColour();
        grape_score.getColour();
    }
}