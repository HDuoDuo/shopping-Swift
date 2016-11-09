//
//  LHproductViewController.swift
//  shopping-go
//
//  Created by liuhang on 16/11/8.
//  Copyright © 2016年 刘航. All rights reserved.
//

import UIKit
import MJRefresh

private let cellIdentifier = "LHProductTableViewCell"
class LHproductViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //请求数据起始位置
    var startDataPoint :NSInteger = 0
    //请求条数最大值
    var totalSize :NSInteger = 0
    //产品表格视图数据源
    var dataArray :[dataModel] = []
    //懒加载tableView
    private lazy var tableView :UITableView = {
        let table = UITableView(frame: self.view.bounds)
        //注册
        return table
    }()
    
    //MARK:系统方法
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.greenColor()
        self.view.addSubview(tableView)
        //初始化tableView
        self.initTableView()
        //获取数据
        self.refreshData()
        
    }
    
    //MARK:初始化tableView
    private func initTableView() {
        tableView.registerNib(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        //上拉刷新
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { () -> Void in
            self.refreshData()
        })
        //下拉加载更多
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: { () -> Void in
            self.getMoreData()
        })
    }
    //MARK:刷新数据
    private func refreshData() {
        startDataPoint = 0
        self.totalSize = 0
        dataManager.loadData(startDataPoint) { (models,total) -> () in
            self.totalSize = total
            self.dataArray.removeAll()
            self.tableView.mj_header.endRefreshing()
            for model in models {
                self.dataArray.append(model)
            }
            self.tableView.reloadData()
        }
    }
    //MARK:获取更多数据数据
    private func getMoreData() {
        startDataPoint += 20
        if self.totalSize > self.startDataPoint {
            dataManager.loadData(startDataPoint) { (dataModels,_) -> () in
                
                for model in dataModels {
                    self.dataArray.append(model)
                }
                
                self.tableView.mj_footer.endRefreshing()
                self.tableView.reloadData()
            }
        }else {
            self.tableView.mj_footer.endRefreshingWithNoMoreData()
        }
        
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
