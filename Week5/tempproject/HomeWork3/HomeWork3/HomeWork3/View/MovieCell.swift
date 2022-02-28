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
    
    private lazy var verticalStackView1: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
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
        imageView.image = UIImage(named: "check-mark")
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var rightArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow")
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
        label.numberOfLines = 5
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        verticalStackView1.addArrangedSubview(originalTitleLabel)
        verticalStackView1.addArrangedSubview(overviewLabel)
    //    verticalStackView1.addArrangedSubview(detailButton)
        
        verticalStackView2.addArrangedSubview(rightArrowImageView)
        verticalStackView2.addArrangedSubview(checkMarkImageView)
        
        horizontalStackView.addArrangedSubview(movieImageView)
        horizontalStackView.addArrangedSubview(verticalStackView1)
        horizontalStackView.addArrangedSubview(verticalStackView2)
        
        contentView.addSubview(horizontalStackView)
        
        //the stack constraints
        let safeArea = contentView.safeAreaLayoutGuide
        horizontalStackView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10).isActive = true
    //    detailButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -50).isActive = true
        verticalStackView1.spacing = 5
        horizontalStackView.spacing = 10
        
        movieImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        checkMarkImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        checkMarkImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        rightArrowImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 40).isActive = true
        rightArrowImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        rightArrowImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
