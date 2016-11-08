//
//  NetWorkingTool.swift
//  shopping-go
//
//  Created by liuhang on 16/11/6.
//  Copyright © 2016年 刘航. All rights reserved.
//

import UIKit
import AFNetworking
class NetWorkingTool: NSObject {
    
    //MARK:单例方法
    private static let netWorkingManager = NetWorkingTool()
    class func shareInstance() -> NetWorkingTool {
        return netWorkingManager
    }
    func GET(URLString :String,paramters :AnyObject?,backObject :((responseObject :AnyObject?,errror :NSError?) ->())) -> Void {
        manager.GET(URLString, parameters: paramters, progress: nil, success: { (_, object) -> Void in
            backObject(responseObject: object!, errror: nil)
            }) { (_, Err) -> Void in
            backObject(responseObject: nil, errror: Err)
        }
    }
    //MARK 创建请求对象
    private lazy var manager :AFHTTPSessionManager = {
        var sess = AFHTTPSessionManager()
        return sess
    }()
}