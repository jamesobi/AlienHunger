import Foundation

class MainScene: CCNode {
    weak var abductButton:CCButton!
    
    func loadGameplay() {
        var levelScene = CCBReader.loadAsScene("Gameplay")
        CCDirector.sharedDirector().replaceScene(levelScene, withTransition: CCTransition(fadeWithColor: CCColor.greenColor(), duration: 0.3))
    }
    
}
