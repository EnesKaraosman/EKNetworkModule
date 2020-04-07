//
//  Environment.swift
//  BaseProject
//
//  Created by Enes Karaosman on 21.09.2019.
//  Copyright © 2019 Enes Karaosman. All rights reserved.
//

import Foundation

public class NetworkEnvironment: NetworkEnvironmentProtocol {
    
    let baseUrl: String
    let timeInterval: TimeInterval
    
    init(baseUrl: String, timeInterval: TimeInterval = 20) {
        self.baseUrl = baseUrl
        self.timeInterval = timeInterval
    }
    
}
