//
//  UBaseTableViewCell.swift
//  WXLApp
//
//  Created by mac on 2018/3/12.
//  Copyright © 2018年 mjwz5294. All rights reserved.
//

import UIKit
import Reusable

class UBaseTableViewCell: UITableViewCell,NibReusable {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configUI()
    }
    
    //http://blog.csdn.net/u012307002/article/details/50390328
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
//        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}

}
