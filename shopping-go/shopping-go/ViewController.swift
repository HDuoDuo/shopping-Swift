//
//  ViewController.swift
//  shopping-go
//
//  Created by liuhang on 16/11/6.
//  Copyright © 2016年 刘航. All rights reserved.
//

import UIKit
import SVProgressHUD
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    dataManager.loadData(20) { (dataModels) -> () in
        let model = dataModels.first
        print("------\(model!.ID)")
        }
    }
}

