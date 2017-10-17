//
//  SoundManager.swift
//  Cherry
//
//  Created by Luke Farrell on 14/03/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import SpriteKit
import AVFoundation

class SoundManager {
    
    var sounds = [String : AVAudioPlayer]();
    
    func SetupSounds(){
        makeSound("bouncyplatform");
        makeSound("click");
        makeSound("flash");
        makeSound("crumble");
        makeSound("die");
        makeSound("jump");
        makeSound("multiplejump");
        makeSound("shoot");
        makeSound("teleport");
        makeSound("pickup");
        makeSound("cherry")
        makeSound("banana");
        makeSound("pineapple");
        makeSound("grape");
    }
    
    func makeSound(str:String){
        let sound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(str, ofType: "mp3")!)
        
        do {
            let audioPlayer = try AVAudioPlayer(contentsOfURL: sound)
            audioPlayer.prepareToPlay();
            sounds[str] = audioPlayer;
        } catch {
            //Error?
        }
    }

    func playSound(str:String){
        if(Game.soundFX && sounds[str] != nil){
            let qualityOfServiceClass = QOS_CLASS_BACKGROUND
            let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
            dispatch_async(backgroundQueue, {
                self.sounds[str]!.play();
            })
        }
    }
}