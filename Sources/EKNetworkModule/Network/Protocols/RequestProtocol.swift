//
//  Request.swift
//  BaseProject
//
//  Created by Enes Karaosman on 21.09.2019.
//  Copyright © 2019 Enes Karaosman. All rights reserved.
//

import Foundation
import struct Alamofire.HTTPMethod

public protocol Request: Encodable {
    associatedtype Response: Decodable
    var endPoint: String { get set }
    var httpMethod: HTTPMethod { get set }
}
