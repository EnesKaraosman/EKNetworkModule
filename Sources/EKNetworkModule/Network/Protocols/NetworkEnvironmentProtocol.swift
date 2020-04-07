//
//  NetworkEnvironmentProtocol.swift
//  
//
//  Created by Enes Karaosman on 6.04.2020.
//

import Foundation

public protocol NetworkEnvironmentProtocol: class {
    var baseUrl: String { get }
    var timeInterval: TimeInterval { get }
}
