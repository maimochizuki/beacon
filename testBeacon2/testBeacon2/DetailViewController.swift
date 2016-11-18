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
    var scale:CGFloat = 1.0
    var width:CGFloat = 0
    var height:CGFloat = 0
    
    @IBOutlet weak var navItem: UINavigationItem!
    let BoundSize_w: CGFloat = UIScreen.mainScreen().bounds.width  //横幅
    let BoundSize_h: CGFloat = UIScreen.mainScreen().bounds.height //縦幅
    
    override func viewWillAppear(animated: Bool) {
        
      //  print("\(ap.no)")
    }
    
    
    
    private func initImageView(){
        print("\(BoundSize_w),\(BoundSize_h)")
        
        // UIImage インスタンスの生成
        let image1:UIImage = UIImage(named:ap.Item.question.question)!
    
    
        // UIImageView 初期化
        let imageView = UIImageView(image:image1)
    
        // 画面の横幅を取得
        let screenWidth:CGFloat = view.frame.size.width
        let screenHeight:CGFloat = view.frame.size.height

    
        width = image1.size.width
        height = image1.size.height
    
        // 画像サイズをスクリーン幅に合わせる
        scale = screenWidth / width
        let rect:CGRect = CGRect(x:0, y:0, width:width*scale, height:height*scale)
    
        // ImageView frame をCGRectで作った矩形に合わせる
        imageView.frame = rect;
    
    
        // 画像の中心を画面の中心に設定
        imageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2)
    
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(imageView)
  
    }

    func onAdd(sender: AnyObject){
        
        //ダイアログ生成
        let dialog = UIAlertController(title: "解答", message: "解答を入力してください",preferredStyle: .Alert)
        
       //ダイアログにテキストフィールド追加
        dialog.addTextFieldWithConfigurationHandler{(item:UITextField)in}
        
        //OKボタン追加
        let ok = UIAlertAction(title: "OK", style: .Default){
            (action:UIAlertAction)in
        }
        dialog.addAction(ok)
        //Cancelボタン追加
        dialog.addAction(UIAlertAction(title:"Cancel", style:.Cancel,handler: nil))
        
        //ダイアログ表示
        self.presentViewController(dialog,animated:true,completion: nil)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if(ap.Item.question.qType == 0){
        initImageView()
        }else if (ap.Item.question.qType == 1){
            let toi = UILabel(frame : CGRectMake(10, 100, BoundSize_w-10, 0))
            toi.text = ap.Item.question.question
            toi.numberOfLines = 0
            toi.sizeToFit()
            toi.lineBreakMode = NSLineBreakMode.ByWordWrapping
            self.view.addSubview(toi)
        }
        else if (ap.Item.question.qType == 2){
            let toi = UILabel(frame : CGRectMake(10, 100, BoundSize_w-10, 0))
            toi.text = ap.Item.question.question
            toi.numberOfLines = 0
            toi.sizeToFit()
            toi.lineBreakMode = NSLineBreakMode.ByWordWrapping
            self.view.addSubview(toi)
        }
        
        let rightBtn = UIBarButtonItem(title: "解答",style: UIBarButtonItemStyle.Plain,target: self,action: "onAdd:")
        navItem.rightBarButtonItem = rightBtn
        
        
      
        navItem.title = "\(ap.Item.title)"
        print("\(ap.Item.title)")
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
