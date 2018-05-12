//
//  UIViewController+Addition.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/12/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import Foundation

import UIKit

typealias AlertCompletionHandler =  ((_ completed: Bool) -> Void)?

extension UIViewController {
    
    func showAlertWithTitle( title:String?, message:String, okButtonTitle: String = "Ok", cancelButtonTitle: String?, response : AlertCompletionHandler = .none) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(okAction)
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: okButtonTitle, style: .default, handler: { (action) in
            
            alertController.dismiss(animated: true, completion: nil)
            
            if let okResponse = response {
                okResponse(false)
            }
        })
        
        alertController.addAction(ok)
        
        let cancel = UIAlertAction(title: cancelButtonTitle , style: .cancel, handler: {(cancel) in
            alertController.dismiss(animated: true, completion: nil)
            if let cancelResponse = response {
                cancelResponse(true)
            }
        })
        
        alertController.addAction(cancel)
        
        DispatchQueue.main.async {
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}
