//
//  MovieSearchResponse.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/12/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import Foundation

struct MovieSearchResponse: Decodable {
    var page: Int = 0
    var totalResults: Int?
    var totalPages: Int = 0
    var movies: [Movie]?
    
    private var hasNextPage: Bool {
        return totalPages > page
    }
    
    var nextPage: Int? {
        if hasNextPage {
            return page + 1
        }
        return nil
    }
    
    private enum CodingKeys: String, CodingKey {
        case page = "page", totalResults = "total_results", totalPages = "total_pages", movies = "results"
    }
    
    static func searchWith(_ searchText: String, pageNumber: Int = 1, completion: @escaping (_ error: NetworkError?, _ reponse: MovieSearchResponse?)->()) {
        let router = MovieRouter(endpoint: .searchMovie(searchText: searchText, pageNumber: pageNumber))
        NetworkApiManager.shared.requestData(configuration: router) { (result, error) in
            
            guard error == nil else {
                return completion(error, nil)
            }
            
            guard result != nil else {
                return  completion(NetworkError.customError("Data not found"), nil)
            }
            let data = result as? Data
            
            guard data != nil else {
                completion(NetworkError.customError("Unable to parse json."), nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            let decodedResponse = try? jsonDecoder.decode(MovieSearchResponse.self, from: data!)
            
            guard decodedResponse != nil else {
                return completion(NetworkError.customError("Data not found"), nil)
            }
            
            completion(nil, decodedResponse)
        }
    }
}
