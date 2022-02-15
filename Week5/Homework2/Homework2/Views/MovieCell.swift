//
//  MovieCell.swift
//  HomeWork #2
//
//  Created by Consultant on 2/12/22.
//

import UIKit

class MovieCell: UITableViewCell {
    
    static let identifier = "MovieCell"
    
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
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var originalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: 13)
        label.numberOfLines = 0
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
    
    func configureCell(title: String, overview: String) {
        originalTitleLabel.text = title
        overviewLabel.text = overview
    }
    
    private func setUpUI() {
        verticalStackView.addArrangedSubview(originalTitleLabel)
        verticalStackView.addArrangedSubview(overviewLabel)
        
        horizontalStackView.addArrangedSubview(movieImageView)
        horizontalStackView.addArrangedSubview(verticalStackView)
        
        contentView.addSubview(verticalStackView)
        
        //the stack constraints
        let safeArea = contentView.safeAreaLayoutGuide
        verticalStackView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        
        movieImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
}
