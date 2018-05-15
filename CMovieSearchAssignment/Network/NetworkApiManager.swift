//
//  NetworkApiManager.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/12/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import Foundation
import Alamofire
import NotificationBannerSwift

enum NetworkError : Error {
    
    case customError(String)
    
    var errorDescription: String {
        switch self {
        case .customError(let error):
            return error
        }
    }
}

class NetworkApiManager {
    
    let sessionManager : SessionManager  = {
        
        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .useProtocolCachePolicy
        configuration.httpAdditionalHeaders = defaultHeaders
        
        return SessionManager(configuration: configuration)
    }()

    
    static let shared = NetworkApiManager()
    typealias completion = (_ response : Any?, _ error :NetworkError) -> Void
}

// MARK: - Request
extension NetworkApiManager {
    
    /// Call Server for Data depending upon APIConfiguration
    ///
    /// - Parameters:
    ///   - configuration: Request Type i.e Get/Post/Put.. , Path, Parameters
    ///   - completion: callback after receiving response
    func requestData(configuration: APIConfiguration ,completion: @escaping (_ response : Any?, _ error :NetworkError?) -> Void) {
        
        if !Reachability.isConnectedToNetwork() {
            return completion(nil, NetworkError.customError("No Internet Connection"))
        }
        
        let string = NSMutableString(format:"%@%@","",configuration.urlRequest?.url?.absoluteString ?? "")
        
        print("URL --> \(string)")
        
        sessionManager.request(configuration).validate().responseJSON { jsonResp in
            guard jsonResp.result.error == nil else {
                completion(.none, NetworkError.customError(jsonResp.result.error!.localizedDescription))
                return
            }
            
            completion(jsonResp.data, .none)
        }
    }
}
