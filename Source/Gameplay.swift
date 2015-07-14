//
//  Gameplay.swift
//  Invader
//
//  Created by James Sobieski on 7/13/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

class Gameplay: CCScene {
    weak var mainCharacter:CCSprite!
    
    weak var cowNode:CCNode!
    weak var tileOne:CCNode!
    weak var tileTwo:CCNode!
    weak var tileThree:CCNode!
    weak var tileFour:CCNode!
    weak var tileFive:CCNode!
    weak var tileSix:CCNode!
    weak var tileSeven:CCNode!
    weak var tileEight:CCNode!
    weak var tileNine:CCNode!
    weak var myPhysicsBody:CCPhysicsNode!
    weak var scoreLabel:CCLabelTTF!
    weak var batteryBar:CCNodeColor!
    
    var slope = 0.0
    var moveX:CGFloat = 0.0
    var moveY:CGFloat = 0.0
    var cows:[Cow] = []
    var cowsAbducted = 0 {
        didSet {
            scoreLabel.string = "\(cowsAbducted)"
        }
    }
    var timeSinceStart = 1
    var tiles:[CCNode] = []
    var universalTarget:CGPoint!
    var distance:CGFloat = 0.0
    var mod:Int = 0
    var tileTimeSinceStart = 1
    var tileSlope:CGPoint = CGPoint(x: 0, y: 0)
    let tileScale:CGFloat = 30
    
    let aSpeed:CGFloat = 70
    
    func didLoadFromCCB(){
        tiles = [tileOne, tileTwo, tileThree, tileFour, tileFive, tileSix, tileSeven, tileEight, tileNine]
        
        userInteractionEnabled = true
        
        var testCow = CCBReader.load("Cow") as! Cow
        testCow.position = ccp(100, 100)
        testCow.scale = 1
        
        cows.append(testCow)
        cowNode.addChild(testCow)
        myPhysicsBody.debugDraw = true
    }
    
    override func update(delta: CCTime) {
        println(timeSinceStart)
        var i = 0
        if universalTarget != nil {
            if tileTimeSinceStart % mod == 0 {
                for tile in tiles {
                    tile.position.x += tileSlope.x / tileScale
                    tile.position.y += tileSlope.y / tileScale
                    
                    if tile.position.x <= -568 {
                        tile.position.x = 1136
                    } else if tile.position.x > 1136 {
                        tile.position.x = -568
                    }
                    if tile.position.y <= -320 {
                        tile.position.y = 640
                    }else if tile.position.y > 640 {
                        tile.position.y = -320
                    }
                }
                for cow in cows {
                    cow.position.x += tileSlope.x / tileScale
                    cow.position.y += tileSlope.y / tileScale
                    
                    if cow.position.x <= -568 {
                        cow.position.x = 1136
                    } else if cow.position.x > 1136 {
                        cow.position.x = -568
                    }
                    if cow.position.y <= -320 {
                        cow.position.y = 640
                    }else if cow.position.y > 640 {
                        cow.position.y = -320
                    }
                }
            }
            
        }
        //var randomMod = Int(arc4random_uniform(100))
        
//        var randomAddition = Int(arc4random_uniform(20))
        var randomMod = 50
        if timeSinceStart % 3 == 0 {
            if batteryBar.scaleX > 0 {
                batteryBar.scaleX -= 0.005
            } else {
                triggerGameOver()
            }
        }
        if timeSinceStart % randomMod == 0 {
            spawnARandomCow()
            timeSinceStart = 1
            
        }
        
        while i < cows.count {
            
            if mainCharacter.boundingBox().contains(cows[i].boundingBox()) {
                println("FOUND DINNER!")
                cows[i].abduct()
                cows.removeAtIndex(i)
                cowsAbducted += 1
                
                i -= 1
            }
            
            i += 1
        }
        
        tileTimeSinceStart += 1
        timeSinceStart += 1
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        universalTarget = ccp(touch.locationInWorld().x, touch.locationInWorld().y)
        distance = sqrt( pow(universalTarget.x - mainCharacter.position.x, 2) + pow(universalTarget.y - mainCharacter.position.y, 2))
        mod = Int(distance / aSpeed) + 1
        tileSlope = CGPoint(x: -(universalTarget.x - mainCharacter.position.x), y: -(universalTarget.y - mainCharacter.position.y))
        
        //mainCharacter.runAction(CCActionMoveTo(duration: amountOfTime, position: touch.locationInWorld()))
        
    }
    
    func spawnARandomCow() {
        let maxHeight:Int = 640
        let maxWidth:Int = 1136
        let minHeight:Int = -320
        let minWidth:Int = -568
        var heightRange = UInt32(maxHeight - minHeight)
        var widthRange = UInt32(maxWidth - minHeight)
        
        var temporaryCow = CCBReader.load("Cow") as! Cow
        
        var randomHeight = CGFloat(arc4random_uniform(heightRange)) + CGFloat(minHeight)
        var randomWidth = CGFloat(arc4random_uniform(widthRange)) + CGFloat(minWidth)
        temporaryCow.position = ccp(randomWidth, randomHeight)
        
        cowNode.addChild(temporaryCow)
        cows.append(temporaryCow)
    }
    
    func triggerGameOver() {
        userInteractionEnabled = false
        universalTarget = mainCharacter.position
        var levelScene = CCBReader.loadAsScene("Menu")
        CCDirector.sharedDirector().replaceScene(levelScene, withTransition: CCTransition(fadeWithColor: CCColor.greenColor(), duration: 0.5))
    }
}
