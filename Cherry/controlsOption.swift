//
//  controlsOption.swift
//  Cherry
//
//  Created by Luke Farrell on 11/08/2016.
//  Copyright © 2016 AppDev. All rights reserved.
//

import Foundation
import SpriteKit

class controlsOption : GameObject {
    var title_txt:TextObject = TextObject(fontNamed: "AvenirNext-Heavy");
    var tagline_txt:TextObject = TextObject(fontNamed: "AvenirNext-Bold");
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    func setupText(title_string:String, info_string:String){
        title_txt.setup(text: title_string, name: "title", x: 0, y: self.size.height/2.4, size: 80, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        tagline_txt.setup(text: info_string, name: "info", x: 0, y: -self.size.height/2.2, size: 38, color: SKColor.white, align: SKLabelHorizontalAlignmentMode.center, zPos: 1);
        
        self.addChild(title_txt);
        self.addChild(tagline_txt);

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
