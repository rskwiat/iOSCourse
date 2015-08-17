//
//  GameScene.swift
//  FlappyBird
//
//  Created by Robert Skwiat on 8/16/15.
//  Copyright (c) 2015 Robert Skwiat. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var score = 0
    var scoreLabel = SKLabelNode()
    var gameOverLabel = SKLabelNode()
    
    var bird = SKSpriteNode()
    var bg = SKSpriteNode()
    var labelHolder = SKSpriteNode()
   
    let birdGroup:UInt32 = 1
    let objectGroup:UInt32 = 2
    let gapGroup:UInt32 = 0 << 3
    
    var gameOver = 0
    var movingObjects = SKNode()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVectorMake(0, -5)
        
        self.addChild(movingObjects)
        self.addChild(labelHolder)
    
        scoreLabel.fontName = "Impact"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 70)
        scoreLabel.zPosition = 20
        self.addChild(scoreLabel)
        
        
        makeBackground()
        
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
        bird.zPosition = 10
        bird.physicsBody?.categoryBitMask = birdGroup
        bird.physicsBody?.collisionBitMask = objectGroup
        bird.physicsBody?.contactTestBitMask = objectGroup
        bird.physicsBody?.collisionBitMask = gapGroup
        
        bird.physicsBody?.allowsRotation = true
        
        self.addChild(bird)
        
        var ground = SKNode()
        ground.position = CGPointMake(0, 0)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, 1))
        ground.physicsBody?.dynamic = false
        ground.physicsBody?.categoryBitMask = objectGroup

        self.addChild(ground)
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: Selector("makePipes"), userInfo: nil, repeats: true)
        
    }
    
    func makeBackground(){
        
        var bgTexture = SKTexture(imageNamed: "img/bg.png")
        
        var movebg = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 9)
        var replacebg = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
        var movebgFoverer = SKAction.repeatActionForever(SKAction.sequence([movebg,replacebg]))
        
        for var i:CGFloat=0; i<3; i++ {
            
            bg = SKSpriteNode(texture: bgTexture)
            bg.position = CGPoint(x: bgTexture.size().width/2 + 900 * i, y: CGRectGetMidY(self.frame))
            bg.size.height = self.frame.height
            
            bg.runAction(movebgFoverer)
            
            movingObjects.addChild(bg)
            
        }
        
    }
    
    
    func makePipes(){
        
        let gapHeight = bird.size.height * 4

        var movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        var pipeOffset = CGFloat(movementAmount) - self.frame.size.height / 4
        
        var movePipes = SKAction.moveByX(-self.frame.size.width * 2, y: 0, duration: NSTimeInterval(self.frame.size.width / 100))
        var removePipes = SKAction.removeFromParent()
        
        var moveAndRemovePipes = SKAction.sequence([movePipes,removePipes])
        
        
        var pipeTexture = SKTexture(imageNamed: "img/pipe1.png")
        var pipe1 = SKSpriteNode(texture: pipeTexture)
        pipe1.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) + pipe1.size.height / 2 + gapHeight / 2  + pipeOffset)
        pipe1.runAction(moveAndRemovePipes)
        pipe1.physicsBody = SKPhysicsBody(rectangleOfSize: pipe1.size)
        pipe1.physicsBody?.dynamic = false
        pipe1.physicsBody?.categoryBitMask = objectGroup

        movingObjects.addChild(pipe1)
        
        var pipe2Texture = SKTexture(imageNamed: "img/pipe2.png")
        var pipe2 = SKSpriteNode(texture: pipe2Texture)
        pipe2.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) - pipe2.size.height / 2 - gapHeight / 2 + pipeOffset)
        pipe2.runAction(moveAndRemovePipes)
        pipe2.physicsBody = SKPhysicsBody(rectangleOfSize: pipe2.size)
        pipe2.physicsBody?.dynamic = false
        pipe2.physicsBody?.categoryBitMask = objectGroup
      
        movingObjects.addChild(pipe2)
        
        var gap = SKNode()
        gap.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) + pipeOffset)
        gap.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(pipe1.size.width, gapHeight))
        gap.runAction(moveAndRemovePipes)
        gap.physicsBody?.dynamic = false
        gap.physicsBody?.collisionBitMask = gapGroup
        gap.physicsBody?.categoryBitMask = gapGroup
        gap.physicsBody?.contactTestBitMask = birdGroup
        movingObjects.addChild(gap)
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == gapGroup || contact.bodyB.categoryBitMask == gapGroup {

            score++
            
            scoreLabel.text = "\(score)"
            
        } else {
            
            if gameOver == 0 {
                
                gameOver = 1
                
                movingObjects.speed = 0
                
                gameOverLabel.fontName = "Impact"
                gameOverLabel.fontSize = 30
                gameOverLabel.text = "Game Over! Tap to Play again!"
                gameOverLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
                gameOverLabel.zPosition = 20
                labelHolder.addChild(gameOverLabel)
                
            }

        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        if (gameOver == 0 ){
            
            bird.physicsBody?.velocity = CGVectorMake(0,0)
            bird.physicsBody?.applyImpulse(CGVectorMake(0,50))
            
        } else {
            
            score = 0;
            scoreLabel.text = "0"
            movingObjects.removeAllChildren()
            makeBackground()
            bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
            bird.physicsBody?.velocity = CGVectorMake(0,0)

            labelHolder.removeAllChildren()
            gameOver = 0
            movingObjects.speed = 1
            
            
        }
        

        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
