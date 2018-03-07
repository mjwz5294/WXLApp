//
//  UTabBarController.swift
//  U17
//
//  Created by charles on 2017/9/29.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit

class UTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        
        /// 文章
        let artVC = UArticleViewController(titles: ["推荐",
                                                    "最新",
                                                    "最热"],
                                           vcs: [UBoutiqueViewController(),
                                                 UNewArtViewController(),
                                                 UHotArtViewController()],
                                           pageStyle: .navgationBarSegment)
        addChildViewController(artVC,
                               title: "文章",
                               image: UIImage(named: "tab_class"),
                               selectedImage: UIImage(named: "tab_class_S"))
        
        ///聊天
        addChildViewController(UChatViewController(),
                               title: "聊天",
                               image: UIImage(named: "tab_home"),
                               selectedImage: UIImage(named: "tab_home_S"))


        /// RN,混合APP
        addChildViewController(UHybridViewController(),
                               title: "混合",
                               image: UIImage(named: "tab_book"),
                               selectedImage: UIImage(named: "tab_book_S"))

        /// 我的
        addChildViewController(UMineViewController(),
                               title: "我的",
                               image: UIImage(named: "tab_mine"),
                               selectedImage: UIImage(named: "tab_mine_S"))
    }
    
    func addChildViewController(_ childController: UIViewController, title:String?, image:UIImage? ,selectedImage:UIImage?) {
        
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: nil,
                                                  image: image?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        }
        addChildViewController(UNavigationController(rootViewController: childController))
    }
    
}

extension UTabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .lightContent }
        return select.preferredStatusBarStyle
    }
}
