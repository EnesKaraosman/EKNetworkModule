//
//  Session.swift
//  BaseProject
//
//  Created by Enes Karaosman on 22.09.2019.
//  Copyright © 2019 Enes Karaosman. All rights reserved.
//

import Foundation
import Alamofire

public class EKNetworkSession {
    
    public static let shared = EKNetworkSession()
    
    public var headers: HTTPHeaders = [
        .accept("application/json")
    ]
    
    public func getHeaders() -> HTTPHeaders {
        return headers
    }
    
    private init() { }
    
}
