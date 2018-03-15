//
//  ArtModel.swift
//  WXLApp
//
//  Created by mac on 2018/3/12.
//  Copyright © 2018年 mjwz5294. All rights reserved.
//

import HandyJSON

let contentSeparator = "<<<<<"
let imgadrMark = ">>>>>"

struct ArtModel: HandyJSON {
    var id: Int = 0
    var writer: String?
    var title: String?
    var create_time: String?
    var modified_time: String?
    var contentStr: String?
}

struct ArtCellModel {
    var isImg = false
    var content:String?
}

func contentStrToArr(content:String) -> [ArtCellModel] {
    let strArr = content.components(separatedBy:contentSeparator)
    print(strArr)
    var result = [ArtCellModel]()
    for var str in strArr {
        var model = ArtCellModel()
        if str.hasPrefix(imgadrMark) && str.hasSuffix(imgadrMark){
            model.isImg = true
            str.removeFirst(5)
            str.removeLast(5)
        }
        model.content = str
        result.append(model)
    }
    return result
}

func contentArrToStr(arr:[ArtCellModel]) -> String {
    var result = ""
    for i in 0..<arr.count {
        var model = arr[i]
        if model.isImg == true{
            model.content = imgadrMark+model.content!+imgadrMark
        }
        result.append(model.content!)
        if i<arr.count-1{
            result.append(contentSeparator)
        }
    }
    return result
}

struct ArtArrModel: HandyJSON {
    var artArr: [ArtModel]?
}
