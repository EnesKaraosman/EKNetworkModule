//
//  Session.swift
//  BaseProject
//
//  Created by Enes Karaosman on 22.09.2019.
//  Copyright © 2019 Enes Karaosman. All rights reserved.
//

import Foundation
import Alamofire

class NetworkSession {
    
    static let shared = NetworkSession()
    
    var Authorization: String? = "" // Consider using .authenticate on AF.request
    var userName: String = "" // Taken from Auth service
    
    func getHeaders() -> HTTPHeaders {
        return [
//          .authorization(username: "Username", password: "Password"),
//          .authorization(bearerToken: ""),
            .accept("application/json")
        ]
    }
    
    private init() { }
    
}
