//
//  BaseRouter.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/12/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import Foundation

import Foundation
import Alamofire

public typealias JSONDictionary = [String: Any]
typealias APIParams = [String : Any]?

protocol BaseURL {
    var baseUrl: String { get }
}

extension BaseURL {
    
    var baseUrl: String {
        return Constants.BASE_API_URL
    }
    
    func baseAPIURL() throws -> URL {
        return try (self.baseUrl + "").asURL()
    }
}

protocol APIConfiguration : URLRequestConvertible, BaseURL{
    var method: Alamofire.HTTPMethod { get }
    var path: String { get }
    var parameters: APIParams { get }
    var timeout: TimeInterval {get}
    
    var API_KEY : String? { get }
    var OAuthToken : String? { get }
}

// MARK: URLRequestConvertible

extension APIConfiguration {
    
    var OAuthToken : String? {
        return nil
    }
    
    var timeout: TimeInterval {
        return 120
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try baseAPIURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        if let access_token = OAuthToken {
            urlRequest.setValue(access_token , forHTTPHeaderField: "X-Token")
        }
        
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        
        urlRequest.timeoutInterval = timeout
        
        return urlRequest
    }
}
