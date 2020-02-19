//
//  BirdScene.swift
//  KFC_Bird
//
//  Created by Dimka Novikov on 19/02/2020.
//  Copyright © 2020 DDEC. All rights reserved.
//

import SceneKit



final class BirdScene: SCNScene, SCNSceneRendererDelegate {
    
    let firstEmptyGrass = SCNNode()
    let secondEmptyGrass = SCNNode()
    
    var runningUpdate: Bool = true
    var timeLast: Double?
    let speedConstant = -0.7
    
    
    convenience init(create: Bool) {
        self.init()
        
        setupCameraAndLights()
        self.setupScenary()
        
        guard let propsScene = SCNScene(named: "art.scnassets/WorldGround.dae") else { return }
        
        self.firstEmptyGrass.scale = SCNVector3(scale: 0.15)
        self.firstEmptyGrass.position = SCNVector3(0.0, -1.3, 0.0)
        
        self.secondEmptyGrass.scale = SCNVector3(scale: 0.15)
        self.secondEmptyGrass.position = SCNVector3(4.45, -1.3, 0.0)
        
        
        let firstGrass = propsScene.rootNode.childNode(withName: "Grass", recursively: true)!
        firstGrass.position = SCNVector3(-5.0, 0.0, 0.0)
        
        let secondGrass = firstGrass.clone()
        secondGrass.position = SCNVector3(-5.0, 0.0, 0.0)
        
        self.firstEmptyGrass.addChildNode(firstGrass)
        self.secondEmptyGrass.addChildNode(secondGrass)
        
        self.rootNode.addChildNode(firstEmptyGrass)
        self.rootNode.addChildNode(secondEmptyGrass)
    }
    
    
    private func setupCameraAndLights() -> Void {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera!.usesOrthographicProjection = false
        
        cameraNode.position = SCNVector3(0.0, 0.0, 0.0)
        cameraNode.pivot = SCNMatrix4MakeTranslation(0.0, 0.0, -3.0)
        self.rootNode.addChildNode(cameraNode)
        
        let firstLight = SCNLight()
        firstLight.type = .spot
        firstLight.spotOuterAngle = 90.0
        firstLight.attenuationStartDistance = 0.0
        firstLight.attenuationFalloffExponent = 2.0
        firstLight.attenuationEndDistance = 30.0
        
        let lightNodeSpot = SCNNode()
        lightNodeSpot.light = firstLight
        lightNodeSpot.position = SCNVector3(x: 0.0, y: 10.0, z: 1.0)
        self.rootNode.addChildNode(lightNodeSpot)
        
        let lightNodeFront = SCNNode()
        lightNodeFront.light = firstLight
        lightNodeFront.position = SCNVector3(x: 0.0, y: 1.0, z: 15.0)
        self.rootNode.addChildNode(lightNodeFront)
        
        let emptyCenterLightNode = SCNNode()
        emptyCenterLightNode.position = SCNVector3Zero
        self.rootNode.addChildNode(emptyCenterLightNode)
        
        lightNodeSpot.constraints = [SCNLookAtConstraint(target: emptyCenterLightNode)]
        lightNodeFront.constraints = [SCNLookAtConstraint(target: emptyCenterLightNode)]
        cameraNode.constraints = [SCNLookAtConstraint(target: emptyCenterLightNode)]
        
        let ambientLight = SCNNode()
        ambientLight.light = SCNLight()
        ambientLight.light!.type = .ambient
        ambientLight.light!.color = UIColor(white: 0.05, alpha: 1.0)
        self.rootNode.addChildNode(ambientLight)
    }
    
    
    private func setupScenary() -> Void {
        let groundGeometry = SCNBox(width: 4, height: 0.5, length: 0.4, chamferRadius: 0.0)
        groundGeometry.firstMaterial!.diffuse.contents = #colorLiteral(red: 1, green: 0.768627451, blue: 0, alpha: 1)
        groundGeometry.firstMaterial!.specular.contents = UIColor.black
        groundGeometry.firstMaterial!.emission.contents = #colorLiteral(red: 0.6235294118, green: 0.3921568627, blue: 0.05882352941, alpha: 1)
        
        let groundNode = SCNNode(geometry: groundGeometry)
        
        let emptySand = SCNNode()
        emptySand.addChildNode(groundNode)
        emptySand.position.y = -1.63
        self.rootNode.addChildNode(emptySand)
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        var dt: Double
        
        if (runningUpdate) {
            if let lt = self.timeLast {
                dt = time - lt
            } else {
                dt = 0
            }
        } else {
            dt = 0
        }
        
        timeLast = time
        
        
        self.grassAnimation(for: firstEmptyGrass, by: dt)
        self.grassAnimation(for: secondEmptyGrass, by: dt)
    }
    
    
    private func grassAnimation(for node: SCNNode, by dt: Double) -> Void {
        node.position.x += Float(dt * speedConstant)
        if node.position.x <= -4.45 {
            node.position.x = 4.45
        }
    }
    
}



extension SCNVector3 {
    init(scale by: Float) {
        self.init()
        self.x = by
        self.y = by
        self.z = by
    }
}
