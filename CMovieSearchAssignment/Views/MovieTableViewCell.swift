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
    @IBOutlet weak var labelMovieReview: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureWith(_ movie: Movie) {
        if let imageName = movie.posterPath?.replacingOccurrences(of: "'\'", with: "") {
            let imageFullPath = Constants.BASE_URL_IMAGE + Constants.thumbnailSize + imageName
            imageViewMovie.downloadImage(imageFullPath) { (success) in}
        }
        labelMovieName.text = movie.title
        labelMovieReleaseDate.text = movie.releaseDate
        labelMovieReview.text = movie.overview
    }
}
