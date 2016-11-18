//
//  DetailViewController.swift
//  testBeacon2
//
//  Created by ITユーザー on 2016/11/18.
//  Copyright © 2016年 ITuser. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let ap = UIApplication.sharedApplication().delegate as! AppDelegate


    override func viewWillAppear(animated: Bool) {
        
        print("\(ap.no)")
    }
    
    
    private func initImageView(){
        // UIImage インスタンスの生成
        let image1:UIImage = UIImage(named:"Goofy.jpg")!
        
        // UIImageView 初期化
        let imageView = UIImageView(image:image1)
        
        // 画面の横幅を取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height
        
        // 画像の中心を画面の中心に設定
        imageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
        
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(imageView)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initImageView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
