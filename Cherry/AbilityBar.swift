//
//  AbilityBar.swift
//  Cherry
//
//  Created by Luke Farrell on 28/05/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class AbilityBar : GameObject {
    let topfruit:GameObject = GameObject(texture: Game.textures.topfruit());
    let fruitadox:GameObject = GameObject(texture: Game.textures.fruitadox());
    let sweetfruit:GameObject = GameObject(texture: Game.textures.sweetfruit());
    let fruitbowl:GameObject = GameObject(texture: Game.textures.fruitbowl());
    let teleport:GameObject = GameObject(texture: Game.textures.teleport());
    let theripening:GameObject = GameObject(texture: Game.textures.theripening());
    
    let open_abilities:GameObject = GameObject(texture: Game.textures.open());
    
    let topfruit_amount:TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    let fruitadox_amount:TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    let sweetfruit_amount:TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    let fruitbowl_amount:TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    let teleport_amount:TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    let theripening_amount:TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    
    var abilityPositions:[CGPoint] = [];
    var orientation:Bool = true; //If true, ability bar sits on the left of the screen (Right handed play)
    
    var abilityBarOpen:Bool = false;
    
    //Opacities and animations
        var topfruit_visibility:CGFloat = 0.0;
        var fruitadox_visibility:CGFloat = 0.0;
        var sweetfruit_visibility:CGFloat = 0.0;
        var fruitbowl_visibility:CGFloat = 0.0;
        var teleport_visibility:CGFloat = 0.0;
        var theripening_visibility:CGFloat = 0.0;
    
        var ability_exsists:Bool = false;
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        topfruit.setup(0, y: 0, size: 1.0, zPos: 1);
        topfruit.name = "topfruit";
        topfruit.alpha = 0;
        addChild(topfruit);
        
        fruitadox.setup(0, y: 0, size: 1.0, zPos: 1);
        fruitadox.name = "fruitadox";
        fruitadox.alpha = 0;
        addChild(fruitadox);
        
        sweetfruit.setup(0, y: 0, size: 1.0, zPos: 1);
        sweetfruit.name = "sweetfruit";
        sweetfruit.alpha = 0;
        addChild(sweetfruit);
        
        fruitbowl.setup(0, y: 0, size: 1.0, zPos: 1);
        fruitbowl.name = "fruitbowl";
        fruitbowl.alpha = 0;
        addChild(fruitbowl);
        
        teleport.setup(0, y: 0, size: 1.0, zPos: 1);
        teleport.name = "teleport";
        teleport.alpha = 0;
        addChild(teleport);
        
        theripening.setup(0, y: 0, size: 1.0, zPos: 1);
        theripening.name = "theripening";
        theripening.alpha = 0;
        addChild(theripening);
        
        open_abilities.setup(0, y: 0, size: 1.0, zPos: 1);
        open_abilities.name = "open";
        addChild(open_abilities);
        
        //Ability possible screen positions
            var l_count:CGFloat = 0.0;
            for(var l=0; l<7; l += 1) {
                var ability_pos:CGPoint = CGPoint(x: 0, y: 0);
                
                //if(l % 2 == 1 || p == 0 || p == 1){
                ability_pos.x = 0;
                
                ability_pos.y = (topfruit.size.height * 1.25) * l_count;
                abilityPositions.append(ability_pos);
                
                if(l % 2 == 0 || l == 0){
                    l_count++;
                }
            }
        
        var textsize:CGFloat = 45;
        if(UIDevice.currentDevice().isiPad()){
            textsize = 100;
        }
        
        topfruit_amount.setup("0", name: "topfruit_amount", x: 0, y: 0, size: textsize, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Left, zPos: 1.0)
        topfruit_amount.alpha = 0;
        addChild(topfruit_amount);
        
        fruitadox_amount.setup("0", name: "fruitadox_amount", x: 0, y: 0, size: textsize, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Left, zPos: 1.0)
        fruitadox_amount.alpha = 0;
        addChild(fruitadox_amount);
        
        sweetfruit_amount.setup("0", name: "sweetfruit_amount", x: 0, y: 0, size: textsize, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Left, zPos: 1.0)
        sweetfruit_amount.alpha = 0;
        addChild(sweetfruit_amount);
        
        fruitbowl_amount.setup("0", name: "fruitbowl_amount", x: 0, y: 0, size: textsize, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Left, zPos: 1.0)
        fruitbowl_amount.alpha = 0;
        addChild(fruitbowl_amount);
        
        teleport_amount.setup("0", name: "teleport_amount", x: 0, y: 0, size: textsize, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Left, zPos: 1.0)
        teleport_amount.alpha = 0
        addChild(teleport_amount);
        
        theripening_amount.setup("0", name: "theripening_amount", x: 0, y: 0, size: textsize, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Left, zPos: 1.0)
        theripening_amount.alpha = 0;
        addChild(theripening_amount);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func inView() {
        loadSide();
        loadAbilities();
    }
    
    func loadAbilities(deactivate:String = ""){
        var avaliblePositions:[CGPoint] = abilityPositions;
        
        topfruit.texture = Game.GameInvertedColour ? Game.textures.topfruit_inverted() : Game.textures.topfruit();
        fruitadox.texture = Game.GameInvertedColour ? Game.textures.fruitadox_inverted() : Game.textures.fruitadox();
        sweetfruit.texture = Game.GameInvertedColour ? Game.textures.sweetfruit_inverted() : Game.textures.sweetfruit();
        fruitbowl.texture = Game.GameInvertedColour ? Game.textures.fruitbowl_inverted() : Game.textures.fruitbowl();
        teleport.texture = Game.GameInvertedColour ? Game.textures.teleport_inverted() : Game.textures.teleport();
        theripening.texture = Game.GameInvertedColour ? Game.textures.theripening_inverted() : Game.textures.theripening();
        open_abilities.texture = Game.GameInvertedColour ? Game.textures.open_inverted() : Game.textures.open();
        
        topfruit_amount.fontColor = Game.GameInvertedColour ? UIColor.blackColor() : UIColor.whiteColor();
        fruitadox_amount.fontColor = Game.GameInvertedColour ? UIColor.blackColor() : UIColor.whiteColor();
        sweetfruit_amount.fontColor = Game.GameInvertedColour ? UIColor.blackColor() : UIColor.whiteColor();
        fruitbowl_amount.fontColor = Game.GameInvertedColour ? UIColor.blackColor() : UIColor.whiteColor();
        teleport_amount.fontColor = Game.GameInvertedColour ? UIColor.blackColor() : UIColor.whiteColor();
        theripening_amount.fontColor = Game.GameInvertedColour ? UIColor.blackColor() : UIColor.whiteColor();
        
        //We add the open ability tool bar option, only if abilities have been purchased
            ability_exsists = false;
            for(_, ab) in Game.avalible_ablities {
                if(ab > 0){
                    ability_exsists = true;
                }
            }
            if(ability_exsists){
                open_abilities.position.y = avaliblePositions[0].y;
                avaliblePositions.removeFirst();
            }
        
        //topfruit
        if(Game.avalible_ablities["topfruit"] != nil)
        {
            if(Game.avalible_ablities["topfruit"] > 0){
                if(Game.topfruit_auto_active == 1 && deactivate != "topfruit"){
                    topfruit_visibility = 1.0;
                    Game.topfruit_active = true;
                    if(Game.top != nil){
                        Game.top.physicsBody?.categoryBitMask = PhysicsCategory.walls;
                    }
                }else{
                    topfruit_visibility = 0.4;
                    Game.topfruit_active = false;
                    Game.topfruit_auto_active = 0;
                }
                
                topfruit.position.y = avaliblePositions[0].y;
                topfruit.position.x = avaliblePositions[0].x;
                
                topfruit_amount.text = String(Game.avalible_ablities["topfruit"]!);
                topfruit_amount.horizontalAlignmentMode = orientation ? SKLabelHorizontalAlignmentMode.Left : SKLabelHorizontalAlignmentMode.Right;
                topfruit_amount.position.x = orientation ? topfruit.position.x + topfruit.size.width / 1.6 : topfruit.position.x - topfruit.size.width / 1.6;
                topfruit_amount.position.y = topfruit.frame.midY - 15;
 
                if(avaliblePositions[0].x == 0){ avaliblePositions[1].x = orientation ? topfruit.frame.maxX + topfruit.size.width * 1.25
                                                                                     : topfruit.frame.minX - topfruit.size.width * 1.25; }
                avaliblePositions.removeFirst();
            }else{
                topfruit_visibility = 0;
                Game.topfruit_active = false;
            }
        }
        
        //fruitadox
        if(Game.avalible_ablities["fruitadox"] != nil)
        {
            if(Game.avalible_ablities["fruitadox"] > 0){
                if(Game.fruitadox_auto_active == 1 && deactivate != "fruitadox"){
                    fruitadox_visibility = 1.0;
                    Game.fruitadox_active = true;
                }else{
                    fruitadox_visibility = 0.4;
                    Game.fruitadox_active = false;
                    Game.fruitadox_auto_active = 0;
                }
                
                fruitadox.position.y = avaliblePositions[0].y;
                fruitadox.position.x = avaliblePositions[0].x;
                
                fruitadox_amount.text = String(Game.avalible_ablities["fruitadox"]!);
                fruitadox_amount.horizontalAlignmentMode = orientation ? SKLabelHorizontalAlignmentMode.Left : SKLabelHorizontalAlignmentMode.Right;
                fruitadox_amount.position.x = orientation ? fruitadox.position.x + fruitadox.size.width / 1.6 : fruitadox.position.x - fruitadox.size.width / 1.6;
                fruitadox_amount.position.y = fruitadox.frame.midY - 15;

                if(avaliblePositions[0].x == 0){ avaliblePositions[1].x = orientation ? fruitadox.frame.maxX + fruitadox.size.width * 1.25
                                                                                     : fruitadox.frame.minX - fruitadox.size.width * 1.25; }
                avaliblePositions.removeFirst();
            }else{
                fruitadox_visibility = 0;
                Game.fruitadox_active = false;
            }
        }
        
        //sweetfruit
        if(Game.avalible_ablities["sweetfruit"] != nil)
        {
            if(Game.avalible_ablities["sweetfruit"] > 0){
                if(Game.sweetfruit_auto_active == 1 && deactivate != "sweetfruit"){
                    sweetfruit_visibility = 1.0;
                    Game.sweetfruit_active = true;
                }else{
                    sweetfruit_visibility = 0.4;
                    Game.sweetfruit_active = false;
                    Game.sweetfruit_auto_active = 0;
                }
                
                sweetfruit.position.y = avaliblePositions[0].y;
                sweetfruit.position.x = avaliblePositions[0].x;
                
                sweetfruit_amount.text = String(Game.avalible_ablities["sweetfruit"]!);
                sweetfruit_amount.horizontalAlignmentMode = orientation ? SKLabelHorizontalAlignmentMode.Left : SKLabelHorizontalAlignmentMode.Right;
                sweetfruit_amount.position.x = orientation ? sweetfruit.position.x + sweetfruit.size.width / 1.6 : sweetfruit.position.x - sweetfruit.size.width / 1.6;
                sweetfruit_amount.position.y = sweetfruit.frame.midY - 15;
                
                if(avaliblePositions[0].x == 0){ avaliblePositions[1].x = orientation ? sweetfruit.frame.maxX + sweetfruit.size.width * 1.25
                                                                                     : sweetfruit.frame.minX - sweetfruit.size.width * 1.25; }
                avaliblePositions.removeFirst();
            }else{
                sweetfruit_visibility = 0;
                Game.sweetfruit_active = false;
            }
        }
        
        //fruitbowl
        if(Game.avalible_ablities["fruitbowl"] != nil)
        {
            if(Game.avalible_ablities["fruitbowl"] > 0){
                if(Game.fruitbowl_auto_active == 1 && deactivate != "fruitbowl"){
                    fruitbowl_visibility = 1.0
                    Game.fruitbowl_active = true;
                }else{
                    fruitbowl_visibility = 0.4
                    Game.fruitbowl_active = false;
                    Game.fruitbowl_auto_active = 0;
                }
                
                fruitbowl.position.y = avaliblePositions[0].y;
                fruitbowl.position.x = avaliblePositions[0].x;
                
                fruitbowl_amount.text = String(Game.avalible_ablities["fruitbowl"]!);
                fruitbowl_amount.horizontalAlignmentMode = orientation ? SKLabelHorizontalAlignmentMode.Left : SKLabelHorizontalAlignmentMode.Right;
                fruitbowl_amount.position.x = orientation ? fruitbowl.position.x + fruitbowl.size.width / 1.6 : fruitbowl.position.x - fruitbowl.size.width / 1.6;
                fruitbowl_amount.position.y = fruitbowl.frame.midY - 15;
                
                if(avaliblePositions[0].x == 0){ avaliblePositions[1].x = orientation ? fruitbowl.frame.maxX + fruitbowl.size.width * 1.25
                                                                                     : fruitbowl.frame.minX - fruitbowl.size.width * 1.25;  }
                avaliblePositions.removeFirst();
            }else{
                fruitbowl_visibility = 0
                Game.fruitbowl_active = false;
            }
        }
        
        //teleport
        if(Game.avalible_ablities["teleport"] != nil)
        {
            if(Game.avalible_ablities["teleport"] > 0){
                if(Game.teleport_auto_active == 1 && deactivate != "teleport"){
                    teleport_visibility = 1.0;
                    Game.teleport_active = true;
                }else{
                    teleport_visibility = 0.4
                    Game.teleport_active = false;
                    Game.teleport_auto_active = 0;
                }
                
                teleport.position.y = avaliblePositions[0].y;
                teleport.position.x = avaliblePositions[0].x;
                
                teleport_amount.text = String(Game.avalible_ablities["teleport"]!);
                teleport_amount.horizontalAlignmentMode = orientation ? SKLabelHorizontalAlignmentMode.Left : SKLabelHorizontalAlignmentMode.Right;
                teleport_amount.position.x = orientation ? teleport.position.x + teleport.size.width / 1.6 : teleport.position.x - teleport.size.width / 1.6;
                teleport_amount.position.y = teleport.frame.midY - 15;

                if(avaliblePositions[0].x == 0){ avaliblePositions[1].x = orientation ? teleport.frame.maxX + teleport.size.width * 1.25
                                                                                     : teleport.frame.minX - teleport.size.width * 1.25; }
                avaliblePositions.removeFirst();
            }else{
                teleport_visibility = 0;
                Game.teleport_active = false;
            }
        }
        
        //theripening
        if(Game.avalible_ablities["theripening"] != nil)
        {
            if(Game.avalible_ablities["theripening"] > 0){
                if(Game.theripening_auto_active == 1 && deactivate != "theripening"){
                    theripening_visibility = 1.0
                    Game.theripening_active = true;
                }else{
                    theripening_visibility = 0.4
                    Game.theripening_active = false;
                    Game.theripening_auto_active = 0;
                }
                
                theripening.position.y = avaliblePositions[0].y;
                theripening.position.x = avaliblePositions[0].x;
                
                theripening_amount.text = String(Game.avalible_ablities["theripening"]!);
                theripening_amount.horizontalAlignmentMode = orientation ? SKLabelHorizontalAlignmentMode.Left : SKLabelHorizontalAlignmentMode.Right;
                theripening_amount.position.x = orientation ? theripening.position.x + theripening.size.width / 1.6 : theripening.position.x - theripening.size.width / 1.6;
                theripening_amount.position.y = theripening.frame.midY - 15;
                
                //if(avaliblePositions[0].x == 0){ avaliblePositions[1].x = theripening.frame.maxX + theripening.size.width * 1.4 } If we add more abilities
                avaliblePositions.removeFirst();
            }else{
                theripening_visibility = 0
                Game.theripening_active = false;
            }
        }
        
        updateAbilityBar();
    }
    
    func opencloseAbilities(){
        Game.soundManager.playSound("click");
        abilityBarOpen = !abilityBarOpen;
        loadAbilities();
    }
    
    func updateAbilityBar(){
        if(abilityBarOpen){
            open_abilities.alpha = 1.0;
            
            topfruit.alpha = topfruit_visibility;
            topfruit_amount.alpha = topfruit_visibility;
            
            fruitadox.alpha = fruitadox_visibility;
            fruitadox_amount.alpha = fruitadox_visibility
            
            sweetfruit.alpha = sweetfruit_visibility
            sweetfruit_amount.alpha = sweetfruit_visibility
            
            fruitbowl.alpha = fruitbowl_visibility
            fruitbowl_amount.alpha = fruitbowl_visibility
            
            teleport.alpha = teleport_visibility
            teleport_amount.alpha = teleport_visibility
            
            theripening.alpha = theripening_visibility
            theripening_amount.alpha = theripening_visibility
        }else{
            open_abilities.alpha = 0.4;
            
            topfruit.alpha = 0;
            topfruit_amount.alpha = 0;
            
            fruitadox.alpha = 0;
            fruitadox_amount.alpha = 0
            
            sweetfruit.alpha = 0
            sweetfruit_amount.alpha = 0
            
            fruitbowl.alpha = 0
            fruitbowl_amount.alpha = 0
            
            teleport.alpha = 0
            teleport_amount.alpha = 0
            
            theripening.alpha = 0;
            theripening_amount.alpha = 0
        }
        
        if(!ability_exsists){
            open_abilities.alpha = 0;
        }
    }
    
    func dismissAbilityBar(){
        Game.soundManager.playSound("click");
        abilityBarOpen = false;
        updateAbilityBar();
    }
    
    func deactivateAbility(a:String){
        if(Game.avalible_ablities[a] != nil){
            if(Game.avalible_ablities[a]! > 0){
                Game.avalible_ablities[a]! -= 1;
            }
            loadAbilities(a);
            Game.saveGame.saveObject(Game.avalible_ablities, key: Game.saveGame.keyPurchasedAbilities)
        }
    }
    
    func loadSide(){
        if(orientation){
            self.position.x = Game.GetX(0.05);
        }else{
            self.position.x = Game.GetX(0.95);
        }
        
        loadAbilities();
    }
    
    func switchSides(){ //Left, Right
        orientation = !orientation;
        loadSide();
    }
}