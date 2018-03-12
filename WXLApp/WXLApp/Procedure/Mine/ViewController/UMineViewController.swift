//
//  UMineViewController.swift
//  WXLApp
//
//  Created by mac on 2018/3/6.
//  Copyright © 2018年 mjwz5294. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import Photos

class UMineViewController: UBaseViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var uploadImgView: UIImageView!
    
    //let imageURL = URL(string: "http://ww1.sinaimg.cn/large/92ce04b2gy1fgapuwrc3nj23gq2g6twu.jpg")
    let imageURL1 = URL(string: "http://192.168.0.160:3001/downloadImg/test.jpg")
    let imageURL2 = URL(string: "http://192.168.0.160:3001/downloadImg/test1.jpg")
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
    @IBAction func uploadImg(_ sender: Any) {
        
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
        uploadImgView.image = pickedImage
        //转成jpg格式图片
        guard let jpegData = UIImageJPEGRepresentation(pickedImage, 0.5) else {
            return
        }
        //上传
        self.uploadImage(imageData: jpegData)
        
        
        //图片控制器退出
        picker.dismiss(animated: true, completion: {
            () -> Void in
        })
    }
    
    //上传图片到服务器
    func uploadImage(imageData : Data){
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                //采用post表单上传
                // 参数解释：
                //withName:和后台服务器的name要一致 ；fileName:可以充分利用写成用户的id，但是格式要写对； mimeType：规定的，要上传其他格式可以自行百度查一下
                multipartFormData.append(imageData, withName: "file", fileName: "123456.jpg", mimeType: "image/jpeg")
                //如果需要上传多个文件,就多添加几个
                //multipartFormData.append(imageData, withName: "file", fileName: "123456.jpg", mimeType: "image/jpeg")
                //......
                
        },to: "http://192.168.0.160:3001/uploadimage",encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                //连接服务器成功后，对json的处理
                upload.responseJSON { response in
                    //解包
                    guard let result = response.result.value else { return }
                    print("json:\(result)")
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
    
    @IBAction func testApi(_ sender: Any) {
        
//        ApiLoadingProvider.request(UAPI.getArts, model: ArtArrModel.self) { (returnData) in
//
//        }
        
//        ApiLoadingProvider.request(UAPI.getArtWithId(artId:2), model: ArtModel.self) { (returnData) in
//
//        }
        
//        ApiLoadingProvider.request(UAPI.createArt(writer: "writer2",title: "title2",contentStr: "contentStr2"), model: ArtModel.self) { (returnData) in
//            
//        }delArt(artId: Int)
        
//        ApiLoadingProvider.request(UAPI.editArt(artId: 4,title: "title3",contentStr: "contentStr3"), model: ArtModel.self) { (returnData) in
//
//        }
        
//        ApiLoadingProvider.request(UAPI.delArt(artId: 4), model: ArtModel.self) { (returnData) in
//            
//        }
        
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






