//
//  UCreateArtViewController.swift
//  WXLApp
//
//  Created by mac on 2018/3/14.
//  Copyright © 2018年 mjwz5294. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import Photos

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
            self.artModel = returnData ?? ArtModel()
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
        model.height = (model.content?.getLabHeight())! + 20
        
        refreshContentArr(model)
        
    }
    
    @IBAction func textCancleBtnTapped(_ sender: Any) {
        textEditView.isHidden = true
        textEditTF.resignFirstResponder()
    }
    
    func refreshContentArr(_ model:ArtCellModel){
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
    
}

extension UCreateArtViewController: UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    @IBAction func selectPhotoBtnTapped(_ sender: Any) {
        isAddingCell = true
        selectedIndexPath = getCellIndex(sender)
        
        showImgSelecter()
        
    }
    
    @IBAction func addPhotoBtnTapped(_ sender: Any) {
        isAddingCell = true
        selectedIndexPath = getCellIndex(sender)
        showCamera()
        
    }
    
    func showCamera()  {
        //各种权限：http://blog.csdn.net/tianxiawoyougood/article/details/56016630
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            //初始化图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            //指定图片控制器类型
            picker.sourceType = .camera
            //设置是否允许编辑
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: {
                () -> Void in
            })
        }else{
            print("打开相机错误")
        }
    }
    
    func showImgSelecter() {
        //判断设置是否支持图片库
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //初始化图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            //指定图片控制器类型
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //设置是否允许编辑
            picker.allowsEditing = true
            //弹出控制器，显示界面
            self.present(picker, animated: true, completion: {
                () -> Void in
            })
        }else{
            print("读取相册错误")
        }
    }
    
    //选择图片成功后代理
    @objc func imagePickerController(_ picker: UIImagePickerController,
                                     didFinishPickingMediaWithInfo info: [String : Any]) {
        //查看info对象
        //        print(info)
        
        //获取选取后的图片
        let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //转成jpg格式图片
        guard let jpegData = UIImageJPEGRepresentation(pickedImage, 0.5) else {
            return
        }
        //上传
        self.uploadImage(imageData: jpegData,img:pickedImage)
        
        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in
        })
    }
    
    //上传图片到服务器
    func uploadImage(imageData : Data,img:UIImage){
        var filename = "img-"+String(Date().timeIntervalSince1970)
        if !isAddingCell {
            filename = contentArr[(selectedIndexPath?.row)!].content!
        }
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                //采用post表单上传
                // 参数解释：
                //withName:类似协议名，和后台服务器的name要一致 ；fileName:可以充分利用写成用户的id，但是格式要写对； mimeType：规定的，要上传其他格式可以自行百度查一下
                multipartFormData.append(imageData, withName: "file", fileName: filename, mimeType: "image/jpeg")
                
        },to: imgServerPathUpload,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                //连接服务器成功后，对json的处理
                upload.responseJSON { response in
                    //解包
                    guard let result = response.result.value else { return }
                    print("json:\(result)")
                    
                    var model = ArtCellModel()
                    model.isImg = true
                    model.content = filename
                    model.height = UArtEditTableViewCellHeight+20
                    
                    self.refreshContentArr(model)
                }
                //获取上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    print("图片上传进度: \(progress.fractionCompleted)")
                }
            case .failure(let encodingError):
                //打印连接失败原因
                print(encodingError)
            }
        })
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
        let model = contentArr[(indexPath.row)]
        if beingEditing == true {
            return model.height!+50
        }
        return model.height!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        isAddingCell = false
        selectedIndexPath = indexPath
        let model = contentArr[(indexPath.row)]
        if model.isImg == true {
            showImgSelecter()
        }else{
            showEditView()
        }
        
        
    }
}




