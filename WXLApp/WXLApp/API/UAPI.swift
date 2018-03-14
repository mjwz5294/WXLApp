//
//  UAPI.swift
//  WXLApp
//
//  Created by mac on 2018/3/11.
//  Copyright © 2018年 mjwz5294. All rights reserved.
//

import Moya
import HandyJSON
import MBProgressHUD

let LoadingPlugin = NetworkActivityPlugin { (type, target) in
    guard let vc = topVC else { return }
    switch type {
    case .began:
        MBProgressHUD.hide(for: vc.view, animated: false)
        MBProgressHUD.showAdded(to: vc.view, animated: true)
    case .ended:
        MBProgressHUD.hide(for: vc.view, animated: true)
    }
}

let timeoutClosure = {(endpoint: Endpoint<UAPI>, closure: MoyaProvider<UAPI>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}
let provider = MoyaProvider<UAPI>()
let ApiProvider = MoyaProvider<UAPI>(requestClosure: timeoutClosure)
let ApiLoadingProvider = MoyaProvider<UAPI>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])

enum UAPI{
    //文章模块
    case getArts//获取文章列表
    case getArtWithId(artId: Int)//根据文章id获取文章
    case createArt(writer: String,title: String,contentStr: String)//创建文章
    case editArt(artId: Int,title: String,contentStr: String)//编辑文章
    case delArt(artId: Int)//删除文章
}

extension UAPI: TargetType {
    
    var baseURL: URL { return URL(string: "http://192.168.1.186:3000/")! }
    
    var path: String {
        switch self {
        case .getArts: return "api/articles/getArt"
        case .getArtWithId: return "api/articles/getArtWithId"
        case .createArt: return "api/articles/createArt"
        case .editArt: return "api/articles/editArt"
        case .delArt: return "api/articles/delArt"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createArt: return .post
        case .editArt: return .post
        case .delArt: return .post
        default: return .get
        }
        
    }
    var task: Task {
        var parmeters = ["model": UIDevice.current.modelName]
        switch self {
        case .getArtWithId(let artId):
            parmeters["artId"] = String(artId)
        case .createArt(let writer,let title,let contentStr):
            parmeters["writer"] = writer
            parmeters["title"] = title
            parmeters["contentStr"] = contentStr
        case .editArt(let artId,let title,let contentStr):
            parmeters["artId"] = String(artId)
            parmeters["title"] = title
            parmeters["contentStr"] = contentStr
        case .delArt(let artId):
            parmeters["artId"] = String(artId)
        default: break
        }
        
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
}


extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) throws -> T {
        let jsonString = String(data: data, encoding: .utf8)
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.jsonMapping(self)
        }
        return model
    }
}

extension MoyaProvider {
    @discardableResult
    open func request<T: HandyJSON>(_ target: Target,
                                    model: T.Type,
                                    completion: ((_ returnData: T?) -> Void)?) -> Cancellable? {
        
        return request(target, completion: { (result) in
            guard let completion = completion else { return }
            guard let returnData = try? result.value?.mapModel(ResponseData<T>.self) else {
                completion(nil)
                return
            }
            completion(returnData?.data?.returnData)
        })
    }
}



