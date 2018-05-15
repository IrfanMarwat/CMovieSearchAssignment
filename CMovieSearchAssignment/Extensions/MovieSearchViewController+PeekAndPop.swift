//
//  MovieSearchViewController+PeekAndPop.swift
//  CMovieSearchAssignment
//
//  Created by Mac iOS on 5/15/18.
//  Copyright © 2018 Irfan. All rights reserved.
//

/*
    3D force Touch on Movie in Movie list will results in peek and pop preview thanks to this extension. Force touch is only available for Movie list not on recent search.
 */

import Foundation
import UIKit

// MARK: - <#UIViewControllerPreviewingDelegate#>
extension MovieSearchViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let detailVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        guard tableViewMovies.dataSource is MovieTableViewDatasource else {
            return nil
        }
        guard let indexPath =  tableViewMovies.indexPathForRow(at: location) else {
            return nil
        }
        let movie = movieTableViewDatasource.datasource[indexPath.row]
        detailVc.movie = movie
        
        return detailVc
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: nil)
    }
}
