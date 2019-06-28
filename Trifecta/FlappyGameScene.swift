//
//  GameScene.swift
//  Trifecta
//
//  Created by Mike Dix on 4/28/19.
//  Copyright © 2019 Mike Dix. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

struct physicsCatagory {
    static let Ghost : UInt32 = 0x1 << 1
    static let Ground : UInt32 = 0x1 << 2
    static let Wall : UInt32 = 0x1 << 3

}

class FlappyGameScene: SKScene {
    
    var Ground = SKSpriteNode()
    var Ghost = SKSpriteNode()
    var wallPair = SKNode()
    var moveAndRemove = SKAction()
    var gameStarted = Bool()
    
    override func didMove(to view: SKView) {
        /* Setup scene here  */
        
        Ground = SKSpriteNode(imageNamed: "Ground")
        Ground.setScale(0.5)
        Ground.position = CGPoint(x: self.frame.width / 2, y: 0 + Ground.frame.height / 2)
        
        Ground.physicsBody = SKPhysicsBody(rectangleOf: Ground.size)
        Ground.physicsBody?.categoryBitMask = physicsCatagory.Ground
        Ground.physicsBody?.collisionBitMask = physicsCatagory.Ghost
        Ground.physicsBody?.contactTestBitMask = physicsCatagory.Ghost
        
        Ground.physicsBody?.affectedByGravity = false
        Ground.physicsBody?.isDynamic = false
        
        Ground.zPosition = 3
        
        
        self.addChild(Ground)
        
        Ghost = SKSpriteNode(imageNamed: "Ghost")
        Ghost.size = CGSize(width: 60, height: 70)
        Ghost.position = CGPoint(x: self.frame.width / 2 - Ghost.frame.width, y: self.frame.height / 2)
        
        Ghost.physicsBody = SKPhysicsBody(circleOfRadius: Ghost.frame.height / 2)
        Ghost.physicsBody?.categoryBitMask = physicsCatagory.Ghost
        Ghost.physicsBody?.collisionBitMask = physicsCatagory.Ground | physicsCatagory.Wall
        Ghost.physicsBody?.contactTestBitMask = physicsCatagory.Ground | physicsCatagory.Wall
        Ghost.physicsBody?.affectedByGravity = true
        Ghost.physicsBody?.isDynamic = true
        
        Ghost.zPosition = 2
        self.addChild(Ghost)

        let spawn = SKAction.run({
    }
    
    
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if gameStarted == false {
            let spawn = SKAction.run({
                ()in
                self.createWalls()
            })
        
        let delay = SKAction.wait(forDuration: 2.0)
        let SpawnDelay = SKAction.sequence([spawn, delay])
        let spawnDelayForever = SKAction.repeatForever(SpawnDelay)
        self.run(spawnDelayForever)
        
        let distance = CGFloat(self.frame.width + wallPair.frame.width)
        let movePipes = SKAction.moveBy(x: -distance, y: 0, duration: TimeInterval(0.01 * distance))
        let removePipes = SKAction.removeFromParent()
        moveAndRemove = SKAction.sequence([movePipes, removePipes])
        
        Ghost.physicsBody?.velocity = CGVector(dx:0, dy:0)
        Ghost.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 90))
        
        } else {
            
            self.Ghost.physicsBody?.velocity = CGVector(dx:0, dy:0)
            self.Ghost.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 90))
        }
    
    }

    
    func createWalls() {
        
        wallPair = SKNode()
        
        let topWall = SKSpriteNode(imageNamed: "Wall")
        let bottomWall = SKSpriteNode(imageNamed: "Wall")
        
        topWall.position = CGPoint(x: self.frame.width, y: self.frame.height / 2 + 350)
        bottomWall.position = CGPoint(x: self.frame.width, y: self.frame.height / 2 - 350)
        
        topWall.setScale(0.5)
        bottomWall.setScale(0.5)
        
        topWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
        topWall.physicsBody?.categoryBitMask = physicsCatagory.Wall
        topWall.physicsBody?.collisionBitMask = physicsCatagory.Ghost
        topWall.physicsBody?.contactTestBitMask = physicsCatagory.Ghost
        topWall.physicsBody?.isDynamic = false
        topWall.physicsBody?.affectedByGravity = false
        
        bottomWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
        bottomWall.physicsBody?.categoryBitMask = physicsCatagory.Wall
        bottomWall.physicsBody?.collisionBitMask = physicsCatagory.Ghost
        bottomWall.physicsBody?.contactTestBitMask = physicsCatagory.Ghost
        bottomWall.physicsBody?.isDynamic = false
        bottomWall.physicsBody?.affectedByGravity = false
        bottomWall.zRotation = CGFloat(M_PI)
        
        wallPair.addChild(topWall)
        wallPair.addChild(bottomWall)
        wallPair.zPosition = 1

    }
    
        func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
        
    }
}
}
