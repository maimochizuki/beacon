//
//  Data.swift
//  testBeacon2
//
//  Created by ITユーザー on 2016/11/11.
//  Copyright © 2016年 ITuser. All rights reserved.
//

import Foundation

class Data {
    var question = ""
    var detail = ""
    var preprocessing:[String] = []
    var beacon = 0
    var checkOK = "no"
    var ccnt = -1
    
    init(question:String,preprocessing:[String], beacon:Int){
        self.question = question
        self.preprocessing = preprocessing
        self.beacon = beacon
        ccnt = self.preprocessing.count
    }
    
    func check(items:[Data]){
        for i in 0..<items.count{
            for j in 0..<preprocessing.count{
                if items[i].preprocessing[0] == "no"{
                    ccnt = 0
                    break
                }
                else if items[i].question == preprocessing[j]{
                    if items[i].checkOK == "ok"{
                        ccnt -= 1
                    }
                }
            }
        }
        if ccnt == 0{
            checkOK = "ok"
        }
    }
}