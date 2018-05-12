//
//  Movie.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/11/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    var id: Int = 0
    var voteCount: Int = 0
    var title: String = ""
    var releaseDate: String = ""
    var overview: String?
    var posterPath : String?
    var backDropPath: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", voteCount = "vote_count", title = "title", releaseDate = "release_date", overview = "overview", posterPath = "poster_path", backDropPath = "backdrop_path"
    }
}

//extension Movie: Decodable {
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decode(Int.self, forKey: CodingKeys.id)
//        voteCount = try values.decode(Int.self, forKey: CodingKeys.id)
//        title = try values.decode(String.self, forKey: CodingKeys.title)
//        releaseDate = try values.decode(String.self, forKey: CodingKeys.releaseDate)
//        if releaseDate.count <= 0 {
//            throw DecodingError.valueNotFound(String.self, DecodingError.Context(codingPath: [CodingKeys.releaseDate], debugDescription: "Release date cannot be empty"))
//        }
//        overview = try values.decode(String.self, forKey: CodingKeys.overview)
//        posterPath = try values.decode(String.self, forKey: CodingKeys.posterPath)
//        backDropPath = try values.decode(String.self, forKey: CodingKeys.backDropPath)
//    }
//}
