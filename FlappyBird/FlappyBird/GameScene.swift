//
//  GameScene.swift
//  FlappyBird
//
//  Created by Robert Skwiat on 8/16/15.
//  Copyright (c) 2015 Robert Skwiat. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var bird = SKSpriteNode()
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        var birdTextture = SKTexture(imageNamed: "img/flappy1.png")
        var birdTexture2 = SKTexture(imageNamed: "img/flappy2.png")
        
        var animation = SKAction.animateWithTextures([birdTextture, birdTexture2], timePerFrame: 0.1)
        
        var makeBirdFlap = SKAction.repeatActionForever(animation)
        
        bird = SKSpriteNode(texture: birdTextture)
        bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        bird.runAction(makeBirdFlap)
        
        self.addChild(bird)

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
