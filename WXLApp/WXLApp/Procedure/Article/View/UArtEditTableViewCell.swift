//
//  UArtEditTableViewCell.swift
//  WXLApp
//
//  Created by mac on 2018/3/14.
//  Copyright © 2018年 mjwz5294. All rights reserved.
//

import UIKit

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
//                imgView设置图片
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
