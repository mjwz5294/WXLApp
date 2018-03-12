//
//  ArtModel.swift
//  WXLApp
//
//  Created by mac on 2018/3/12.
//  Copyright © 2018年 mjwz5294. All rights reserved.
//

import HandyJSON



struct ArtModel: HandyJSON {
    var id: Int = 0
    var writer: String?
    var title: String?
    var create_time: String?
    var modified_time: String?
    var contentStr: String?
}

struct ArtArrModel: HandyJSON {
    var artArr: [ArtModel]?
}
