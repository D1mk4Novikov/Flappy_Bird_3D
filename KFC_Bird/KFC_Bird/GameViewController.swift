//
//  GameViewController.swift
//  KFC_Bird
//
//  Created by Dimka Novikov on 19/02/2020.
//  Copyright © 2020 DDEC. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

final class GameViewController: UIViewController {
    
    
    var gameView: SCNView!
    var gameScene: SCNScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupGameView()
        self.setupGameScene()
        
        
        
    }
    
    private func setupGameView() -> Void {
        gameView = (self.view as! SCNView)
    }
    
    private func setupGameScene() -> Void {
        self.gameScene = BirdScene(create: true)
        self.gameView.scene = gameScene
        
//        self.gameView.showsStatistics = true
//        self.gameView.allowsCameraControl = true
//        self.gameView.autoenablesDefaultLighting = true
        
        self.gameView.delegate = (self.gameScene as! SCNSceneRendererDelegate)
        self.gameView.isPlaying = true
        
        self.gameView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    }
    
    
    
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown]
    }

}
