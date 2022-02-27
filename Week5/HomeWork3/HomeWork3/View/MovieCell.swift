//
//  MovieCell.swift
//  HomeWork3
//
//  Created by Consultant on 2/17/22.
//

import UIKit

class MovieCell: UITableViewCell {
    
    static let identifier = "MovieCell"
    private let viewModel = ViewModel()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var checkMarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Check-mark-icon")
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var originalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: 13)
        label.numberOfLines = 4
        label.textAlignment = .left
        return label
    }()
    
    private let detailButton: UIButton = {
        let favoriteButton = UIButton()
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.setTitle("Show Details", for: .normal)
        favoriteButton.titleLabel?.font = UIFont(name: "Arial", size: 15)
        favoriteButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        favoriteButton.setTitleColor(UIColor.blue, for: .normal)
        return favoriteButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func pressed() {
//        if movie.isFavorite == false {
//            favoritesButton.backgroundColor = UIColor.gray
//            favoritesButton.setTitle("Remove from Favorites", for: .normal)
//            movie.isFavorite = true
//            viewModel.setFavoriteMovie(id: movie.id, title: movie.originalTitle, overview: movie.overview, isFavorite: movie.isFavorite)
//        } else {
//            favoritesButton.setTitle("Add to Favorites", for: .normal)
//            favoritesButton.backgroundColor = UIColor.white
//            movie.isFavorite = false
//            viewModel.deleteFavoriteMovie(id: movie.id)
//        }
    }
    
    func configureCell(title: String, overview: String, imageData: String!, isFavorite: Bool) {
        originalTitleLabel.text = title
        overviewLabel.text = overview
        viewModel.getImageData(imageData) { data in
            DispatchQueue.global().async {
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.movieImageView.image = image  }
        }   }  }
        if isFavorite == true {
            checkMarkImageView.isHidden = false
        } else {
            checkMarkImageView.isHidden = true
        }
    }
    
    func configureCellImage(image: Data?) {
        if let imageData = image {
            let image = UIImage(data: imageData)
            movieImageView.image = image
        }
    }
    
    private func setUpUI() {
        verticalStackView.addArrangedSubview(originalTitleLabel)
        verticalStackView.addArrangedSubview(overviewLabel)
        verticalStackView.addArrangedSubview(detailButton)
        
        horizontalStackView.addArrangedSubview(movieImageView)
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(checkMarkImageView)
        
        contentView.addSubview(horizontalStackView)
        
        //the stack constraints
        let safeArea = contentView.safeAreaLayoutGuide
        horizontalStackView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        detailButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -50).isActive = true
        verticalStackView.spacing = 5
        horizontalStackView.spacing = 10
        
        movieImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        checkMarkImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        checkMarkImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
