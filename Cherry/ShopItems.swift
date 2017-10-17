//
//  ShopItems.swift
//  Cherry
//
//  Created by Luke Farrell on 26/05/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class ShopItems : GameObject {
    var shoptitle : TextObject = TextObject(fontNamed: "AvenirNext-Heavy")
    
    var subtitle_abilities : TextObject = TextObject(fontNamed: "AvenirNext-Heavy")
    var tagline_abilities : TextObject = TextObject(fontNamed: "AvenirNext-Heavy")
    
    var topfruit_item:item_ability!;
    var fruitadox_item:item_ability!;
    var sweetfruit_item:item_ability!;
    var fruitbowl_item:item_ability!;
    var teleport_item:item_ability!;
    var theripening_item:item_ability!;
    
    //Store the amount labels in here so we can dynamically increase them
    var amount_label_array:[String : TextObject] = [String : TextObject]();
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size);
        
        shoptitle.setup("SHOP", name: "shop",
                        x: 0, y: Game.GetY(0.0),
                        size: 150, color: SKColor.whiteColor(),
                        align: SKLabelHorizontalAlignmentMode.Center, zPos: 1);
        
        subtitle_abilities.setup("Abilities", name: "subtitle_abilities",
                        x: 0, y: shoptitle.position.y - Game.GetY(0.15),
                        size: 80, color: SKColor.whiteColor(),
                        align: SKLabelHorizontalAlignmentMode.Center, zPos: 1);
        
        tagline_abilities.setup("Ripening up your game", name: "tagline_abilities",
                        x:0, y: subtitle_abilities.position.y - Game.GetY(0.1),
                        size: 60, color: SKColor.whiteColor(),
                        align: SKLabelHorizontalAlignmentMode.Center, zPos: 1);
        
        addChild(shoptitle);
        addChild(subtitle_abilities)
        addChild(tagline_abilities);
        
        topfruit_item = item_ability(texture: nil, size: CGSize(width: Game.GetX(0.6), height: Game.GetY(0.3)))
        topfruit_item.setup(0, y: -Game.GetY(0.3), size: 1.0, zPos: 1);
        topfruit_item.loadItem(Game.textures.topfruit(), invertedTexture: Game.textures.topfruit_inverted(),
                               title: "Top Fruit", description: "Bounce against the top of the screen", cost: [3, 0, 0, 0])
        amount_label_array["topfruit"] = topfruit_item.getLabel();
        addChild(topfruit_item);
        
        fruitadox_item = item_ability(texture: nil, size: CGSize(width: Game.GetX(0.6), height: Game.GetY(0.3)))
        fruitadox_item.setup(0, y: topfruit_item.frame.minY, size: 1.0, zPos: 1);
        fruitadox_item.loadItem(Game.textures.fruitadox(), invertedTexture: Game.textures.fruitadox_inverted(),
                                title: "Fruitadox", description: "Next fruity pickup will last 2x as long", cost: [3, 1, 0, 0])
        amount_label_array["fruitadox"] = fruitadox_item.getLabel();
        addChild(fruitadox_item);

        sweetfruit_item = item_ability(texture: nil, size: CGSize(width: Game.GetX(0.6), height: Game.GetY(0.3)))
        sweetfruit_item.setup(0, y: fruitadox_item.frame.minY, size: 1.0, zPos: 1);
        sweetfruit_item.loadItem(Game.textures.sweetfruit(), invertedTexture: Game.textures.sweetfruit_inverted(),
                                 title: "Sweet Fruit", description: "Next fruity pickup will have x2 effect", cost: [3, 3, 0, 0])
        amount_label_array["sweetfruit"] = sweetfruit_item.getLabel();
        addChild(sweetfruit_item);
        
        fruitbowl_item = item_ability(texture: nil, size: CGSize(width: Game.GetX(0.6), height: Game.GetY(0.3)))
        fruitbowl_item.setup(0, y: sweetfruit_item.frame.minY, size: 1.0, zPos: 1);
        fruitbowl_item.loadItem(Game.textures.fruitbowl(), invertedTexture: Game.textures.fruitbowl_inverted(),
                                 title: "Fruit Bowl", description: "Pulls all fruit to you", cost: [5, 3, 0, 0])
        amount_label_array["fruitbowl"] = fruitbowl_item.getLabel();
        addChild(fruitbowl_item);
        
        teleport_item = item_ability(texture: nil, size: CGSize(width: Game.GetX(0.6), height: Game.GetY(0.3)))
        teleport_item.setup(0, y: fruitbowl_item.frame.minY, size: 1.0, zPos: 1);
        teleport_item.loadItem(Game.textures.teleport(), invertedTexture: Game.textures.teleport_inverted(),
                                 title: "Teleport", description: "Teleport to next touch location", cost: [3, 2, 1, 0])
        amount_label_array["teleport"] = teleport_item.getLabel();
        addChild(teleport_item);
        
        theripening_item = item_ability(texture: nil, size: CGSize(width: Game.GetX(0.6), height: Game.GetY(0.3)))
        theripening_item.setup(0, y: teleport_item.frame.minY, size: 1.0, zPos: 1);
        theripening_item.loadItem(Game.textures.theripening(), invertedTexture: Game.textures.theripening_inverted(),
                                 title: "The Ripening", description: "Gives you a secound chance", cost: [3, 3, 2, 1])
        amount_label_array["theripening"] = theripening_item.getLabel();
        addChild(theripening_item);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getColour() {
        shoptitle.getColour();
        subtitle_abilities.getColour();
        tagline_abilities.getColour();
        
        topfruit_item.getColour();
        fruitadox_item.getColour();
        sweetfruit_item.getColour();
        fruitbowl_item.getColour();
        teleport_item.getColour();
        theripening_item.getColour();
    }
}