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
    var bg = SKSpriteNode()
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        var bgTexture = SKTexture(imageNamed: "img/bg.png")
 
        var movebg = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 9)
        var replacebg = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
        var movebgFoverer = SKAction.repeatActionForever(SKAction.sequence([movebg,replacebg]))
        
        for var i:CGFloat=0; i<3; i++ {
            
            bg = SKSpriteNode(texture: bgTexture)
            bg.position = CGPoint(x: bgTexture.size().width/2 + 900 * i, y: CGRectGetMidY(self.frame))
            bg.size.height = self.frame.height
            
            bg.runAction(movebgFoverer)
            
            self.addChild(bg)
            
        }
        
        var birdTextture = SKTexture(imageNamed: "img/flappy1.png")
        var birdTexture2 = SKTexture(imageNamed: "img/flappy2.png")
        
        var animation = SKAction.animateWithTextures([birdTextture, birdTexture2], timePerFrame: 0.1)
        
        var makeBirdFlap = SKAction.repeatActionForever(animation)
        
        bird = SKSpriteNode(texture: birdTextture)
        bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        bird.runAction(makeBirdFlap)
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height / 2)
        bird.physicsBody?.dynamic = true
        bird.physicsBody?.allowsRotation = false
        
        
        self.addChild(bird)
        
        var ground = SKNode()
        ground.position = CGPointMake(0, 0)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, 1))
        ground.physicsBody?.dynamic = false
        
        self.addChild(ground)
        
        
        

        

    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        bird.physicsBody?.velocity = CGVectorMake(0,0)
        bird.physicsBody?.applyImpulse(CGVectorMake(0,50))
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
