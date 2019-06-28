//
//  ViewController4.swift
//  Trifecta
//
//  Created by Mike Dix on 4/19/19.
//  Copyright © 2019 Mike Dix. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class ViewController4: UIViewController {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            if let scene = FlappyGameScene(fileNamed:"FlappyGameScene") {
                // Configure the view.
                let skView = self.view as! SKView
                skView.showsFPS = true
                skView.showsNodeCount = true
                
                /* Sprite Kit applies additional optimizations to improve rendering performance */
                skView.ignoresSiblingOrder = true
                
                /* Set the scale mode to scale to fit the window */
                scene.scaleMode = .aspectFill
                scene.size = self.view.bounds.size
                
                skView.presentScene(scene)
            }
        }
        
        override var shouldAutorotate: Bool {
            return true
        }
        
        override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            if UIDevice.current.userInterfaceIdiom == .phone {
                return .allButUpsideDown
            } else {
                return .all
            }
        }
        
        override var prefersStatusBarHidden: Bool {
            return true
        }
    }

        




