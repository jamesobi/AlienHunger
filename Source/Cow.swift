//
//  Cow.swift
//  Invader
//
//  Created by James Sobieski on 7/13/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

class Cow: CCSprite {
    
    func abduct() {
        self.runAction(CCActionFadeOut(duration: 2))
        self.removeFromParent()
        //TODO: FIX FADE
    }
    
}
