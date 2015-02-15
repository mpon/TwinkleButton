//
//  ViewController.swift
//  TwinkleButton
//
//  Created by Masato Oshima on 2015/02/15.
//  Copyright (c) 2015年 Masato Oshima. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    let kAnimationDuration = 0.8
    let kParticleName = "twinkle"
    
    var skView: SKView!
    var isAnimating: Bool = false
    var isFavorite: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // STEP1: create scene
        let w = CGFloat(100), h = CGFloat(100)
        let scene = SKScene(size: CGSizeMake(w, h))
        scene.backgroundColor = UIColor.clearColor()
        
        // STEP2: create sk view
        let centerX = CGRectGetMidX(self.view.frame)
        let centerY = CGRectGetMidY(self.view.frame)
        let skFrame = CGRectMake(centerX - w / 2, centerY - h / 2, w, h)
        skView = SKView(frame: skFrame)
        skView.allowsTransparency = true
        skView.userInteractionEnabled = false
        skView.presentScene(scene)
        
        // STEP3: add sk view
        self.view.addSubview(skView)
        
        // STEP4: add particle to scene
        let path = NSBundle.mainBundle().pathForResource(kParticleName, ofType: "sks")
        let particle = NSKeyedUnarchiver.unarchiveObjectWithFile(path!) as SKEmitterNode
        particle.name = kParticleName
        particle.position = CGPointMake(w / 2, h / 2)
        particle.alpha = 0
        scene.addChild(particle)
    }

    @IBAction func buttonDidPush(button: UIButton) {
        if isAnimating {
            return
        }
        
        // you can get SKScene from SKView
        let scene = skView.scene!
        // you can get SKNode from SKScene
        let particle = scene.childNodeWithName(kParticleName)!
        
        if isFavorite {
            // reset favorite
            particle.alpha = 0
            button.setImage(UIImage(named: "star_gray"), forState: .Normal)
        } else {
            // add favorite action
            isAnimating = true
            animateButton(button)
            showParticle(particle, {
                self.isAnimating = false
            })
        }
        
        isFavorite = !isFavorite
    }
    
    private func animateButton(button: UIButton) {
        button.alpha = 0.4
        button.transform = CGAffineTransformMakeScale(0.4, 0.4)
        button.setImage(UIImage(named: "star_yellow"), forState: .Normal)
        UIView.animateWithDuration(kAnimationDuration,
            animations: {
                button.alpha = 1
                button.transform = CGAffineTransformMakeScale(1.2, 1.2)
            }, completion: { finished in
                button.transform = CGAffineTransformIdentity
        })
    }
    
    private func showParticle(particle: SKNode , completion: () -> Void = {}) {
        particle.alpha = 1
        let fadeout = SKAction.fadeOutWithDuration(kAnimationDuration)
        particle.runAction(fadeout, completion: {
            completion()
        })
    }

}

