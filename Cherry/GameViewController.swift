//
//  GameViewController.swift
//  Cherry
//
//  Created by Luke Farrell on 12/03/2016.
//  Copyright (c) 2016 AppDev. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit;

class GameViewController: UIViewController, EGCDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
            // Configure the view.
            Game.skView = self.view as! SKView
            //Game.skView.showsFPS = true
            //Game.skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            Game.skView.ignoresSiblingOrder = true
        
            Game.saveGame.getAllData(); //Loads all our saved data
        
            Game.scenes_mainmenu = mainmenu(size: view.bounds.size);
            Game.scenes_controls = controls(size: view.bounds.size);
        
                Game.scenes_highscores = highscore(size: view.bounds.size);
                Game.scenes_settings = settings(size: view.bounds.size);
                Game.scenes_about = about(size: view.bounds.size);
        
                Game.scenes_physicsroom = physicsroom(size: view.bounds.size);
                Game.scenes_shop = shop(size: view.bounds.size);
                Game.scenes_shop?.scaleMode = .AspectFill;
        
            Game.scenes_gamescene = gamescene(size: view.bounds.size);
            Game.scenes_gameover = gameover(size: view.bounds.size);

            /* Set the scale mode to scale to fit the window */
            Game.scenes_mainmenu!.scaleMode = .AspectFill
            Game.scenes_gamescene!.scaleMode = .AspectFill
            Game.scenes_gameover!.scaleMode = .AspectFill
            Game.scenes_settings!.scaleMode = .AspectFill
            Game.scenes_about!.scaleMode = .AspectFill
        
            if(!Game.controlsOFF){
                Game.skView.presentScene(Game.scenes_controls);
            }else{
                Game.skView.presentScene(Game.scenes_mainmenu);
            }
        
        //Game center
            EGC.sharedInstance(self)
            //EGC.debugMode = true;
            EGC.showLoginPage = true;
        
        //EGC.showGameCenterAuthentication();
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        EGC.delegate = self;
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        Game.hasRotated = true;
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return UIInterfaceOrientation.LandscapeLeft
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Landscape;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
