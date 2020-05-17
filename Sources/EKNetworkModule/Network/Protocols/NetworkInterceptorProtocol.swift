//
//  INetworkInterceptor.swift
//  BaseProject
//
//  Created by Enes Karaosman on 20.02.2020.
//  Copyright © 2020 Enes Karaosman. All rights reserved.
//

import protocol Alamofire.RequestInterceptor
import struct SwiftyJSON.JSON

public protocol NetworkInterceptorProtocol: RequestInterceptor {
    func onBeforeRequest()
    func onRequestCompleted()
}
