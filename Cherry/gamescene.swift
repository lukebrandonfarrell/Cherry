//
//  game.swift
//  Cherry
//
//  Created by Luke Farrell on 12/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class gamescene : cherryscene, SKPhysicsContactDelegate {
    
    var gameover:Bool = false;
    var resetSceneFlag:Bool = false;
    var gameovertimer:NSTimer!;
    
    var score_box:GameObject = GameObject(texture: Game.textures.scorebox());
    var score_label:TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    
    var pause_btn:GameObject = GameObject(texture: Game.textures.pausebtn());
    var pause_popup:Pause = Pause();
    
    var falltimer:NSTimer!; //Accumulate score when faliing at start of game
    var timeplayedtimer:NSTimer!;
    
    //Tutorial
    var tiltTutorial:TiltTutorial = TiltTutorial();
    var touchTutorial:TouchTutorial = TouchTutorial();
    
    //Waiting for player to respawn
    var waitingForRespawn:Bool = false;
    
    //Touch shadows
    var left_shadow:ShapeObject!;
    var right_shadow:ShapeObject!;
    var mid_shadow:ShapeObject!;
    
    override init(size: CGSize) {
        super.init(size: size);
        loadHint(); //If scene uses hints, load this
        
        Game.platform_spawner.detectScene(self);
        Game.levelmanager.detectScene(self);
        
        physicsWorld.contactDelegate = self
        
        Game.player = Player(circleOfRadius: Game.GetX(0.01));
        
        score_box.setup(Game.GetX(0.84), y: Game.GetY(0.92), size: Game.GetX(0.0005), zPos: 1); addChild(score_box);
        
        score_label.setup(String(Game.score), name: "score", x: score_box.frame.midX, y: Game.GetY(0.90), size: 50, color: SKColor.whiteColor(), align: SKLabelHorizontalAlignmentMode.Center, zPos: 2);
        addChild(score_label);
        
        pause_btn.setup(Game.GetX(0.94), y: Game.GetY(0.92), size: Game.GetX(0.0005), zPos: 1); addChild(pause_btn);
        pause_btn.name = "pause";
        pause_btn.MakeHitBox("pause");
        
        Game.powerup_bar.setup(Game.GetX(0.05), y: Game.GetY(0.92), size: Game.GetX(0.0008), zPos: 1); addChild(Game.powerup_bar);
        Game.ability_bar.setup(Game.GetX(0.05), y: Game.GetY(0.08), size: Game.GetX(0.0012), zPos: 1); addChild(Game.ability_bar);
        
        //Object to detect top collision
        Game.top = GameObject(texture: nil, color: SKColor.whiteColor(), size: CGSize(width: Game.GetX(1.0), height: Game.GetY(0.1)))
        Game.top.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: Game.top.size.width, height: Game.top.size.height));
        Game.top.physicsBody?.categoryBitMask = PhysicsCategory.None;
        Game.top.physicsBody?.contactTestBitMask = PhysicsCategory.player;
        Game.top.physicsBody?.dynamic = false;
        
        Game.top.position.y = Game.GetY(1.0) + Game.top.size.height/2;
        Game.top.position.x = Game.GetX(0.5);
        
        addChild(Game.top);
        
        //Touch shadows
        left_shadow = ShapeObject(rect: CGRect(x: 0, y: 0, width: Game.sceneWidth / 4, height: Game.sceneHeight));
        left_shadow.fillColor = SKColor.blackColor();
        left_shadow.alpha = 0;
        left_shadow.lineWidth = 0.0;
        addChild(left_shadow);
        
        right_shadow = ShapeObject(rect: CGRect(x: Game.sceneWidth - (Game.sceneWidth / 4), y: 0, width: Game.sceneWidth / 4, height: Game.sceneHeight));
        right_shadow.fillColor = SKColor.blackColor();
        right_shadow.alpha = 0;
        right_shadow.lineWidth = 0.0;
        addChild(right_shadow);
        
        mid_shadow = ShapeObject(rect: CGRect(x: Game.sceneWidth / 4, y: 0, width: Game.sceneWidth / 2, height: Game.sceneHeight));
        mid_shadow.fillColor = SKColor.blackColor();
        mid_shadow.alpha = 0;
        mid_shadow.lineWidth = 0.0;
        addChild(mid_shadow);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) { resetScene(); };func resetScene(){
        if(!resetSceneFlag){
            resetSceneFlag = true;

            physicsWorld.gravity = CGVectorMake(0, Physics.gravity * Game.scale_value);
            self.physicsBody = Physics.walls ?
                SKPhysicsBody(edgeLoopFromRect: CGRect(x: 0, y: -50, width: Game.sceneWidth, height: Game.sceneHeight * 2)) : nil;
            self.physicsBody?.restitution = 1.0;
            
            backgroundColor = UIColor(netHex: 0xC91240);
            
            Game.autopause = 0;
            
            Game.gamescene_speed = 1.0;
            
            Game.score = 0;
            score_label.text = String(Game.score);
            
            Game.GameInvertedColour = false;
            Game.GameColour = 0xC91240;
            
            Game.powerup_bar.inView();
            Game.ability_bar.inView();
            Game.levelmanager.inView();
            Game.platform_spawner.inView();
            
            Game.score_multi = 1;
            physicsWorld.speed = 1.0;
            self.speed = 1.0;
            
            Game.player.setup(Game.XAlign_center, y: Game.sceneHeight, size: 1.0, zPos: 1)
            addChild(Game.player);
            Game.playerDead = false;
            Game.player.inView();
            //Game.avalible_ablities["theripening"] = 999;
            
            falltimer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(gamescene.fallScore), userInfo: nil, repeats: true);
            timeplayedtimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(gamescene.addTimePlayed), userInfo: nil, repeats: true);
            
            gameover = false
            pause_popup.inView();
            
            if(Game.gamepaused){
                Game.gamepaused = false;
                Game.scenes_gamescene!.physicsWorld.speed = 1.0;
                pause_popup.removeFromParent();
            }
            
            mid_shadow.alpha = 0;
        }
    }
    func addTimePlayed(){ Stats.timePlayed += 1; }
    
    func didMoveOutOfView(){
        Game.levelmanager.outView();
        
        var scoreSet:Bool = false;
        var tempScore:Int = Game.score;
        
        //Check if highscore is higher than one of the current highscores
        for(var n=0; n<Game.highscore.count; n += 1){
            if(!scoreSet){
                if(tempScore > Game.highscore[n]){
                    let moveScoreDown:Int = Game.highscore[n]; //We set the score again so all the current scores also get pushed down one place
                    Game.highscore[n] = tempScore;
                    tempScore = moveScoreDown;
                }
            }
        }
        scoreSet = true;
        
        //Store last score for marker feature
        Game.platform_spawner.lastscore = Game.score;
        
        //Add score to global leaderbard
        if EGC.isPlayerIdentified {
            EGC.reportScoreLeaderboard(leaderboardIdentifier: "cherry.highscores", score: Game.score);
        }
        
        //Save game / progress after gameover
        Game.saveGame.saveEndGameData();
        
        if((Game.platform_spawner.platformtimer) != nil){ Game.platform_spawner.stopTimer(); }
        if((falltimer) != nil){ falltimer.invalidate(); }
        if(timeplayedtimer != nil){timeplayedtimer.invalidate();}
        self.removeAllActions();
    }

    override func update(currentTime: NSTimeInterval) {
        if(Game.autopause == 1 && !Game.gamepaused){
            PauseGame(pause_popup);
            Game.autopause = 2;
        }
        
        if(!Game.gamepaused){
            Game.platform_spawner.update();
            Game.player.update();
            Game.powerup_bar.update();
            Game.levelmanager.update();
            
            score_label.text = String(Game.score);
            
            if(!gameover){
                //Kill player if falls of screen or touches top
                if(Game.player.FirstContact && (Game.player.position.y < 0 || Game.player.position.y > Game.sceneHeight)){
                    gameover = true;
                    Game.playerDead = true;
                    resetSceneFlag = false;
                    CircleExplode(self, x: Game.player.position.x, y: Game.player.position.y);
                    Game.player.Die();
                    
                    if(Game.theripening_active){ //Player has instant respawn ability
                        respawnPlayer();
                        addHint("Touch anywhere on the screen to respawn at location");
                    }else{
                        gameovertimer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(gamescene.GameOver), userInfo: nil, repeats: false);
                    }
                }
                
                if(Game.player.position.x < 0){
                    Game.player.position.x = Game.sceneWidth;
                }else if(Game.player.position.x > Game.sceneWidth){
                    Game.player.position.x = 0;
                }
                
                //Calculate if the player is jumping or falling
                if(!Game.player.canJump){
                    if(Game.player.playerFallFromPosition > Game.player.position.y){
                        Game.player.isJumping = false;
                    }
                }
            }
            if(Game.GameColour == 0x000000){ //Gamr Colour us black
                score_box.texture = Game.textures.scorebox_Inverted();
                pause_btn.texture = Game.textures.pausebtn_Inverted();
            }else{
                score_box.texture = Game.textures.scorebox();
                pause_btn.texture = Game.textures.pausebtn();
            }
            hint.fontColor = Game.GameInvertedColour ? SKColor.blackColor() : SKColor.whiteColor();
            score_label.fontColor = Game.GameInvertedColour ? SKColor.blackColor() : SKColor.whiteColor();
        }
    }
    
    func CircleExplode(target:SKNode, x:CGFloat, y:CGFloat){
        let circledie_effect:NSString = Game.GameInvertedColour ? NSBundle.mainBundle().pathForResource("circle_explode_Inverted", ofType: "sks")! : NSBundle.mainBundle().pathForResource("circle_explode", ofType: "sks")!
        let circledie_emmiter = NSKeyedUnarchiver.unarchiveObjectWithFile(circledie_effect as String) as! SKEmitterNode
        
        circledie_emmiter.position = CGPointMake(x, y)
        circledie_emmiter.zPosition = 1
        circledie_emmiter.targetNode = target
        
        self.addChild(circledie_emmiter)
        Game.soundManager.playSound("die");
        Stats.numberOfDeaths += 1;
    }
    
    func GameOver(){
        didMoveOutOfView();
        if(!Game.autoplayON){
            Game.skView.presentScene(Game.scenes_gameover!, transition: SKTransition.fadeWithColor(UIColor.blackColor(), duration: NSTimeInterval(1.0)));
        }else{
            resetScene();
        }
        if((gameovertimer) != nil){ gameovertimer.invalidate(); }
    }
    
    func respawnPlayer(){ //This is our instant respawn which ties with the ability
        waitingForRespawn = true;
    }
    
    func fallScore(){
        //Add Score
        if(!Game.player.FirstContact && !Game.gamepaused){
            Game.score += 1;
        }else{
            if((falltimer) != nil){ falltimer.invalidate(); }
        }
    }
    
    var fruitbowltimer:NSTimer?;
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var node:SKNode = SKNode();
        if let touch = touches.first {
            let location = touch.locationInNode(self);
            node = self.nodeAtPoint(location);
            
            if(!Game.playerDead && node.name != nil)
            {
                let name:String = node.name!;
                
                //Open ability bar
                if(name == "open"){
                    Game.ability_bar.opencloseAbilities();
                }
                
                if(name == "topfruit")
                {
                    if(Game.topfruit_auto_active == 0){
                        Game.topfruit_auto_active = 1;
                    }else{
                        Game.topfruit_auto_active = 0;
                    }
                    
                    Game.top.physicsBody?.categoryBitMask = PhysicsCategory.walls;
                }
                
                if(name == "fruitadox"){
                    if(Game.fruitadox_auto_active == 0){
                        Game.fruitadox_auto_active = 1;
                    }else{
                        Game.fruitbowl_auto_active = 0;
                    }
                }
                
                if(name == "sweetfruit"){
                    if(Game.sweetfruit_auto_active == 0){
                        Game.sweetfruit_auto_active = 1;
                    }else{
                        Game.sweetfruit_auto_active = 0;
                    }
                }
                
                if(name == "fruitbowl"){
                    if(Game.fruitbowl_auto_active == 0){
                        Game.fruitbowl_auto_active = 1;
                    }
                    if(fruitbowltimer == nil){
                        Game.player.powerupField.categoryBitMask = PhysicsCategory.magnetic_player;
                        fruitbowltimer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: #selector(gamescene.removePlayerMagneticField), userInfo: nil, repeats: false);
                    }else{
                        //Fruit Bowl already active
                    }
                }
                
                if(name == "teleport"){
                    if(Game.teleport_auto_active == 0){
                        Game.teleport_auto_active = 1;
                        addHint("Touch anywhere on the screen to teleport to location");
                    }else{
                        Game.teleport_auto_active = 0;
                        removeHint();
                    }
                }
                
                if(name == "theripening"){
                    if(Game.theripening_auto_active == 0){
                        Game.theripening_auto_active = 1;
                    }else{
                        Game.theripening_auto_active = 0;
                    }
                }
                
                //Only load if abiliy is pressed
                if(name == "topfruit" || name == "fruitadox" || name == "sweetfruit" || name == "fruitbowl" || name == "teleport" || name == "theripening"){
                    Game.ability_bar.loadAbilities();
                }
                
            }else if(!Game.playerDead){
                if(Game.teleport_active){
                    Game.ability_bar.deactivateAbility("teleport");
                    Game.player.teleport(location);
                    removeHint();
                }else{
                    if(!Game.gamepaused){
                        if(location.x < Game.sceneWidth / 4 && !Game.tiltmovement){
                            Game.player.screendirection = 1;
                            left_shadow.alpha = 0.08;
                        }else if(location.x > Game.sceneWidth - (Game.sceneWidth / 4) && !Game.tiltmovement){
                            Game.player.screendirection = 2;
                            right_shadow.alpha = 0.08;
                        }else{
                            if(!Game.tiltmovement && ((!Game.player.isJumping && !Game.player.isFalling) || Game.player.multipleJump > Game.player.JumpCount)){
                                mid_shadow.alpha = 0.08;
                                let triggerTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.2 * Double(NSEC_PER_SEC)))
                                dispatch_after(triggerTime, dispatch_get_main_queue(), { () -> Void in
                                    self.mid_shadow.alpha = 0;
                                });
                            }
                            Game.player.jump();
                        }
                    }
                }
            }else if(waitingForRespawn){
                waitingForRespawn = false;
                gameover = false;
                removeHint();
                
                Game.player.setup(0, y: 0, size: 1.0, zPos: 1)
                Game.player.inView();
                Game.player.teleport(location);
                addChild(Game.player);
                Game.playerDead = false;
                Game.player.FirstContact = true;
                
                Game.ability_bar.deactivateAbility("theripening");
            }
            
            if(node.name == "pause"){
                PauseGame(pause_popup);
                Game.soundManager.playSound("click");
            }
            
            if(node.name == "resume"){
                ResumeGame();
                Game.soundManager.playSound("click");
            }
            
            if(node.name == "soundfx"){
                if(Game.soundFX){
                    pause_popup.soundfx_btn.text = "SOUNDFX OFF";
                    Game.soundFX = false;
                }else{
                    pause_popup.soundfx_btn.text = "SOUNDFX ON";
                    Game.soundFX = true;
                }
                Game.soundManager.playSound("click");
                Game.saveGame.saveMenuData();
            }
            
            if(node.name == "autoplay"){
                if(Game.autoplayON){
                    pause_popup.autoresume_btn.text = "AUTOPLAY OFF";
                    Game.autoplayON = false;
                }else{
                    pause_popup.autoresume_btn.text = "AUTOPLAY ON";
                    Game.autoplayON = true;
                }
                Game.soundManager.playSound("click");
                Game.saveGame.saveMenuData();
            }
            
            if(node.name == "orientation"){
                Game.ability_bar.switchSides();
                
                if(Game.ability_bar.orientation){
                    pause_popup.righthanded_btn.text = "RIGHT HANDED";
                }else{
                    pause_popup.righthanded_btn.text = "LEFT HANDED";
                }
                Game.soundManager.playSound("click");
            }
            
            if(node.name == "quit"){
                Game.soundManager.playSound("click");
                if((gameovertimer) != nil){ gameovertimer.invalidate(); }
                if(!Game.playerDead){
                    resetSceneFlag = false;
                    didMoveOutOfView();
                    Game.player.Die();
                }
                Game.skView.presentScene(Game.scenes_mainmenu!, transition: SKTransition.fadeWithColor(UIColor.blackColor(), duration: NSTimeInterval(Game.SceneFade)));
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.locationInNode(self);
            
            if(!Game.tiltmovement){
                if((location.x < Game.sceneWidth / 4)){
                    left_shadow.alpha = 0;
                }else if(location.x > Game.sceneWidth - (Game.sceneWidth / 4)){
                    right_shadow.alpha = 0;
                }
                
                if(left_shadow.alpha == 0 && right_shadow.alpha == 0){  //Reset screen control movement
                    Game.player.screendirection = 0;
                }
            }
        }
    }
    
    func PauseGame(popup:GameObject){
        if(!Game.gamepaused){
            Game.gamepaused = true;
            
            physicsWorld.speed = 0;
            self.speed = 0; //SK Actions speed
            
            Game.platform_spawner.stopTimer();
            Game.levelmanager.pause();
            
            Game.currentPopup = popup;
            addChild(Game.currentPopup!);
        }
    }
    //Resume game form pause
    func ResumeGame(){
        Game.gamepaused = false;
        Game.tutorialON = false;
        
        physicsWorld.speed = Game.gamescene_speed;
        self.speed = 1.0; //Resume SKActions speed
        
        Game.platform_spawner.MakeTimer();
        Game.levelmanager.resume();
        
        Game.currentPopup!.removeFromParent();
        
        Game.autopause = 0;
    }
    
    //MISC
    func removePlayerMagneticField(){
        Game.ability_bar.deactivateAbility("fruitbowl");
        Game.player.powerupField.categoryBitMask = PhysicsCategory.None;
        if(fruitbowltimer != nil){
            fruitbowltimer?.invalidate();
            fruitbowltimer = nil;
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody : SKPhysicsBody;
        var secoundBody : SKPhysicsBody;
        
        if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
            firstBody = contact.bodyA;
            secoundBody = contact.bodyB;
        }else{
            firstBody = contact.bodyB;
            secoundBody = contact.bodyA;
        }
        
        if((firstBody.categoryBitMask == PhysicsCategory.player) && (secoundBody.categoryBitMask == PhysicsCategory.platform)){
            let node:Player = firstBody.node as! Player;
            node.canJump = true;
            node.isJumping = false;
            node.FirstContact = true;
            
            
            let platform:Platform = secoundBody.node as! Platform;
            platform.Touched();

            if(Game.tutorialON){
                if(Game.tiltmovement){
                    PauseGame(tiltTutorial);
                }else{
                    PauseGame(touchTutorial);
                }
            }
        }
        
        if((firstBody.categoryBitMask == PhysicsCategory.player) && (secoundBody.categoryBitMask == PhysicsCategory.pickup)){
            let node:Pickup = secoundBody.node as! Pickup;
            node.pickup();
        }
        
        //Top Fruit ability
        if((firstBody.categoryBitMask == PhysicsCategory.player) && (secoundBody.categoryBitMask == PhysicsCategory.walls)){
            if(Game.player.FirstContact){ //Don't count the player touching the top when game starts
                Game.top.physicsBody?.categoryBitMask = PhysicsCategory.None;
                Game.ability_bar.deactivateAbility("topfruit");
            }
        }
    }
}

struct PhysicsCategory {
    static let None:UInt32 = 0;
    static let All:UInt32 = UInt32.max;
    static let player:UInt32 = 1;
    static let platform:UInt32 = 2;
    static let pickup:UInt32 = 4;
    static let bullet:UInt32 = 8;
    static let walls:UInt32 = 16;
    static let magnetic_player:UInt32 = 32;
}