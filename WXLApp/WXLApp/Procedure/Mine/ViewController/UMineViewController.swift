//
//  UMineViewController.swift
//  WXLApp
//
//  Created by mac on 2018/3/6.
//  Copyright © 2018年 mjwz5294. All rights reserved.
//

import UIKit
import Kingfisher

class UMineViewController: UBaseViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    //let imageURL = URL(string: "http://ww1.sinaimg.cn/large/92ce04b2gy1fgapuwrc3nj23gq2g6twu.jpg")
    let imageURL1 = URL(string: "http://192.168.0.160:3001/image/test.jpg")
    let imageURL2 = URL(string: "http://192.168.0.160:3001/image/test1.jpg")
    var testBool = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refreshImg(_ sender: Any) {
        if testBool {
            imgView.kf.setImage(with: ImageResource(downloadURL: imageURL1!))
        }else{
            imgView.kf.setImage(with: ImageResource(downloadURL: imageURL2!))
        }
        testBool = !testBool;
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
