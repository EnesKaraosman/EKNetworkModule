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
    
    public func onRequestCompleted() {
        print("onRequestCompleted")
    }
    
}
