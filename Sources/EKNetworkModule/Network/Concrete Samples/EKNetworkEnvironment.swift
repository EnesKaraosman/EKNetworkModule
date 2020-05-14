//
//  Environment.swift
//  BaseProject
//
//  Created by Enes Karaosman on 21.09.2019.
//  Copyright © 2019 Enes Karaosman. All rights reserved.
//

import Foundation

public class EKNetworkEnvironment: NetworkEnvironmentProtocol {
    
    public let baseUrl: String
    public var tempBaseUrl: String?
    public let timeInterval: TimeInterval
    
    public init(baseUrl: String, timeInterval: TimeInterval = 20) {
        self.baseUrl = baseUrl
        self.timeInterval = timeInterval
    }
    
}
