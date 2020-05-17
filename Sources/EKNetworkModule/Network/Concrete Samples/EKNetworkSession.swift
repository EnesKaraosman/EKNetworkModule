//
//  Session.swift
//  BaseProject
//
//  Created by Enes Karaosman on 22.09.2019.
//  Copyright © 2019 Enes Karaosman. All rights reserved.
//

import Foundation
import Alamofire

class EKNetworkSession {
    
    static let shared = EKNetworkSession()
    
    func getHeaders() -> HTTPHeaders {
        return [
            .accept("application/json")
        ]
    }
    
    private init() { }
    
}
