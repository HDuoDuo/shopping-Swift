//
//  LHproductViewController.swift
//  shopping-go
//
//  Created by liuhang on 16/11/8.
//  Copyright © 2016年 刘航. All rights reserved.
//

import UIKit
private let cellIdentifier = "LHProductTableViewCell"
class LHproductViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //产品表格视图数据源
    var dataArray :[dataModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    //懒加载tableView
    private lazy var tableView :UITableView = {
        let table = UITableView(frame: self.view.bounds)
        //注册
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.greenColor()
        self.view.addSubview(tableView)
        //初始化tableView
        self.initTableView()
        //获取数据
        self.getData()
        
    }
    //MARK:获取数据
    private func getData() {
        dataManager.loadData(10) { (dataModels) -> () in
            self.dataArray = dataModels
        }
    }
    //MARK:初始化tableView
    private func initTableView() {
        tableView.registerNib(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 50
    }
    //MARK: 实现代理方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(dataArray.count)")
        return (dataArray.count)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! LHProductTableViewCell
        cell.model = self.dataArray[indexPath.row]
        return cell
    }
}
