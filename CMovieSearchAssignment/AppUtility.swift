//
//  AppUtility.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/13/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import Foundation
import UIKit

func downloadImage(_ imagePath: String, completion: @escaping (UIImage?, Bool) -> Void) {
    NetworkImageDownloader.shared.downlaodImageAtURLString(imagePath, withPlaceholder: "MovieDefault", imageIdentifier: "") { (image, success) in
        completion(image, success)
    }
}

func getScreenWidth()->CGFloat{
    let screenSize: CGRect = UIScreen.main.bounds
    return screenSize.width - 16
}
