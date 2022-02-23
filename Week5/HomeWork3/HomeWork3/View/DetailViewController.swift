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
    
    private let viewModel = ViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var verticalStackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }()
    private lazy var verticalStackView2: UIStackView = {
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
        layout.itemSize = CGSize(width: 250, height: 80)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
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
    
    var originalTitle = String()
    var overView = String()
    var id = 0
    var image = Data()
    var isFavorite = Bool()
    var productionCo = [ProductionCompany]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        Binding()
        SetupUI()
    }
    @objc
    private func pressed() {
        if isFavorite == false {
            favoritesButton.backgroundColor = UIColor.gray
         //   favoritesButton.setTitle("Remove from Favorites", for: .normal)
            viewModel.setFavorite(id: id, title: originalTitle, overview: overView, image: image)
            isFavorite = true
        } else {
//            favoritesButton.setTitle("Add to Favorites", for: .normal)
//            favoritesButton.backgroundColor = UIColor.white
//            isFavorite = false
        }
    }
    
    private func SetupUI() {
        view.backgroundColor = .white
        
        originalTitleLabel.text = originalTitle
        overviewLabel.text = overView
        movieImageView.image = UIImage(data: image)
        navigationItem.title = originalTitle

        verticalStackView1.addArrangedSubview(originalTitleLabel)
        verticalStackView1.addArrangedSubview(overviewLabel)

        horizontalStackView.addArrangedSubview(movieImageView)
        horizontalStackView.addArrangedSubview(verticalStackView1)

        verticalStackView2.addArrangedSubview(favoritesButton)
        verticalStackView2.addArrangedSubview(productionTitleLabel)
        verticalStackView2.addArrangedSubview(collectionView)

        view.addSubview(horizontalStackView)
        view.addSubview(verticalStackView2)

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
    
    func Binding() {
        print("Here: \(id)")
        viewModel
            .$companies
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
            .store(in: &cancellables)
        viewModel.getProductionCompanies(id: id)
        print(productionCo.count)
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
        let image = viewModel.getProductionImageData(by: indexPath.row)
        cell.configureCell(productionCo: productionCo, imageData: image)
        return cell
    }
}
