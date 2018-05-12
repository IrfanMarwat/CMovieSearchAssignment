//
//  UIView+Addition.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/11/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    public class var nibName: String {
        let name = "\(self)".components(separatedBy: ".").first ?? ""
        return name
    }
    
    public class var nib: UINib? {
        if let _ = Bundle.main.path(forResource: nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: nil)
        } else {
            return nil
        }
    }
    
    func showActivityIndicatory() -> UIActivityIndicatorView {
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        actInd.center = center
        actInd.hidesWhenStopped = true
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.white
        addSubview(actInd)
        actInd.startAnimating()
        
        return actInd
    }
    
    func hideActivityIndicator() {
        let activityIndictor = self as? UIActivityIndicatorView
        activityIndictor?.stopAnimating()
    }
}
