//
//  CommonModel.swift
//  WXLApp
//
//  Created by mac on 2018/3/11.
//  Copyright © 2018年 mjwz5294. All rights reserved.
//

import HandyJSON

struct ReturnData<T: HandyJSON>: HandyJSON {
    var message:String?
    var returnData: T?
    var stateCode: Int = 0
}

struct ResponseData<T: HandyJSON>: HandyJSON {
    var code: Int = 0
    var data: ReturnData<T>?
}
