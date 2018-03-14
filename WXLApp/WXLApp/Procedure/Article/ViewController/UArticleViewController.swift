//
//  UArticleViewController.swift
//  WXLApp
//
//  Created by mac on 2018/3/6.
//  Copyright © 2018年 mjwz5294. All rights reserved.
//

import UIKit

class UArticleViewController: UPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //由于继承自UPageViewController，从下一级vc返回后，item会变透明，这个bug还没解决，所以放这里每次都重建一个。
        let item = UIBarButtonItem(title: "新建", style: .plain, target: self, action: #selector(createArt))
        item.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = item
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func createArt(){
        let vc = artSB.instantiateViewController(withIdentifier: "UCreateArtViewController")
        self.navigationController?.pushViewController(vc, animated: true)
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
