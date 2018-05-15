//
//  MovieDetailViewController.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/12/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

/*
  A movie detail class, A 'Movie' object must be passed before loading. Only show detail of movie.
 */

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: Movie!
    
    @IBOutlet weak var imageViewMovie: UIImageView!
    @IBOutlet weak var labelReview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    deinit {
        print("thanks")
    }
    
    func setUpUI() {
        if let imageName = movie.posterPath?.replacingOccurrences(of: "'\'", with: "") {
            let imageFullPath = Constants.BASE_URL_IMAGE + Constants.orignalImage + imageName
            let activityIndicator = imageViewMovie.showActivityIndicatory()
            downloadImage(imageFullPath) { (image, success) in
                activityIndicator.hideActivityIndicator()
                if let image = image?.resize() {
                    self.imageViewMovie.image = image
                }
            }
        }
        
        setCustomTitle(movie.title)
        labelReview.text = movie.overview
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
