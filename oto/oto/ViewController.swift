//
//  ViewController.swift
//  oto
//
//  Created by ITユーザー on 2016/12/02.
//  Copyright © 2016年 ITユーザー. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController {

    let sound_drum = AVAudioPlayerUtil()
    let sound_mario = AVAudioPlayerUtil()
    var audioSession = AVAudioSession.sharedInstance()
    let myDevice: UIDevice = UIDevice.currentDevice()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        sound_drum.setValue(NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("drum", ofType: "mp3")!))
        sound_mario.setValue(NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bgm_mario", ofType: "mp3")!))
        do {
                    //AVAudioSessionCategoryAndRecord
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)

    
        } catch  {
            // エラー処理
            fatalError("カテゴリ設定失敗")
            print("失敗")
        }
    
    
        //近接センサーのON
        myDevice.proximityMonitoringEnabled = true
        
        //近接センサーの監視を開始
        NSNotificationCenter.defaultCenter().addObserver(self,
                    selector:"proximitySensorStateDidChange:",
                    name:UIDeviceProximityStateDidChangeNotification,object: nil)
    
    }

    @IBAction func tapButton(sender: AnyObject) {
        sound_drum.play()

    }
    
    func proximitySensorStateDidChange(noification:NSNotification){
        
        if myDevice.proximityState == true {
            //近づいた時
            sound_mario.play()
        }else{
            //離れた時
            sound_mario.stop()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

