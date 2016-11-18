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
    var ccnt = -10
    
    init(question:String,preprocessing:[String], beacon:Int){
        self.question = question
        self.preprocessing = preprocessing
        self.preprocessing.append("no")
        self.beacon = beacon
        ccnt = self.preprocessing.count
        print("init=\(ccnt)")
    }
    
    func check(items:[Data]){
        if preprocessing[0] == "no"{
            checkOK = "ok"
            
            for i in items{
                if i.question != question{
                    for p in 0..<i.preprocessing.count{
                        if i.preprocessing[p] == question{
                            i.preprocessing.removeAtIndex(p)
                            break
                        }
                    }
                }
            }
        }
    }
}