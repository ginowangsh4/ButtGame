//
//  GameScene.swift
//  ButtGame
//
//  Created by Rifle Zhang on 3/5/16.
//  Copyright (c) 2016 Rifle Zhang. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    var cnt = 0
    var pos = -1
    
    var levelTimerLabel = SKLabelNode(fontNamed: "ArialMT")
    //var backgroundMusic: SKAudioNode!
    
    var butt = SKSpriteNode(imageNamed:"mid")
    
    let timerL = SKLabelNode(fontNamed:"SavoyeLetPlain")
    let myLabel = SKLabelNode(fontNamed:"Chalkduster")
    
    //Immediately after leveTimerValue variable is set, update label's text
    var levelTimerValue: Int = 10 {
        didSet {
            levelTimerLabel.text = "Time left: \(levelTimerValue)"
        }
    }
    
    func GameOver (cnt: Int) {
        self.removeAllChildren()
        let formatter = NSNumberFormatter()
        formatter.hasThousandSeparators = true
        let cntString = formatter.stringFromNumber(cnt)
        
        let gameOverLabel = SKLabelNode(fontNamed:"Chalkduster")
        gameOverLabel.text = "Game Over!";         gameOverLabel.fontSize = 65;
        gameOverLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: self.size.height - 100);
        
        let scoreLine = SKLabelNode(fontNamed:"Chalkduster")
        scoreLine.text = "Final Satisfaction: " + cntString!;
        scoreLine.fontSize = 65;
        scoreLine.position = CGPoint(x: CGRectGetMidX(self.frame), y: self.size.height - 230);
        
        let kiss = SKSpriteNode(imageNamed:"kiss")
        kiss.position = CGPointMake(self.size.width/2, self.size.height/2);
        kiss.setScale(2)
        
        self.addChild(gameOverLabel)
        self.addChild(scoreLine)
        self.addChild(kiss)
        
    }
    
    func AddTime() {
        //levelTimerLabel = SKLabelNode(fontNamed:"SavoyeLetPlain")
        levelTimerLabel.fontName = "SavoyeLetPlain"
        levelTimerLabel.fontColor = SKColor.whiteColor()
        levelTimerLabel.fontSize = 70
        levelTimerLabel.position = CGPoint(x: size.width/2, y: size.height - 80)
        levelTimerLabel.text = "Time left: \(levelTimerValue)"
        addChild(levelTimerLabel)
        
        let wait = SKAction.waitForDuration(1) //change countdown speed here
        let block = SKAction.runBlock({
            [unowned self] in
            
            if self.levelTimerValue > 0{
                self.levelTimerValue--
            }else{
                self.removeActionForKey("countdown")
                self.GameOver(self.cnt)
            }
            })
        let sequence = SKAction.sequence([wait,block])
        
        runAction(SKAction.repeatActionForever(sequence), withKey: "countdown")
    }
    
    func AddCnt(cnt: Int) {
        let formatter = NSNumberFormatter()
        formatter.hasThousandSeparators = true
        let cntString = formatter.stringFromNumber(cnt)
        timerL.text = "Satisfaction: " + cntString!;
        timerL.fontSize = 70;
        timerL.fontColor =  SKColor.whiteColor()
        timerL.position = CGPoint(x: self.size.width/2, y: self.size.height - 150);
        
        self.addChild(timerL)
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.removeAllChildren()    
        myLabel.text = "Welcome to Butt game!";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: self.size.height - 100);
        
        let bg = SKSpriteNode(imageNamed:"background")
        bg.position = CGPointMake(self.size.width/2, self.size.height/2);
        bg.setScale(2)
        
        butt.position = CGPointMake(self.size.width/2, self.size.height/2);
        butt.setScale(0.5)
        
        

        
        //let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
        //sprite.runAction(SKAction.repeatActionForever(action))
        self.addChild(bg)
        self.addChild(butt)
        self.addChild(myLabel)
    }
    
    override func keyDown(theEvent: NSEvent) {
        if (self.levelTimerValue <= 0) {
            return
        }
        

        
        /* Called when a mouse click occurs */
        if theEvent.keyCode == 123
        {
            let sound = NSSound (named: "Slap")
            sound!.play()
            //get the pressed key
            if (pos == 0) {
                return
            }
            pos = 0
            
            cnt = cnt + 1
            butt.removeFromParent()
            timerL.removeFromParent()
            myLabel.removeFromParent()
            //self.removeAllChildren();
            
            butt = SKSpriteNode(imageNamed:"left")
            butt.position = CGPointMake(self.size.width/2, self.size.height/2);
            butt.setScale(0.5)
            
            //let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            //sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(butt)
            AddCnt(cnt)
            AddTime()

            
        }
        else if theEvent.keyCode == 124
        {
            let sound = NSSound (named: "Slap")
            sound!.play()
            //get the pressed key
            if (pos == 1) {
                return
            }
            pos = 1
            cnt = cnt + 1;
            //self.removeAllChildren();
            
            butt.removeFromParent()
            timerL.removeFromParent()
            myLabel.removeFromParent()
            
            butt = SKSpriteNode(imageNamed:"right")
            butt.position = CGPointMake(self.size.width/2, self.size.height/2);
            butt.setScale(0.5)
            
            //let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            //sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(butt)
            AddCnt(cnt)
            AddTime()
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
