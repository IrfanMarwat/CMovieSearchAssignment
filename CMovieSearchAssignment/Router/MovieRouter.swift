//
//  MovieRouter.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/12/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import Foundation
import Alamofire

enum MovieEndPoint {
    case searchMovie(searchText: String, pageNumber: Int)
}

struct MovieRouter {
    let endpoint: MovieEndPoint
}


// MARK: - APIConfiguration
extension MovieRouter : APIConfiguration {
    var API_KEY: String? {
        return "2696829a81b1b5827d515ff121700838"
    }
    
    
    var method: HTTPMethod {
        switch endpoint {
        case .searchMovie:
            return .get
        }
    }
    
    var OAuthToken: String? {
        return nil
    }
    
    var path: String {

        switch endpoint {
        case .searchMovie:
            return "3/search/movie"
        }
    }
    
    var parameters: APIParams {
        switch endpoint {
        case .searchMovie(let searchText, let pageNumber):
            return [Constants.Keys.query: searchText, Constants.Keys.page: pageNumber, Constants.Keys.api_key: API_KEY ?? ""]
        }
    }
}

