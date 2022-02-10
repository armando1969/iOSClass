//
//  MovieCell.swift
//  MVPExample
//
//  Created by Consultant on 2/6/22.
//

import UIKit

class MovieCell: UITableViewCell {
    
    static let identifier = "MovieCell"

    @IBOutlet private weak var movieStackView: UIStackView!
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var movieTitle: UILabel!
    @IBOutlet private weak var movieDescription: UILabel!
    
    func configureCell(title: String?, overView: String?, image: Data?) {
        movieTitle.text = title
        movieDescription.text = overView
        
        guard let imageData = image else {
            return
        }
        movieImage.image = UIImage(data: imageData)
        
    }
    
}
