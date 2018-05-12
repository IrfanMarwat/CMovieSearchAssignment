//
//  UIImageView+ImageDownload.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/12/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImage(_ imgUrl: String,completion: @escaping (Bool) -> Void) {
        
        image = UIImage(named: "MovieDefault")
        let activityIndicator = showActivityIndicatory()
        
        NetworkImageDownloader.shared.downlaodImageAtURLString(imgUrl, withPlaceholder: "MovieDefault", imageIdentifier: "") { (image, success) in
            
            activityIndicator.hideActivityIndicator()
            self.image = image
            completion(success)
        }
    }
}
