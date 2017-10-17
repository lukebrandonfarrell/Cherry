//
//  FruitBar.swift
//  Cherry
//
//  Created by Luke Farrell on 06/06/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class FruitBar : GameObject {
    //var fruitbag : GameObject = GameObject(texture: Game.textures.bag());
    
    var cherry_icon : GameObject = GameObject(texture: Game.textures.cherry());
    var banana_icon : GameObject = GameObject(texture: Game.textures.banana());
    var pineapple_icon : GameObject = GameObject(texture: Game.textures.pineapple());
    var grape_icon : GameObject = GameObject(texture: Game.textures.grapes());
    
    var cherry_score : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    var banana_score : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    var pineapple_score : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    var grape_score : TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    
    var fruitbar_open:Bool = false;
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        var textsize:CGFloat = 100;
        if(UIDevice.currentDevice().isiPad()){
            textsize = 45;
        }
        
        cherry_score.setup("0", name: "cherry_score", x: 0, y: 0, size: textsize, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Right, zPos: 1);
        cherry_icon.setup(0,
                          y: cherry_score.frame.midY, size: 1.0,
                          zPos: 1);
        
        /*fruitbag.setup(0,
                        y: cherry_score.frame.midY, size: 1.2,
                          zPos: 6);
        fruitbag.name = "fruitbag";*/
        
        banana_score.setup("0", name: "banana_score", x: 0, y: 0, size: textsize, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Right, zPos: 1);
        banana_icon.setup(0,
                          y: banana_score.frame.midY, size: 1.0,
                          zPos: 1);
        
        pineapple_score.setup("0", name: "pineapple_score", x: 0, y: 0, size: textsize, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Right, zPos: 1);
        pineapple_icon.setup(0,
                             y: pineapple_score.frame.midY, size: 1.0,
                             zPos: 1);
        
        grape_score.setup("0", name: "grape_score", x: 0, y: 0, size: textsize, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Right, zPos: 1);
        grape_icon.setup(0,
                         y: grape_score.frame.midY, size: 1.0,
                         zPos: 1);
        
        //addChild(fruitbag);
        
        addChild(cherry_score)
        addChild(cherry_icon)
        
        addChild(banana_score)
        addChild(banana_icon)
        
        addChild(pineapple_score)
        addChild(pineapple_icon)
        
        addChild(grape_score)
        addChild(grape_icon)
        
        //updateFruitBar();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func inView() {
        getColour();
        alignFruitBar();
    }
    
    func getColour(){
        cherry_score.getColour();
        banana_score.getColour();
        pineapple_score.getColour();
        grape_score.getColour();
        
        cherry_icon.texture = Game.MenuInvertedColour ? Game.textures.cherry_Invert() : Game.textures.cherry();
        banana_icon.texture = Game.MenuInvertedColour ? Game.textures.banana_Invert() : Game.textures.banana();
        pineapple_icon.texture = Game.MenuInvertedColour ? Game.textures.pineapple_Invert() : Game.textures.pineapple();
        grape_icon.texture = Game.MenuInvertedColour ? Game.textures.grapes_Invert() : Game.textures.grapes();
        
        //fruitbag.texture = Game.MenuInvertedColour ?  Game.textures.bag_inverted() : Game.textures.bag();
    }
    
    func alignFruitBar(){
        cherry_score.text = String(Stats.cheriesCollected);
        banana_score.text = String(Stats.bananasCollected);
        pineapple_score.text = String(Stats.pineapplesCollected);
        grape_score.text = String(Stats.grapesCollected);
        
        cherry_score.position.x = 0;
        cherry_icon.position.x = cherry_score.frame.minX - cherry_icon.size.width/1.8;
        
        banana_score.position.x = cherry_icon.frame.minX - cherry_icon.size.width/3;
        banana_icon.position.x = banana_score.frame.minX - banana_icon.size.width/1.8;
        
        pineapple_score.position.x = banana_icon.frame.minX - banana_icon.size.width/3;
        pineapple_icon.position.x = pineapple_score.frame.minX - pineapple_icon.size.width/1.8
        
        grape_score.position.x = pineapple_icon.frame.minX - pineapple_icon.size.width/3
        grape_icon.position.x = grape_score.frame.minX - grape_icon.size.width/1.8
    }
    
    /*func updateFruitBar(){
        if(fruitbar_open){
            cherry_score.alpha = 1.0;
            cherry_icon.alpha = 1.0;
            
            banana_score.alpha = 1.0;
            banana_icon.alpha = 1.0;
            
            pineapple_score.alpha = 1.0;
            pineapple_icon.alpha = 1.0;
            
            grape_score.alpha = 1.0;
            grape_icon.alpha = 1.0;
            
            skull_text.alpha = 1.0;
            skull_stat.alpha = 1.0;
            
            hourglass_text.alpha = 1.0;
            hourglass_stat.alpha = 1.0;
            
            //fruitbag.alpha = 1.0;
        }else{
            cherry_score.alpha = 0;
            cherry_icon.alpha = 0;
            
            banana_score.alpha = 0;
            banana_icon.alpha = 0;
            
            pineapple_score.alpha = 0;
            pineapple_icon.alpha = 0;
            
            grape_score.alpha = 0;
            grape_icon.alpha = 0;
            
            skull_text.alpha = 0;
            skull_stat.alpha = 0;
            
            hourglass_text.alpha = 0;
            hourglass_stat.alpha = 0;
            
            //fruitbag.alpha = 0.4;
        }
    }
    
    func dismissFruitBar(){
        fruitbar_open = false;
        updateFruitBar();
    }*/
}