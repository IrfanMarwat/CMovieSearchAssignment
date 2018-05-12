//
//  NetworkApiManager.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/12/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkError : Error {
    
    case customError(String)
    
    var localizedDescription: String {
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
    func requestData(configuration: APIConfiguration, showLoader: Bool = true ,completion: @escaping (_ response : Any?, _ error :NetworkError?) -> Void) {
        
        let string = NSMutableString(format:"%@%@","",configuration.urlRequest?.url?.absoluteString ?? "")
        
        print("URL -->%@",string)
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: configuration.parameters ?? [String:AnyObject](), options: .prettyPrinted)
            
            print("REQUEST -->%@",NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String )
            
        } catch {
            print(error.localizedDescription)
        }
        
        
        sessionManager.request(configuration).validate().responseJSON { jsonResp in
            guard jsonResp.result.error == nil else {
                completion(.none, NetworkError.customError(jsonResp.result.error!.localizedDescription))
                return
            }
            
            completion(jsonResp.data, .none)
        }
    }
}
