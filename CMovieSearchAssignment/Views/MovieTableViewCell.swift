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
        labelMovieName.text = movie.name
        labelMovieReleaseDate.text = movie.releaseDate
        labelMovieReview.text = movie.review
    }
}
