//
//  ViewController.swift
//  escapegame
//
//  Created by ITユーザー on 2016/11/04.
//  Copyright © 2016年 ITユーザー. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var escapeButton: UIButton!
    @IBOutlet weak var treasureButton: UIButton!
    @IBOutlet weak var stampButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        // ボタン設定
         escapeButton.backgroundColor = UIColor.orangeColor()
        escapeButton.layer.cornerRadius = 10.0
        escapeButton.layer.masksToBounds = true

        treasureButton.backgroundColor = UIColor.orangeColor()
        treasureButton.layer.cornerRadius = 10.0
        treasureButton.layer.masksToBounds = true
        
        stampButton.backgroundColor = UIColor.blueColor()
        stampButton.layer.cornerRadius = 10.0
        stampButton.layer.masksToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

