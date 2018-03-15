//
//  UNewArtViewController.swift
//  WXLApp
//
//  Created by mac on 2018/3/6.
//  Copyright © 2018年 mjwz5294. All rights reserved.
//

import UIKit

class UNewArtViewController: UBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var artList = [ArtModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func configUI() {
//        tableView.tableFooterView = UIView()
        tableView.uHead = URefreshHeader{ [weak self] in self?.loadData() }
        tableView.uFoot = URefreshTipKissFooter(with: "底部测试~")
        tableView.uempty = UEmptyView { [weak self] in self?.loadData() }
        tableView.register(cellType: ArtListTableViewCell.self)
        loadData()
    }
    
    @objc private func loadData() {
        ApiLoadingProvider.request(UAPI.getArts, model: ArtArrModel.self) { (returnData) in
            self.tableView.uHead.endRefreshing()
            self.artList = returnData?.artArr ?? []
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension UNewArtViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ArtListTableViewCell.self)
        
        cell.model = artList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc:UCreateArtViewController = artSB.instantiateViewController(withIdentifier: "UCreateArtViewController") as! UCreateArtViewController
        vc.artModel = artList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}



