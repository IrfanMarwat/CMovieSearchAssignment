//
//  MovieTableViewCell.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/11/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewMovie: UIImageView!
    @IBOutlet weak var labelMovieName: UILabel!
    @IBOutlet weak var labelMovieReview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageViewMovie.image = #imageLiteral(resourceName: "movie_thumbnail_placeholder")
        labelMovieName.text = ""
        labelMovieReview.text = ""
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureWith(_ movie: Movie) {
        if let image = movie.movieImage {
            imageViewMovie.image = image
        } else {
            if let imageName = movie.posterPath?.replacingOccurrences(of: "'\'", with: "") {
                let imageFullPath = Constants.BASE_URL_IMAGE + Constants.thumbnailSize + imageName
                imageViewMovie.downloadImage(imageFullPath) { (success) in}
            }

        }
        if movie.releaseDate.count > 0 {
            labelMovieName.text = movie.title + " (\(movie.releaseDate))"
        } else {
            labelMovieName.text = movie.title
        }
        
        labelMovieReview.text = movie.overview
    }
}
