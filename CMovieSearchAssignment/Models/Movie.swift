//
//  Movie.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/11/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import Foundation
import UIKit

struct Movie: Decodable {
    var id: Int = 0
    var voteCount: Int = 0
    var title: String = ""
    var releaseDate: String = ""
    var overview: String?
    var posterPath : String?
    var backDropPath: String?
    
    var movieImage: UIImage?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id", voteCount = "vote_count", title = "title", releaseDate = "release_date", overview = "overview", posterPath = "poster_path", backDropPath = "backdrop_path"
    }
}
