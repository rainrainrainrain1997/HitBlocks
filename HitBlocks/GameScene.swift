//
//  GameScene.swift
//  HitBlocks
//
//  Created by rain on 2019/2/20.
//  Copyright © 2019年 rain. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    enum GameStatus {
        case idle
        case running
        case over
    }
    
    var gameStatus: GameStatus = .idle
    
    var bar: SKSpriteNode!
    var ball: SKSpriteNode!
  
    override func didMove(to view: SKView) {
        self.backgroundColor =  SKColor(red: 1, green: 1, blue:1, alpha: 0)
        self.physicsBody  = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        self.physicsWorld.contactDelegate = self
        
        //bar
        bar = SKSpriteNode(imageNamed: "bar")
        bar.position = CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.3)
        bar.physicsBody = SKPhysicsBody(rectangleOf: bar.size)
        bar.physicsBody?.allowsRotation = false
//        bar.physicsBody?.isDynamic = false
        self.addChild(bar)
        
        ball = SKSpriteNode(imageNamed: "ball")
        ball.position = CGPoint(x: self.frame.size.width * 0.5 , y: self.frame.size.height * 0.3 + ball.size.height/2)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.isDynamic = true
        
        self.addChild(ball)
    }
    
    
    func startGame(){
        gameStatus = .running
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        // 施加一个均匀作用于物理体的推力
        ball.physicsBody?.mass = 0.1
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.angularDamping = 0
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.applyImpulse(CGVector(dx: 100, dy: 100))
    }
    
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch gameStatus {
        case .idle:
            startGame()
        default:
            return
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        for t in touches{
            let position = t.location(in: self)
            let prevPosition = t.previousLocation(in: self)
            let offset = position.x - prevPosition.x
            bar.position.x += offset
            //防止运动太快超出边界
            if(bar.position.x > (self.frame.size.width - bar.size.width/2)){
                bar.position.x = self.frame.size.width - bar.size.width/2
            }else if(bar.position.x < bar.size.width/2){
                bar.position.x = bar.size.width/2
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
