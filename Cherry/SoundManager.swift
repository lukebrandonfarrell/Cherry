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
        makeSound(str: "bouncyplatform");
        makeSound(str: "click");
        makeSound(str: "flash");
        makeSound(str: "crumble");
        makeSound(str: "die");
        makeSound(str: "jump");
        makeSound(str: "multiplejump");
        makeSound(str: "shoot");
        makeSound(str: "teleport");
        makeSound(str: "pickup");
        makeSound(str: "cherry")
        makeSound(str: "banana");
        makeSound(str: "pineapple");
        makeSound(str: "grape");
    }
    
    func makeSound(str:String){
        let sound = NSURL(fileURLWithPath: Bundle.main.path(forResource: str, ofType: "mp3")!)
        
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: sound as URL)
            audioPlayer.prepareToPlay();
            sounds[str] = audioPlayer;
        } catch {
            //Error?
        }
    }

    func playSound(str:String){
        if(Game.soundFX && sounds[str] != nil){
            let qualityOfServiceClass = QOS_CLASS_BACKGROUND
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.sounds[str]?.play()
            }
        }
    }
}
