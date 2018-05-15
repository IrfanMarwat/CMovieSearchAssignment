//
//  Constants.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/11/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import Foundation

private enum Environment {
    case staging, production
    
    var baseURL: String {
        switch self {
        case .staging: return ""
        case .production: return ""
        }
    }
    
    var baseAPIURL: String {
        switch self {
        case .staging: return baseURL +  "http://api.themoviedb.org/"
        case .production: return baseURL + ""
        }
    }
    
    var environment : String {
        switch self {
        case .staging:
            return "Staging"
        case .production:
            return "Production"
        }
    }
}

struct Constants {

    fileprivate static var environment: Environment = .staging
    
    static var environ : String {
        return environment.environment
    }
    
    //MARK:- URLS
    static let BASE_URL = environment.baseURL
    static let BASE_API_URL = environment.baseAPIURL
    
    static let BASE_URL_IMAGE = "http://image.tmdb.org/t/p/"
    
    static let thumbnailSize = "w185"
    static let orignalImage = "original"
    static let ThrottlerTime = 0.4
    
    static let maxRecentItemCount = 10
    
    struct SegueIdentifiers {
        static let movieDetailSegue = "segueToDetail"
    }
    
    
    struct Keys {
        static let query = "query"
        static let page = "page"
        static let api_key = "api_key"
    }
}
