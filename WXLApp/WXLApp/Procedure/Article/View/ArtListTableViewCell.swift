//
//  ArtListTableViewCell.swift
//  WXLApp
//
//  Created by mac on 2018/3/12.
//  Copyright © 2018年 mjwz5294. All rights reserved.
//

import UIKit

class ArtListTableViewCell: UBaseTableViewCell {

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var idLab: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var model: ArtModel? {
        didSet {
            guard let model = model else { return }
            titleLab.text = model.title
            idLab.text = String(model.id)
        }
    }
    
}
