//
//  NetworkInterceptor.swift
//  BaseProject
//
//  Created by Enes Karaosman on 20.02.2020.
//  Copyright © 2020 Enes Karaosman. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class EKNetworkInterceptor: NetworkInterceptorProtocol {
    
    public func onBeforeRequest() {
        print("onBeforeRequest")
    }
    
    public func onRequest(request: DataRequest) -> DataRequest {
        print("onRequest")
        return request
    }
    
    public func onRequestSuccess(data: Data) -> Data {
        print("onRequestSuccess")
        return data
    }
    
    public func onRequestSuccess(json: JSON) -> JSON {
        print("onRequestSuccess")
        return json
    }
    
    public func onRequestFailure(error: Error) -> Error {
        print("‼️ Error: onRequestFailure")
        return error
    }
    
    public func onRequestComplete(response: DataResponse<Data, APIError>) {
        print("onRequestComplete")
    }
    
    public func onRequestComplete(response: DataResponse<Any, APIError>) {
        print("onRequestComplete")
    }
    
}
