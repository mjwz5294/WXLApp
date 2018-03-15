//
//  UArtEditTableViewCell.swift
//  WXLApp
//
//  Created by mac on 2018/3/14.
//  Copyright © 2018年 mjwz5294. All rights reserved.
//

import UIKit
import Kingfisher

class UArtEditTableViewCell: UBaseTableViewCell {

    @IBOutlet weak var textLab: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var addtextBtn: UIButton!
    @IBOutlet weak var selpicBtn: UIButton!
    @IBOutlet weak var addpicBtn: UIButton!
    @IBOutlet weak var btnContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var model: ArtCellModel? {
        didSet {
            guard let model = model else { return }
            if model.isImg {
                textLab.isHidden = true
                imgView.isHidden = false
                /*imgView设置图片，这里Kingfisher会对图片做缓冲，根据我这套图片设计机制，替换图片返回的是同样的名字，这样会导致客户端不会去服务端下载图片，因此图片也就替换不了。我这里的解决办法：
                 1、用一种不做缓存的图片加载方式
                 2、图片替换依然用不同的名字，不去省资源
                 这里我选择了第一种方式
                 */
//                imgView.kf.setImage(with: ImageResource(downloadURL: URL(string: imgServerPathDownload+model.content!)!))
                imgView.downloadedFrom(link: imgServerPathDownload+model.content!)
            }else{
                textLab.isHidden = false
                textLab.text = model.content
                imgView.isHidden = true
            }
        }
    }
    
    func setEditable(_ editable:Bool) {
        addpicBtn.isEnabled = editable
        selpicBtn.isEnabled = editable
        addpicBtn.isEnabled = editable
        isUserInteractionEnabled = editable
        btnContainer.isHidden = !editable
    }
    
}
