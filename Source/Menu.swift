//
//  Menu.swift
//  Invader
//
//  Created by James Sobieski on 7/14/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

class Menu: CCSprite {
   
    func loadGameplay() {
        var gameplayScene = CCBReader.loadAsScene("Gameplay")
        CCDirector.sharedDirector().replaceScene(gameplayScene, withTransition: CCTransition(fadeWithColor: CCColor.greenColor(), duration: 0.5))
    }
}
