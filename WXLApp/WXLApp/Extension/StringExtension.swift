//
//  StringExtension.swift
//  U17
//
//  Created by charles on 2017/10/9.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit

extension String {
    public func substring(from index: Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[startIndex..<self.endIndex]
            return String(subString)
        } else {
            return self
        }
    }
    
    func getLabHeight(font:UIFont=UIFont.systemFont(ofSize: 14),width:CGFloat=screenWidth-20) -> CGFloat {
        
        let statusLabelText: String = self
        
        let size = CGSize(width:width,height:90)
        
        let dic = NSDictionary(object: font, forKey: NSAttributedStringKey.font as NSCopying)
        
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : Any], context: nil).size
        
        return strSize.height
        
    }
}
