//
//  ViewController.swift
//  EffectButton
//
//  Created by Masato Oshima on 2015/02/15.
//  Copyright (c) 2015年 Masato Oshima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonDidPush(button: UIButton) {
        println("hello world")
    }

}

