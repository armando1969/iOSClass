//
//  DetailViewController.swift
//  HomeWork3
//
//  Created by Consultant on 2/17/22.
//

import Foundation
import UIKit
import Combine

class DetailViewController: UIViewController {
    
    private let viewModel = ViewModel.shared
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var movieVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var productionVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var movieHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 10
        return stackView
    }()
    
    private let favoritesButton: UIButton = {
        let favoriteButton = UIButton()
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.setTitle("Add to Favorites", for: .normal)
        favoriteButton.titleLabel?.adjustsFontSizeToFitWidth = true
        favoriteButton.layer.cornerRadius = 9
        favoriteButton.layer.borderWidth = 1
        favoriteButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        favoriteButton.setTitleColor(UIColor.blue, for: .normal)
        return favoriteButton
    }()
    
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var originalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: 15)
        label.numberOfLines = 11
        label.textAlignment = .left
        return label
    }()
    
    private var collectionView: UICollectionView
    = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: (width/4))
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ProductionCell.self, forCellWithReuseIdentifier: ProductionCell.identifier)
        return collection
    }()
    
    private lazy var productionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.text = "Production Companies"
        return label
    }()
    
    var movie = Movie(id: 0, originalTitle: "", overview: "", posterPath: "", isFavorite: false, favoriteIndex: -1)
    var productionCo = [ProductionCompany]()
    var row: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if movie.isFavorite == true {
            favoritesButton.backgroundColor = UIColor.gray
            favoritesButton.setTitle("Remove from Favorites", for: .normal)
        } else {
            favoritesButton.setTitle("Add to Favorites", for: .normal)
            favoritesButton.backgroundColor = UIColor.white
        }
        collectionView.dataSource = self
        binding()
        setupUI()
    }
    @objc
    private func pressed() {
        if movie.isFavorite == false {
            favoritesButton.setTitle("Remove from Favorites", for: .normal)
            favoritesButton.backgroundColor = UIColor.gray
            movie.isFavorite = true
            viewModel.setFavoriteMovie(id: movie.id, title: movie.originalTitle, overview: movie.overview, posterPath: movie.posterPath, isFavorite: movie.isFavorite)
        } else {
            favoritesButton.setTitle("Add to Favorites", for: .normal)
            favoritesButton.backgroundColor = UIColor.white
            movie.isFavorite = false
            viewModel.deleteFavoriteMovie(id: movie.id)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.topItem?.backButtonTitle = "Movie"
        navigationItem.title = movie.originalTitle
        
        originalTitleLabel.text = movie.originalTitle
        overviewLabel.text = movie.overview
        viewModel.getImageData(movie.posterPath) { data in
            DispatchQueue.global().async {
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.movieImageView.image = image  }
        }   }   }

        movieVStackView.addArrangedSubview(originalTitleLabel)
        movieVStackView.addArrangedSubview(overviewLabel)

        movieHStackView.addArrangedSubview(movieImageView)
        movieHStackView.addArrangedSubview(movieVStackView)

        productionVStackView.addArrangedSubview(favoritesButton)
        productionVStackView.addArrangedSubview(productionTitleLabel)
        productionVStackView.addArrangedSubview(collectionView)

        view.addSubview(movieHStackView)
        view.addSubview(productionVStackView)

        //the stack constraints
        
        let safeArea = view.safeAreaLayoutGuide
        
        //image constraints
        movieImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
        movieImageView.widthAnchor.constraint(equalTo: movieImageView.heightAnchor, multiplier: 3/4).isActive = true
        // title constraints
        originalTitleLabel.topAnchor.constraint(equalTo: movieImageView.topAnchor).isActive = true
        originalTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10).isActive = true
        originalTitleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20).isActive = true
        //overview constraints
        overviewLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10).isActive = true
        overviewLabel.topAnchor.constraint(equalTo: originalTitleLabel.bottomAnchor, constant: 10).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true
        //button constraints
        favoritesButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 220).isActive = true
        favoritesButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20).isActive = true
        favoritesButton.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 20).isActive = true
        // production title constraints
        productionTitleLabel.topAnchor.constraint(equalTo: favoritesButton.bottomAnchor, constant: 40).isActive = true
        productionTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20).isActive = true
        // collectionview constraints
        collectionView.topAnchor.constraint(equalTo: productionTitleLabel.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func binding() {
        viewModel
            .$companies
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
            .store(in: &cancellables)
        viewModel.getProductionCompanies(id: movie.id)
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.companies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductionCell.identifier, for: indexPath) as? ProductionCell
         else {
            return UICollectionViewCell()  }
        let productionCo = viewModel.companies[indexPath.row].name
        let image = "https://image.tmdb.org/t/p/original\(viewModel.companies[indexPath.row].logoPath)"
        cell.configureCell(productionCo: productionCo, imageData: image)
        return cell
    }
}
