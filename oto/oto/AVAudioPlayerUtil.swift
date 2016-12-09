//
//  AVAudioPlayerUtil.swift
//  oto
//
//  Created by ITユーザー on 2016/12/02.
//  Copyright © 2016年 ITユーザー. All rights reserved.
//
import AVFoundation
import UIKit
import MediaPlayer

class AVAudioPlayerUtil{
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    var sound_data:NSURL = NSURL()

    
    func setValue(nsurl:NSURL, repeatOn:Bool=false){
        do{
            self.sound_data = nsurl
            self.audioPlayer = try AVAudioPlayer(contentsOfURL:sound_data)
            self.audioPlayer.prepareToPlay()
            if repeatOn{
                self.audioPlayer.numberOfLoops =  -1
            }
        }catch{}
    }
    
    func play(){
        self.audioPlayer.stop()
        self.audioPlayer.currentTime = 0
        self.audioPlayer.play()
    }
    
    func stop(){
        self.audioPlayer.stop();
    }
    

    
}