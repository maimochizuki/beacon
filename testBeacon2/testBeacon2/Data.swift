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
    var status = "ng"
    
    init(title:String, question:q_and_a, preprocessing:[String], beacon:Int){
        self.title = title
        self.question = question
        self.preprocessing = preprocessing
        self.preprocessing.append("end")
        self.beacon = beacon
        if question.doAnswer == "ok"{
            status = "checked"
        }
    }

    
    func check(items:[Data], major:NSNumber){
        print(major)
        if question.doAnswer == "ok"{
            for i in items{
                if i.title != title{
                    for p in 0..<i.preprocessing.count{
                        if i.preprocessing[p] == title{
                            i.preprocessing.removeAtIndex(p)
                            if i.preprocessing[0] == "end"{
                                i.status = "checked"
                            }
                            break
                        }
                    }
                }
            }
        }
        
        if status == "checked"{
            if major == beacon{
                status = "printOK"
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
            doAnswer = "ok"
        default:
            doAnswer = "yes"
        }
    }
}