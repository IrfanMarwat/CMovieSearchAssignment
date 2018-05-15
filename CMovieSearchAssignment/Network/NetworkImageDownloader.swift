//
//  NetworkImageDownloader.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/12/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class NetworkImageDownloader {
    
    /// Download
    ///
    /// - Parameters:
    ///   - imageName: Image Name
    ///   - filter: Filter type(optional)
    ///   - completion: return UIImage if downloaded else error
    
    static let shared = NetworkImageDownloader()
    
    let downloader = ImageDownloader(configuration: ImageDownloader.defaultURLSessionConfiguration(), downloadPrioritization: .fifo, maximumActiveDownloads: 4)

    
    func downlaodImageAtURLString(_ string : String, withPlaceholder placeholderName:String, imageIdentifier:String = "", completion: @escaping (Image, Bool)-> Void){
        
        let URLRequest = Foundation.URLRequest(url: URL(string: string)!)
        
        downloader.download(URLRequest) { response in
            if let image = response.result.value {
                DispatchQueue.main.async {
                    completion(image,response.response == nil ? false:true)
                }
            }
            else{
                DispatchQueue.global(qos: .background).async {
                    let image = UIImage(named: placeholderName)!
                    DispatchQueue.main.async {
                        completion(image,false)
                    }
                }
            }
        }
    }
}
