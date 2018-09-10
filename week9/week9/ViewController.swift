//
//  ViewController.swift
//  week9
//
//  Created by NG CHUN KEUNG on 30/5/18.
//  Copyright © 2018 NG CHUN KEUNG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var gameTimer : Timer?
    var gravity : UIGravityBehavior?
    var animator : UIDynamicAnimator?
    
    
    // Do any additional setup after loading the view, typically from a nib.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // set timer to show balloons
        gameTimer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: #selector(ViewController.addBalloons(_ :)),
                                         userInfo: nil, repeats: true)
        
        
        // register an animator
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior(items:[])
        
        
        let vector = CGVector(dx: 0.0, dy: 0.1) //gravity magnitude and direction
        gravity?.gravityDirection = vector
        animator?.addBehavior(gravity!)
        
    }
    
    
    
    
    @objc func addBalloons ( _ : Any) {
        
        //pick a random x position for the balloon
        let xCoordinate = arc4random() % UInt32 (self.view.bounds.width)
        
        //create a button, set Image, assign touchUpInside handler, add it to the view and gravity animator
        
        let btn = UIButton(frame: CGRect (x: Int(xCoordinate), y:60, width: 50, height : 50))
        btn.setImage(UIImage(named: "balloon"), for: .normal)
        btn.addTarget(self, action: #selector(self.didPopBalloon(sender:)), for: .touchUpInside )
        self.view.addSubview(btn)
        
        gravity?.addItem( btn as UIView)
    }
    
    @objc func didPopBalloon (sender : UIButton) {
        
        sender.setImage(UIImage (named : "explode"), for: .normal)
        UIView.animate(withDuration: 0.4, animations:{sender.alpha = 0},
                       completion: {(true) in sender.removeFromSuperview()})
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

