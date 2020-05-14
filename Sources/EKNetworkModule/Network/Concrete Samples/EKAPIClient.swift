//
//  ApiClient.swift
//
//  Created by Enes Karaosman on 21.09.2019.
//  Copyright © 2020 Enes Karaosman. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class EKAPIClient: APIClientProtocol {
    
    public var networkEnvironment: NetworkEnvironmentProtocol!
    public var networkInterceptor: NetworkInterceptorProtocol?
    
    public static var shared = EKAPIClient(networkInterceptor: EKNetworkInterceptor())
    
    required public init(networkInterceptor: NetworkInterceptorProtocol?) {
        self.networkInterceptor = networkInterceptor
    }
    
    /// Simply create your request by confirming Request protocol, then execute.
    public func execute<T: Request>(
        request: T,
        success: @escaping (T.Response) -> Void,
        failure: @escaping (APIError) -> Void
    ) {
        
        guard let baseUrl = self.getBaseUrl() else {
            print("‼️ Error: Environment not configured!")
            failure(.custom(message: "Environment not configured!"))
            return
        }
        
        let path = baseUrl.appending(request.endPoint)
        
        guard let parameters = getParameters(request: request) else {
            failure(.custom(message: "‼️ Request parameter serialization failed!"))
            return
        }
        
        defer { self.flushTempBaseUrl() }
        
        AF.request(
            path,
            method: request.httpMethod,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: EKNetworkSession.shared.getHeaders(),
            requestModifier: { $0.timeoutInterval = self.networkEnvironment.timeInterval }
        )
        .validate()
        .responseDecodable(of: T.Response.self, completionHandler: { (responseData) in
            
            switch responseData.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                failure(.network(internal: error))
            }
            
        })
        
    }
    
    /// Just feed your endPoint, then parse your JSON response, if not fails :) .
    public func executeGET<T: Decodable>(
        endPoint: String,
        success: @escaping (T) -> Void,
        failure: @escaping (APIError) -> Void
    ) {
        
        guard let baseUrl = self.getBaseUrl() else {
            print("‼️ Error: Environment not configured!")
            failure(.custom(message: "Environment not configured!"))
            return
        }
        
        let path = baseUrl.appending(endPoint)
        
        defer { self.flushTempBaseUrl() }
        
        AF.request(
            path,
            method: .get,
            encoding: JSONEncoding.default,
            headers: EKNetworkSession.shared.getHeaders(),
            requestModifier: { $0.timeoutInterval = self.networkEnvironment.timeInterval }
        )
        .validate()
        .responseDecodable(of: T.self) { (responseData) in
            
            switch responseData.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                failure(.network(internal: error))
            }
                
        }
        
    }
    
    /// Prefer in case you do want to parse JSON manually.
    public func executeWithoutMapping<T: Request>(
        request: T,
        success: @escaping (JSON) -> Void,
        failure: @escaping (APIError) -> Void
    ) {
        
        guard let baseUrl = self.getBaseUrl() else {
            print("‼️ Error: Environment not configured!")
            failure(.custom(message: "Environment not configured!"))
            return
        }
        
        let path = baseUrl.appending(request.endPoint)
        
        guard let parameters = getParameters(request: request) else {
            failure(.custom(message: "‼️ Request parameter serialization failed!"))
            return
        }
        
        defer { self.flushTempBaseUrl() }
        
        AF.request(
            path,
            method: request.httpMethod,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: EKNetworkSession.shared.getHeaders(),
            requestModifier: { $0.timeoutInterval = self.networkEnvironment.timeInterval }
        )
        .validate()
        .responseJSON { (responseObject) in
            
            switch responseObject.result {
            case .success(let value):
                let json = JSON(value)
                success(json)
            case .failure(let error):
                failure(.network(internal: error))
            }
        }
        
    }
    
    private func getParameters<T: Request>(request: T) -> [String: Any]? {
        if let data = try? JSONEncoder().encode(request) {
            if let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                return dict
            }
            print("‼️ Error: JSONSerialization failed!")
        }
        print("‼️ Error: JSONEncoder failed to resolve request!")
        return nil
    }
    
    public func ovverideBaseUrlOnce(baseUrl: String) -> APIClientProtocol {
        (self.networkEnvironment as? EKNetworkEnvironment)?.tempBaseUrl = baseUrl
        return self
    }
    
    private func getBaseUrl() -> String? {
        
        if let tempBaseUrl = (self.networkEnvironment as? EKNetworkEnvironment)?.tempBaseUrl {
            return tempBaseUrl
        } else {
            return self.networkEnvironment?.baseUrl
        }
        
    }
    
    private func flushTempBaseUrl() {
        (self.networkEnvironment as? EKNetworkEnvironment)?.tempBaseUrl = nil
    }
        
}
