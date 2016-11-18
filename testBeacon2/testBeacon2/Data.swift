//
//  Data.swift
//  testBeacon2
//
//  Created by ITユーザー on 2016/11/11.
//  Copyright © 2016年 ITuser. All rights reserved.
//
import Foundation

class Data {
    var title = ""
    var question:q_and_a!
    var preprocessing:[String] = []
    var beacon = 0
    var checkOK = "no"
    
    init(title:String, question:q_and_a, preprocessing:[String], beacon:Int){
        self.title = title
        self.question = question
        self.preprocessing = preprocessing
        self.preprocessing.append("no")
        self.beacon = beacon
    }

    
    func check(items:[Data]){
        if preprocessing[0] == "no"{
            if question.doAnswer == "no" || question.doAnswer == "ok"{
                checkOK = "ok"
                for i in items{
                    if i.title != title{
                        for p in 0..<i.preprocessing.count{
                            if i.preprocessing[p] == title{
                                i.preprocessing.removeAtIndex(p)
                                break
                            }
                        }
                    }
                }
            }
        }
    }
}

class q_and_a {
    var question:String!
    var qType:Int!
    var answer:String!
    var doAnswer:String!
    
    init(question:String, qType:Int, answer:String){
        self.question = question
        self.qType = qType
        self.answer = answer
        switch qType {
        case 0:
            doAnswer = "no"
        default:
            doAnswer = "yes"
        }
    }
}