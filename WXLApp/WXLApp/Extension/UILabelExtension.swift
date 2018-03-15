//
//  UILabelExtension.swift
//  WXLApp
//
//  Created by mac on 2018/3/15.
//  Copyright © 2018年 mjwz5294. All rights reserved.
//

import UIKit

extension UILabel{
    
    func getLabHeight(labelStr:String,font:UIFont=UIFont.systemFont(ofSize: 14),width:CGFloat) -> CGFloat {
        
        let statusLabelText: String = labelStr
        
        let size = CGSize(width:width,height:90)
        
        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : Any], context: nil).size
        
        return strSize.height
        
    }
}
