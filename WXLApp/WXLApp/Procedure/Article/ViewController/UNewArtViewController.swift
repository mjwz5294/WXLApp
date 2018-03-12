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
        tableView.register(cellType: ArtListTableViewCell.self)
        loadData()
    }
    
    @objc private func loadData() {
        ApiLoadingProvider.request(UAPI.getArts, model: ArtArrModel.self) { (returnData) in
            self.artList = (returnData?.artArr)!
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
        let vc = UBaseViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}



