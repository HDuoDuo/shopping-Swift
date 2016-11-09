//
//  LHProductTableViewCell.swift
//  shopping-go
//
//  Created by liuhang on 16/11/8.
//  Copyright © 2016年 刘航. All rights reserved.
//

import UIKit
import SDWebImage
class LHProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    var model :dataModel? {
        didSet {
            self.productImg.sd_setImageWithURL(NSURL(string: model!.imgs!))
            self.nameLabel.text = model!.name
            self.idLabel.text = String(format: "\(model!.ID!)", locale: nil)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
