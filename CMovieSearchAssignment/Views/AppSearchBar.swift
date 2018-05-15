//
//  AppSearchBar.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/11/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import Foundation
import UIKit

class AppSearchBar: UISearchBar {
    
    let TextFieldHight: CGFloat = 35
    
    internal var placeHolderTextField: UITextField!
    internal var cancelButtonWidth: CGFloat!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        placeHolderTextField = self.value(forKey: "searchField") as! UITextField
        placeHolderTextField.backgroundColor = .white
        placeHolderTextField.layer.masksToBounds = true
        placeHolderTextField.textColor = .black
        placeHolderTextField.font = UIFont(name: "HelveticaNeue", size: 13.0)
        
        let cancelButtonAttributes: NSDictionary =
            [
                NSAttributedStringKey.foregroundColor: UIColor.black,
                NSAttributedStringKey.font:    UIFont(name: "HelveticaNeue", size: 13.0)!
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(cancelButtonAttributes as? [NSAttributedStringKey : Any], for: .normal)
        
        showsCancelButton = false
        backgroundColor = .clear
        backgroundImage = UIImage()
        
        setPositionAdjustment(UIOffset(horizontal: 8, vertical: -2), for: .search)
        setPositionAdjustment(UIOffset(horizontal: -8, vertical: 0), for: .clear)
        searchTextPositionAdjustment = UIOffset(horizontal: 0, vertical: 1)
        
        let searchIcon = #imageLiteral(resourceName: "searchgrey")
        setImage(searchIcon, for: .search, state: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cancelButtonWidth = self.frame.size.width - placeHolderTextField.frame.size.width
        
        placeHolderTextField.frame = CGRect.init(x: 0, y: 0, width: placeHolderTextField.frame.size.width + 16 , height: TextFieldHight)
        placeHolderTextField.layer.cornerRadius = 18
    }
    
    func cancelShown() {
        placeHolderTextField.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: TextFieldHight)
        self.setPositionAdjustment(UIOffset(horizontal: 8, vertical: 0), for: .search)
        
        self.setShowsCancelButton(true, animated: true)
    }
    
    func cancelHidden() {
        placeHolderTextField.frame = CGRect.init(x: 0, y: 0, width: placeHolderTextField.frame.size.width, height: TextFieldHight)
        
        self.setShowsCancelButton(false, animated: true)
    }
}
