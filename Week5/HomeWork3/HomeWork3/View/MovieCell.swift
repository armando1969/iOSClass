//
//  MovieCell.swift
//  HomeWork3
//
//  Created by Consultant on 2/17/22.
//

import UIKit

class MovieCell: UITableViewCell {
    
    static let identifier = "MovieCell"
    
    private lazy var verticalStackView1: UIStackView = {
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(title: String, overview: String, imageData: Data?) {
        originalTitleLabel.text = title
        overviewLabel.text = overview
        if let imageData = imageData {
            let image = UIImage(data: imageData)
            movieImageView.image = image
        }
    }
    
    private func setUpUI() {
        verticalStackView1.addArrangedSubview(originalTitleLabel)
        verticalStackView1.addArrangedSubview(overviewLabel)
        
        horizontalStackView.addArrangedSubview(movieImageView)
        horizontalStackView.addArrangedSubview(verticalStackView1)
        
        contentView.addSubview(horizontalStackView)
        
        //the stack constraints
        let safeArea = contentView.safeAreaLayoutGuide
        horizontalStackView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        verticalStackView1.spacing = 5
        horizontalStackView.spacing = 10
        
        movieImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
}
