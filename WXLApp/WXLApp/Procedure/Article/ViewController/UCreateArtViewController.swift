//
//  UCreateArtViewController.swift
//  WXLApp
//
//  Created by mac on 2018/3/14.
//  Copyright © 2018年 mjwz5294. All rights reserved.
//

import UIKit
//用于编辑或展示文章
class UCreateArtViewController: UBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var tableHeaderView: UIView!
    @IBOutlet weak var textEditView: UIView!
    @IBOutlet weak var textEditTF: UITextView!
    
    var selectedIndexPath:IndexPath? = IndexPath()
    var beingEditing = true//是否处于编辑文字状态
    var isAddingCell = true;//添加新cell还是编辑旧cell
    var contentArr = [ArtCellModel]()
    
    var artModel: ArtModel? {
        didSet {
            beingEditing = false
            contentArr = contentStrToArr(content: (artModel?.contentStr!)!)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func configUI() {
        tableView.tableFooterView = UIView()
        refreshEditBtn()
        freshUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func freshUI() {
        if beingEditing {
            tableHeaderView.frame.size.height = 50
            tableHeaderView.isHidden = false
        }else{
            tableHeaderView.frame.size.height = 0
            tableHeaderView.isHidden = true
        }
        tableView.reloadData()
        if contentArr.count == 0  {
            
        }
    }
    
    @objc func editBtnTapped(){
        if beingEditing == true {
            //完成编辑
            if artModel==nil{
                createArt()
            }else{
                editArt()
            }
            
        }else{
            //开始编辑
        }
        beingEditing = !beingEditing
        refreshEditBtn()
        freshUI()
    }
    
    func refreshEditBtn(){
        
        var itemTitle = "编辑"
        if beingEditing == true {
            itemTitle = "完成"
        }
        
        //由于继承自UPageViewController，从下一级vc返回后，item会变透明，这个bug还没解决，所以放这里每次都重建一个。
        let item = UIBarButtonItem(title: itemTitle, style: .plain, target: self, action: #selector(editBtnTapped))
        item.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = item
        
    }
    
    func createArt() {
        ApiLoadingProvider.request(UAPI.createArt(writer: "wxl", title: "hahaha", contentStr: contentArrToStr(arr: contentArr)), model: ArtModel.self) { (returnData) in
            self.artModel = returnData!
            self.tableView.reloadData()
        }
    }
    
    func editArt() {
        ApiLoadingProvider.request(UAPI.editArt(artId: (artModel?.id)!, title: "hehehe", contentStr: contentArrToStr(arr: contentArr)), model: ArtModel.self) { (returnData) in
//            print(returnData)
            self.tableView.reloadData()
        }
    }

}

extension UCreateArtViewController{
    
    @IBAction func addTextBtnTapped(_ sender: Any) {
        isAddingCell = true
        selectedIndexPath = getCellIndex(sender)
        showEditView()
    }
    
    @IBAction func selectPhotoBtnTapped(_ sender: Any) {
        isAddingCell = true
        
    }
    
    @IBAction func addPhotoBtnTapped(_ sender: Any) {
        isAddingCell = true
        
    }
    
    func getCellIndex(_ sender: Any) -> (IndexPath?) {
        let btn = sender as! UIButton
        let cell = btn.superView(of: UITableViewCell.self)
        if (cell == nil) {
            return (nil)
        }
        let indexPath = tableView.indexPath(for: cell!)
        print("indexPath：\(indexPath!)")
        return indexPath!
    }
    
    func showEditView() {
        
        textEditView.isHidden = false
        textEditTF.text = ""
        if isAddingCell == false{
            let model = contentArr[(selectedIndexPath?.row)!]
            textEditTF.text = model.content
        }
        textEditTF.becomeFirstResponder()
        
    }
    
    @IBAction func textDoneBtnTapped(_ sender: Any) {
        
        textEditView.isHidden = true
        textEditTF.resignFirstResponder()
        var model = ArtCellModel()
        model.isImg = false
        model.content = textEditTF.text
        
        var index = 0
        if selectedIndexPath != nil {
            index = (selectedIndexPath?.row)!+1
        }
        if isAddingCell == true {
            contentArr.insert(model, at: index)
        }else{
            contentArr.replaceSubrange(Range(index-1..<index), with: [model])
        }        
        tableView.reloadData()
        
    }
    
    @IBAction func textCancleBtnTapped(_ sender: Any) {
        textEditView.isHidden = true
        textEditTF.resignFirstResponder()
    }
    
}


extension UCreateArtViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UArtEditTableViewCell.self)
        cell.model = contentArr[(indexPath.row)]
        cell.setEditable(beingEditing)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if !beingEditing {
            return 110
        }
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        isAddingCell = false
        selectedIndexPath = indexPath
        showEditView()
    }
}




