//
//  ViewController.swift
//  testBeacon2
//
//  Created by ITユーザー on 2016/11/11.
//  Copyright © 2016年 ITuser. All rights reserved.
//

    import UIKit
    import Foundation
    import CoreLocation
    
    class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
        
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        
        func tableView(tableView: UITableView,didSelectRowAtIndexPath indexPath: NSIndexPath){
            performSegueWithIdentifier("toDetail", sender: self)
            ap.Item = items[indexPath.row]
        }
       
        @IBOutlet weak var tableView: UITableView!
        
        var items:[Data] = []
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
        }
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = UITableViewCell(style: .Default, reuseIdentifier: "mycell")
            if items[indexPath.row].preprocessing == "ok"{
                cell.textLabel?.text = items[indexPath.row].question
            }
            return cell
            
            
            
        }
        
        
        //UUIDカラNSUUIDを作成
        let proximityUUID = NSUUID(UUIDString:"00000000-B0B8-1001-B000-001C4D28B4D2")
        var region  = CLBeaconRegion()
        var manager = CLLocationManager()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            dataSet()
            
            //CLBeaconRegionを生成
            region = CLBeaconRegion(proximityUUID:proximityUUID!,identifier:"EstimoteRegion")
            
            //デリゲートの設定
            manager.delegate = self
            
            /*
             位置情報サービスへの認証状態を取得する
             NotDetermined   --  アプリ起動後、位置情報サービスへのアクセスを許可するかまだ選択されていない状態
             Restricted      --  設定 > 一般 > 機能制限により位置情報サービスの利用が制限中
             Denied          --  ユーザーがこのアプリでの位置情報サービスへのアクセスを許可していない
             Authorized      --  位置情報サービスへのアクセスを許可している
             */
            switch CLLocationManager.authorizationStatus() {
            case .Authorized, .AuthorizedWhenInUse:
                //iBeaconによる領域観測を開始する
                print("観測開始")
                self.manager.startRangingBeaconsInRegion(self.region)
            case .NotDetermined:
                print("許可承認")
                //デバイスに許可を促す
                if(UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8.0{
                    //iOS8以降は許可をリクエストする関数をCallする
                    self.manager.requestAlwaysAuthorization()
                }else{
                    self.manager.startRangingBeaconsInRegion(self.region)
                }
            case .Restricted, .Denied:
                //デバイスから拒否状態
                print("Restricted")
            }
        }
        
        
        //以下 CCLocationManagerデリゲートの実装---------------------------------------------->
        
        /*
         - (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region
         Parameters
         manager : The location manager object reporting the event.
         region  : The region that is being monitored.
         */
        func locationManager(manager: CLLocationManager, didStartMonitoringForRegion region: CLRegion) {
            manager.requestStateForRegion(region)
        }
        
        /*
         - (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
         Parameters
         manager :The location manager object reporting the event.
         state   :The state of the specified region. For a list of possible values, see the CLRegionState type.
         region  :The region whose state was determined.
         */
        func locationManager(manager: CLLocationManager, didDetermineState state: CLRegionState, forRegion inRegion: CLRegion) {
            if (state == .Inside) {
                //領域内にはいったときに距離測定を開始
                manager.startRangingBeaconsInRegion(region)
            }
        }
        
        /*
         リージョン監視失敗（bluetoosの設定を切り替えたりフライトモードを入切すると失敗するので１秒ほどのdelayを入れて、再トライするなど処理を入れること）
         - (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
         Parameters
         manager : The location manager object reporting the event.
         region  : The region for which the error occurred.
         error   : An error object containing the error code that indicates why region monitoring failed.
         */
        func locationManager(manager: CLLocationManager, monitoringDidFailForRegion region: CLRegion?, withError error: NSError) {
            print("monitoringDidFailForRegion \(error)")
        }
        
        /*
         - (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
         Parameters
         manager : The location manager object that was unable to retrieve the location.
         error   : The error object containing the reason the location or heading could not be retrieved.
         */
        //通信失敗
        func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
            print("didFailWithError \(error)")
        }
        
        func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
            manager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
        }
        
        func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
            manager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
            reset()
        }
        
        /*
         beaconsを受信するデリゲートメソッド。複数あった場合はbeaconsに入る
         - (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
         Parameters
         manager : The location manager object reporting the event.
         beacons : An array of CLBeacon objects representing the beacons currently in range. You can use the information in these objects to determine the range of each beacon and its identifying information.
         region  : The region object containing the parameters that were used to locate the beacons
         */
        func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
            
            print(beacons)
            
            if(beacons.count == 0) { return }
            //複数あった場合は一番先頭のものを処理する
            
            /*
             beaconから取得できるデータ
             proximityUUID   :   regionの識別子
             major           :   識別子１
             minor           :   識別子２
             proximity       :   相対距離
             accuracy        :   精度
             rssi            :   電波強度
             */

            checkImmediate(beacons)
            

        }
        
        func checkImmediate(beacons:[CLBeacon]){
            for i in 0..<beacons.count{
                if  beacons[i].major == 1111 {
                    if beacons[i].proximity == CLProximity.Immediate{
                        items[0].preprocessing = "ok"
                        self.tableView.reloadData()
                    }
                }
                if beacons[i].major == 2222 {
                    if beacons[i].proximity == CLProximity.Immediate{
                        if items[0].preprocessing == "ok" {
                            items[1].preprocessing = "ok"
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            
        }
        
        func reset(){
        }
        
        override func viewWillDisappear(animated: Bool) {
            
            
        }
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        func dataSet(){
            items.append(Data(question: "ようこそ",preprocessing: "no"))
            items.append(Data(question: "問1", preprocessing: "no"))
        }

}

