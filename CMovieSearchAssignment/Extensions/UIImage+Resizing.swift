//
//  UIImage+Resizing.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/13/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func resize(_ width: CGFloat = 0) -> UIImage {
        let w = width == 0 ? getScreenWidth() : width
        let scaledImage = self.af_imageAspectScaled(toFit: self.aspectFitSize(width: w))
        
        return scaledImage
    }
    
    func aspectFitSize(width: CGFloat) -> CGSize {
        
        let sourceImage = self
        let oldwidth = sourceImage.size.width
        let scaleFactor = width/oldwidth
        
        let newHeight = sourceImage.size.height * scaleFactor
        let newWidth = oldwidth * scaleFactor
        
        return CGSize(width: newWidth, height: newHeight)
        
    }
}
