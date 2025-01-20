//
//  levelmanager.swift
//  Cherry
//
//  Created by Luke Farrell on 05/06/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class LevelManager : GameObject {
    
    //LEVEL
    var level:Int = 0; //Current Level
    var MaxLevel:Int = 0; //The max level you have reached
    private var levelproperties:[[CGFloat]] = [[4, 5, 0.0030],
                                  [4, 5, 0.0031],
                                  [3, 5, 0.0031],
                                  [3, 4, 0.0031],
                                  [3, 4, 0.0032],
                                  [2, 3, 0.0032],
                                  [1, 3, 0.0033],
                                  [1, 3, 0.0034],
                                  [1, 2, 0.0035]];
    var scoreflags:[Int] = [15, 55, 120, 165, 210, 260, 350, 450];
    
    //TRIGGERS, Run level progression once
    var lasttrigger:Int = 0;
    var levelProgression:Bool = false;
    
    //Timers
    var blackColourChanges:Timer!;
    var saveColourChange:Timer!;
    
    private var changeColour:SKAction!;
    private var changeDuration:CGFloat = 12.0;
    
    var selectedscene:SKScene!;
    func detectScene(scene:SKScene){
        selectedscene = scene;
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func inView() {
        level = 0;
        levelProgression = false;
        lasttrigger = 0;

        changeColour = SKAction.colorize(with: UIColor(netHex: Game.bgColours[level + 1]), colorBlendFactor: 1.0, duration: 12.0);
        
        getColour();
        
        Game.GameOverBackgroundColor = 0xC91240;
    }
    
    override func outView(){
        if((blackColourChanges) != nil){ blackColourChanges.invalidate(); }
        if((saveColourChange) != nil){ saveColourChange.invalidate(); }
    }
    
    override func update() {
        //Level Progression
        if(level < scoreflags.count){
            if(Game.score >= scoreflags[level] && Game.score != lasttrigger){
                lasttrigger = Game.score;
                level += 1;
                levelProgression = false;
            }
        }
        
        if(!levelProgression){ //Only run the code below once
            levelProgression = true;
            
            for l in 1..<Game.bgColours.count {
                if level == l, let scene = selectedscene {
                    // Should game colours be inverted
                    Game.GameColour = Game.bgColours[level]
                    
                    let realcolour = UIColor(netHex: Game.GameColour)
                    if Game.bgColours[level] == 0xFFFFFF {
                        Game.GameInvertedColour = true
                        changeDuration = 2.0  // Turning black to white needs to be quick
                    } else {
                        Game.GameInvertedColour = false
                        changeDuration = 12.0
                    }
                    getColour()  // Change colour of elements if needed
                    
                    // Fade into new colour
                    changeColour = SKAction.colorize(with: realcolour,
                                                   colorBlendFactor: 1.0,
                                                   duration: Double(changeDuration))
                    scene.run(changeColour)
                    
                    // Change platform attributes (make game harder)
                    Game.platform_spawner.setPlatformAttr(min: Int(levelproperties[level][0]),
                                                        max: Int(levelproperties[level][1]),
                                                          speed: Game.GetY(value: levelproperties[level][2]))
                    
                    // Save our new colour
                    saveColourChange = Timer.scheduledTimer(timeInterval: Double(changeDuration),
                                                          target: self,
                                                          selector: #selector(LevelManager.saveBGColour),
                                                          userInfo: nil,
                                                          repeats: false)
                }
            }
            
           /* blackColourChanges = NSTimer.scheduledTimerWithTimeInterval(20.0, target: self, selector: #selector(gamescene.MenuIcons_Inverted), userInfo: nil, repeats: false);
            blackColourChanges.fire();
            Game.platform_spawner.Spawn(Game.GetX(0.25), y: 0, conspickup: true);
            Game.platform_spawner.Spawn(Game.GetX(0.5), y: 0, conspickup: true);
            Game.platform_spawner.Spawn(Game.GetX(0.75), y: 0, conspickup: true);*/
            
        }
    }
    
    @objc func saveBGColour(){ //Each time we get to a level save that background colour and our MaxLevel
        if(level > MaxLevel){
            MaxLevel = level;
            Game.saveGame.saveInteger(data: level, key: Game.saveGame.keyMaxLevel);
        }
        Game.GameOverBackgroundColor = Game.bgColours[level];
    }

    
    func pause(){
        changeColour.speed = 0;
        if((saveColourChange) != nil){ saveColourChange.pause(); }
    }
    
    func resume(){
        changeColour.speed = 1.0;
        if((saveColourChange) != nil){ saveColourChange.resume(); }
    }
    
    func getColour(){
        Game.player.getColour();
        Game.powerup_bar.getColour();
    }
}
