//
//  dataModel.swift
//  shopping-go
//
//  Created by liuhang on 16/11/6.
//  Copyright © 2016年 刘航. All rights reserved.
//

import UIKit
import SVProgressHUD
//MARK:请求数据管理者
class dataManager: NSObject {
    //请求数据方法
    class func loadData(page: NSInteger,succeed:(([dataModel],totalSize:NSInteger) -> ())) -> () {
        //MARK:请求数据
        let urlSting = String(format: "http://api.sunyuki.com/v0/items?cateId=115&limit=20&offset=%ld", page)
        SVProgressHUD.showWithStatus("正在请求数据...")
        NetWorkingTool.shareInstance().GET(urlSting, paramters: nil) { (responseObject, errror) -> () in
            if responseObject != nil {
                var models = [dataModel]()
                SVProgressHUD.dismiss()
//                print("\(responseObject)")
                let array = responseObject!["items"] as! NSArray
                for dict in array {
                    let model = dataModel(dict: dict as! [String : AnyObject])
                    models.append(model)
                }
                succeed(models,totalSize: responseObject!["totalSize"] as! NSInteger)
            }
            if errror != nil {
                SVProgressHUD.showErrorWithStatus("加载失败!!!")
            }
        }
    }

}

//MARK :数据模型
class dataModel: NSObject {
    var ID :NSInteger?
    var name :String?
    var imgs :String? {
        didSet {
           imgs =  imgs!.componentsSeparatedByString(",").first
        }
    }
    /* 构造函数 */
    init(dict :[String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    //重写方法
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        if key == "id" {
            self.ID = value as? NSInteger
        }
    }
}
