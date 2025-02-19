//
//  PlatformSpawner.swift
//  Cherry
//
//  Created by Luke Farrell on 12/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class PlatformSpawner: GameObject {
    
    //PLATFORM AND ROW
        var platformSize : CGSize = CGSize(width: Game.GetX(value: 0.1), height: Game.GetY(value: 0.025));
        var platforms_array:[Platform] = []; //Array of platforms, should this be a pool? Yes :)
        var platformtimer:Timer!; //Check if we need to spawn platforms yet?
        var platformTarget:Platform!; //We use this to spwan platforms at equal distance even if time is distorted
        
        var currentPlatformRow:Int = 0; //Count how many rows of platforms the player has passed
        var allPlatformRow:Int = 0; //Count how many rows of platforms have been made
    
    //PLATFORM VARIABLES
        var platformSpeed:CGFloat = 0.6; //Speed platforms
        
        var platformsMin:Int = 4; //Minumum amount of platforms to spawn
        var platformsMax:Int = 5; //Maximum amount of platforms to spwan
    
    //PICKUPS AND LINES ARRAY
        var pickup_array:[Pickup] = [];
    
        var scoreline_array:[ScoreLine] = [];
        var temphighscore:[Int]!; //We keep another version of highscores so we can manipulate the array
    
        var lastscore:Int = 0;
    
    //ELEMENT POSITIONING
        var xColums:[CGFloat] = [];
        var xColums_two:[CGFloat] = [];
        
        var yColums:[CGFloat] = [];
    
        //STOP TOO MANY GUN'S SPAWNING
        var gunexists:Bool = false;
    
        //POOLS
        //var platformpool:platform_pool = platform_pool();
    
    var selectedscene:SKScene!;
    func detectScene(scene:SKScene){
        selectedscene = scene;
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size);
        
        xColums.append(Game.GetX(value: 0.05));
        xColums.append(Game.GetX(value: 0.2));
        xColums.append(Game.GetX(value: 0.4));
        xColums.append(Game.GetX(value: 0.6));
        xColums.append(Game.GetX(value: 0.8));
        xColums.append(Game.GetX(value: 9.5));
        
        xColums_two.append(Game.GetX(value: 0.1));
        xColums_two.append(Game.GetX(value: 0.3));
        xColums_two.append(Game.GetX(value: 0.5));
        xColums_two.append(Game.GetX(value: 0.7));
        xColums_two.append(Game.GetX(value: 0.9));
        
        yColums.append(-Game.GetY(value: 0.1));
    }
    
    required init?(coder aDecoder: NSCoder) { 
        fatalError("init(coder:) has not been implemented")
    }
    
    override func inView() {
        //Rest platform attributes
        platformSpeed = Game.GetY(value: 0.0028);
        platformsMin = 4;
        platformsMax = 5;
        
        //Reset Counter
        currentPlatformRow = 0;
        allPlatformRow = 0;
        
        //Reset
        for platform in platforms_array {
            platform.removeFromParent()
        }
        platforms_array = []
        
        for pickup in pickup_array {
            pickup.removeFromParent()
        }
        pickup_array = []
        
        for scoreline in scoreline_array {
            scoreline.removeFromParent()
        }
        scoreline_array = []
        
        //Spot duplicate highscores so we only create one scoreline
        temphighscore = Game.highscore
        for i in 0..<temphighscore.count {
            for n in 0..<(temphighscore.count - 1) {
                if temphighscore[i] == temphighscore[n] && i != n {
                    temphighscore.remove(at: n)
                }
            }
        }
        
        //Make
        MakeTimer();
        
        //Spawn a new platform, start all over again :)
        spawnFirstPlatform();
    }
    
    override func update() {
        for (index, platform) in platforms_array.enumerated().reversed() {
            platform.update()
            
            if platform.position.y > Game.sceneHeight {
                platform.stop()
                platform.removeFromParent()
                platforms_array.remove(at: index)
            }
        }

        for pickup in pickup_array {
            pickup.update()
        }

        for scoreline in scoreline_array {
            scoreline.update()
        }
    }
    
    func stopTimer(){
        platformtimer.invalidate();
        
        for platform in platforms_array {
            platform.stop();
        }
    }
    
    func MakeTimer(){
        platformtimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(PlatformSpawner.timeSpawnGap), userInfo: nil, repeats: true);
        
        for platform in platforms_array {
            platform.start();
        }
    }
    
    func spawnFirstPlatform(){
        Spawn(x: Game.XAlign_center, y: Game.GetY(value: 0.3));
        allPlatformRow += 1;
        SpawnPlatforms(addY: Game.GetY(value: 0.2));
    }
    
    @objc func timeSpawnGap(){
        if(!Game.gamepaused){
            if(platformTarget.position.y > Game.GetY(value: 0.18)){
                SpawnPlatforms(addY: 0);
            }
        }
    }

    func SpawnPlatforms(addY:CGFloat){
        let ammount:Int = randRange(lower: platformsMin, upper: platformsMax);
        
        let pick_random_array:Bool = randomBool();
        var xColumsTemp:[CGFloat] = pick_random_array ? xColums : xColums_two;
        
        var lineyPos:CGFloat = 0;
        
        if(ammount > 1){
            gunexists = false; //Set this so guns only spawn one to row
        }else{
            gunexists = true; //Don't spawn gun if only one platform is avalible
        }
        
        let assignedPlatformRow = allPlatformRow;
        for _ in 0..<ammount {
            //X
            let xColumsRandomSelect:Int = randRange(lower: 0, upper: xColumsTemp.count - 1);
            let xPos:CGFloat = xColumsTemp[xColumsRandomSelect] + Calc.randomBetweenNumbers(firstNum: -Game.GetX(value: 0.004), secondNum: Game.GetX(value: 0.004));
            xColumsTemp.remove(at: xColumsRandomSelect);
            
            //Y
            let yColumsRandomSelect:Int = randRange(lower: 0, upper: yColums.count - 1);
            let yPos:CGFloat = yColums[yColumsRandomSelect];

            /* Chance to spawn pickup */
                let pickupchance:Double = drand48();
                var spawnpickup:Bool = false;
                
                if(pickupchance < 0.05){
                    spawnpickup = true;
                }
            /* */
            
            /* Chance to make platform special */
                let uniqueplatformchance:Double = drand48();
            /* */
            
            Spawn(x: xPos, y: yPos + addY, conspickup: spawnpickup, uniquePlatform: uniqueplatformchance, row: assignedPlatformRow);
            lineyPos = yPos;
        }
        
        let predicted_score:Int = Game.score + ((allPlatformRow - currentPlatformRow) * Game.score_multi);
        
         //High score bar
         for h in (0..<temphighscore.count).reversed() {
             if predicted_score >= temphighscore[h] && temphighscore[h] > 12 {
                if temphighscore[h] != lastscore {
                    SpawnScoreLine(y: lineyPos, linetext: "Highscore [\(h + 1)]");
                }
                
                temphighscore.remove(at: h)
             }
         }
        
        if(predicted_score >= lastscore && lastscore > 12){
            SpawnScoreLine(y: lineyPos, linetext:  "Last score : " + String(lastscore));
            lastscore = 0;
        }
        
        allPlatformRow += 1;
    }
    
    func Spawn(x:CGFloat, y:CGFloat, conspickup:Bool = false, uniquePlatform:Double = 1.0, row:Int = 0){
        var platform:Platform!;
        var pickup:Bool = conspickup;
        
        if((uniquePlatform < 0.25 && uniquePlatform > 0.15) && Game.levelmanager.level >= 1){
            platform = platform_bouncy(color: UIColor.white, size: platformSize);
            pickup = false;
        }else if((uniquePlatform < 0.15 && uniquePlatform > 0.07) && Game.levelmanager.level >= 2){
            platform = platform_crumble(color: UIColor.white, size: platformSize);
        }else if((uniquePlatform < 0.07 && uniquePlatform > 0 ) && Game.levelmanager.level >= 4 && (allPlatformRow % 2) == 0 && !gunexists){
            gunexists = true;
            platform = gun();
            pickup = false;
        }else{
            platform = Platform(color: UIColor.white, size: platformSize);
        }
        
        platform.row = allPlatformRow;
        
        if(Game.GameInvertedColour){platform.color = UIColor.black}
        platform.setup(x: x, y: y, size: 1.0, zPos: 1)
        
        if(platform.frame.minX  < 0){
            platform.position.x = platform.size.width/2;
        }else if(platform.frame.maxX  > Game.sceneWidth){
            platform.position.x = (Game.sceneWidth - platform.size.width/2);
        }
        
        selectedscene.addChild(platform);
        platforms_array.append(platform);
        platform.start(); //This is mainly added for platforms which have their own timers
        
        if(pickup){
            var pickupchoice:[Pickup] = [];
            
            let cherry:Cherry = Game.GameInvertedColour ? Cherry(imageNamed: "cherry_Invert") : Cherry(imageNamed: "cherry");
            let banana:Banana = Game.GameInvertedColour ? Banana(imageNamed: "banana_Invert") : Banana(imageNamed: "banana");
            let grapes:Grapes = Game.GameInvertedColour ? Grapes(imageNamed: "grapes_Invert") : Grapes(imageNamed: "grapes");
            let pineapple:Pineapple = Game.GameInvertedColour ? Pineapple(imageNamed: "pineapple_Invert") : Pineapple(imageNamed: "pineapple");
            
            cherry.setup(x: 0, y: 0, size: Game.GetX(value: 0.001), zPos: 1);
            banana.setup(x: 0, y: 0, size: Game.GetX(value: 0.001), zPos: 1);
            grapes.setup(x: 0, y: 0, size: Game.GetX(value: 0.001), zPos: 1);
            pineapple.setup(x: 0, y: 0, size: Game.GetX(value: 0.001), zPos: 1);
            
            cherry.position.x = platform.frame.midX;
            banana.position.x = platform.frame.midX;
            grapes.position.x = platform.frame.midX;
            pineapple.position.x = platform.frame.midX;
            
            cherry.position.y = platform.frame.maxY;
            banana.position.y = platform.frame.maxY;
            grapes.position.y = platform.frame.maxY;
            pineapple.position.y = platform.frame.maxY;
            
            pickupchoice.append(cherry);
            if(Game.levelmanager.level >= 1){pickupchoice.append(banana);}
            if(Game.levelmanager.level >= 3){pickupchoice.append(pineapple);}
            if(Game.levelmanager.level >= 5){pickupchoice.append(grapes);}
            
            let randomchoice:Int = randRange(lower: 0, upper: pickupchoice.count - 1);
            
            let pickupobject:Pickup = pickupchoice[randomchoice];
            pickupobject.position.y = pickupobject.position.y + pickupobject.size.height / 1.8;
            selectedscene.addChild(pickupobject);

            pickup_array.append(pickupobject);
        }
        
        platformTarget = platform;
    }
    
    func SpawnScoreLine(y : CGFloat, linetext:String){
        let scoreline:ScoreLine = ScoreLine();
        scoreline.addText(text: linetext);
        scoreline.position.y = y - Game.GetY(value: 0.15);
        selectedscene.addChild(scoreline);
        scoreline_array.append(scoreline);
    }
    
    func setPlatformAttr(min:Int, max:Int, speed:CGFloat){ //Function which lets us set min platforms, max platforms and speed of platforms
        platformsMin = min;
        platformsMax = max;
        platformSpeed = speed;
    }
    
    func randRange (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
    func randomBool() -> Bool {
        return arc4random_uniform(2) == 0 ? true: false
    }
}
