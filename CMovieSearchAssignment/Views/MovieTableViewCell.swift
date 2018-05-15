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
    @IBOutlet weak var labelMovieReleaseDate: UILabel!
    @IBOutlet weak var labelMovieReview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageViewMovie.image = nil
        labelMovieName.text = ""
        labelMovieReleaseDate.text = ""
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
        labelMovieName.text = movie.title
        labelMovieReleaseDate.text = movie.releaseDate
        labelMovieReview.text = movie.overview
    }
}
