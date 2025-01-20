//
//  shop.swift
//  Cherry
//
//  Created by Luke Farrell on 22/05/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class shop : cherrymenu {
    var back_btn : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    
    var tobuy : toBuy = toBuy(); //Are you sure you want to buy popup
    var shopitems:ShopItems = ShopItems();
    
    let currencyBG : ShapeObject = ShapeObject(); //We make this to stop the currency bar overlapping text when scrolling
    var BGPrevBarColour:ShapeObject!; //For BG swipe animation, shop bar addon
    var changebar:SKAction!; //seperate action for bar, its a waste performing the same things twice

    var scrollStartLoc:CGPoint!;
    var scrollEndLoc:CGPoint!;
    
    var selectedItem:String = "";
    
    override init(size: CGSize) {
        super.init(size: size);
        loadBackground();
        loadHint(); //If scene uses hints, load this
        
        currencyBG.path = UIBezierPath(rect: CGRect(x: Game.GetX(value: 0), y: Game.GetY(value: 0), width: size.width, height: Game.GetY(value: 0.15))).cgPath;
        currencyBG.lineWidth = 0.0;
        currencyBG.zPosition = 5;
        addChild(currencyBG);
        
        BGPrevBarColour = ShapeObject(rect: CGRect(x: 0, y: 0, width: Game.sceneWidth, height: Game.GetY(value: 0.15)));
        BGPrevBarColour.setup(x: -Game.sceneWidth, y: 0, size: 1.0, zPos: 5.5);
        BGPrevBarColour.lineWidth = 0.0;
        addChild(BGPrevBarColour);
        
        change = SKAction.run { () -> Void in
            self.BGPrevBarColour.alpha = 0.0;
        }
        
        Game.fruit_bar.setup(x: Game.GetX(value: 0.96), y: Game.GetY(value: 0.06), size: Game.GetX(value: 0.001), zPos: 6);
        addChild(Game.fruit_bar);
        
        back_btn.setup(text: "BACK", name: "back", x: Game.GetX(value: 0.04), y:  Game.GetY(value: 0.05), size: 60, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.left, zPos: 6);
        
        shopitems.position.y = Game.GetY(value: 0.8);
        shopitems.position.x = Game.GetX(value: 0.5);
        addChild(shopitems);
        
        addChild(tobuy)
        tobuy.setup(x: 0, y: 0, size: 1.0, zPos: 7);
        tobuy.backgroundshape.alpha = 0.7
        tobuy.alpha = 0;
        
        addChild(back_btn);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        updateItem(name: "topfruit")
        updateItem(name: "fruitadox")
        updateItem(name: "sweetfruit")
        updateItem(name: "fruitbowl")
        updateItem(name: "teleport")
        updateItem(name: "theripening")
        
        Game.fruit_bar.inView()
    }
    
    override func updateBackgroundColour() {
        super.updateBackgroundColour();
        
        BGPrevBarColour.alpha = 0;
        currencyBG.fillColor =  UIColor(netHex: Game.MenuBackgroundColor);
        
        Game.fruit_bar.getColour();
        shopitems.getColour();
        tobuy.getColour();
        back_btn.getColour();
    }
    
    var direction:CGFloat = 0;
    var shopmove:Bool = false;
    
    var shop_min_X:CGFloat = Game.GetY(value: 0.75);
    var shop_max_X:CGFloat = Game.GetY(value: 0.3) * 7.4;
    
    override func update(_ currentTime: TimeInterval) {
        if(shopmove){
            shopitems.position.y -= direction
            direction = direction * 0.95
            
            if((direction > 0 && shopitems.position.y < shop_min_X) || (direction < 0 && shopitems.position.y > shop_max_X)){
                direction = 0
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var node: SKNode = SKNode()
        if let touch = touches.first {
            let location = touch.location(in: self)
            node = self.atPoint(location)
            touchStartLoc = location //Variable we need for swipeable background
            scrollStartLoc = location
            
            if(node.name != nil){
                let name: String = node.name!
                //Shop Purchase
                var title: String = name
                if(title == "topfruit"){ title = "Top Fruit" }
                if(title == "fruitadox"){ title = "Fruitadox" }
                if(title == "sweetfruit"){ title = "Sweet Fruit" }
                if(title == "fruitbowl"){ title = "Fruit Bowl" }
                if(title == "teleport"){ title = "Teleport" }
                if(title == "theripening"){ title = "The Ripening" }
                
                if(name == "topfruit" ||
                    name == "fruitadox" ||
                    name == "sweetfruit" ||
                    name == "fruitbowl" ||
                    name == "teleport" ||
                    name == "theripening"){
                    tobuy.show(item: title)
                    selectedItem = name
                }
                
                if(name == "cancel_item"){
                    Game.soundManager.playSound(str: "click")
                    tobuy.close()
                }
                
                if(name == "buy_item"){
                    Game.soundManager.playSound(str: "pickup")
                    buyItem(name: selectedItem)
                    tobuy.close()
                }
                
                if(name == "fruitbag"){
                    Game.soundManager.playSound(str: "click")
                    Game.fruit_bar.fruitbar_open = !Game.fruit_bar.fruitbar_open
                    removeHint()
                }
                
                if(name == "back"){
                    Game.soundManager.playSound(str: "click")
                    Game.skView.presentScene(Game.scenes_mainmenu!,
                                         transition: SKTransition.fade(with: .black,
                                                                   duration: TimeInterval(Game.SceneFade)))
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            scrollEndLoc = location
            
            direction = (scrollStartLoc.y - scrollEndLoc.y)/18
            
            if((direction > 0 && shopitems.position.y > shop_min_X) || (direction < 0 && shopitems.position.y < shop_max_X)){
                shopmove = true
            }else{
                shopmove = false
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let checkBGselection: Int = BGselection //We can't insert code from this child into parent "touchended" conditionals, so instead we use a little hack like this
        super.touchesEnded(touches, with: event)
        
        if(BGselection == (checkBGselection + 1)){
            BGPrevBarColour.alpha = 1.0
            BGPrevBarColour.position.x = Game.sceneWidth * 2
            BGPrevBarColour.fillColor = UIColor(netHex: Game.bgColours[BGselection])
            BGPrevBarColour.run(SKAction.sequence(sequence_array), withKey: "slide")
        }else if(BGselection == (checkBGselection - 1)){
            BGPrevBarColour.alpha = 1.0
            BGPrevBarColour.position.x = -Game.sceneWidth
            BGPrevBarColour.fillColor = UIColor(netHex: Game.bgColours[BGselection])
            BGPrevBarColour.run(SKAction.sequence(sequence_array), withKey: "slide")
        }
    }
    
    func buyItem(name : String){
        if(shopitems.amount_label_array[name] != nil){
            if(canPurchase(name: name)){
                var currentamount:Int = Int(shopitems.amount_label_array[name]!.text!)!
                
                if(currentamount < 9){
                    Game.soundManager.playSound(str: "buyitem")
                    currentamount += 1
                    shopitems.amount_label_array[name]!.text = String(currentamount)
                    Game.avalible_ablities[name] = currentamount
                    
                    Game.saveGame.saveFruit()
                    UserDefaults.standard.set(Game.avalible_ablities, forKey: Game.saveGame.keyPurchasedAbilities)
                    UserDefaults.standard.synchronize()
                }else{
                    //You have the max amount of this ability
                    addHint(text: "The max is 9 of each ability", flash: false)
                    tobuy.close()
                }
            }
        }
    }
    func canPurchase(name : String) -> Bool {
        if(Game.ability_cost[name] != nil){
            var price:[Int] = Game.ability_cost[name]!;
            
            if(Stats.cheriesCollected >= price[0] &&
                Stats.bananasCollected >= price[1] &&
                Stats.pineapplesCollected >= price[2] &&
                Stats.grapesCollected >= price[3]){
                
                Stats.cheriesCollected -= price[0];
                Stats.bananasCollected -= price[1]
                Stats.pineapplesCollected -= price[2]
                Stats.grapesCollected -= price[3]
                
                Game.fruit_bar.alignFruitBar();
                
                return true;
            }else{
                //Dont have enough currency
                addHint(text: "You don't have enough fruit to buy this", flash: false);
                //Game.fruit_bar.dismissFruitBar();
                
                return false;
            }
        }else{
            return false;
        }
    }
    
    func updateItem(name : String){
        if(shopitems.amount_label_array[name] != nil && Game.avalible_ablities[name] != nil){
            shopitems.amount_label_array[name]!.text = String(Game.avalible_ablities[name]!);
        }
    }
}
