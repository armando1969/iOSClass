//
//  DetailViewController.swift
//  HomeWork3
//
//  Created by Consultant on 2/17/22.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
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

    private lazy var originalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: 15)
        label.numberOfLines = 10
        label.textAlignment = .left
        return label
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
    var image = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        originalTitleLabel.text = originalTitle
        overviewLabel.text = overView
        movieImageView.image = UIImage(data: image)
        navigationItem.title = originalTitle
        
        verticalStackView1.addArrangedSubview(originalTitleLabel)
        verticalStackView1.addArrangedSubview(overviewLabel)
        
        horizontalStackView.addArrangedSubview(movieImageView)
        horizontalStackView.addArrangedSubview(verticalStackView1)
        
        verticalStackView2.addArrangedSubview(productionTitleLabel)
        
        
        view.addSubview(horizontalStackView)
        view.addSubview(verticalStackView2)
        
        //the stack constraints
        let safeArea = view.safeAreaLayoutGuide
        horizontalStackView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: verticalStackView2.topAnchor,constant: -120).isActive = true
        verticalStackView2.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20).isActive = true
        verticalStackView2.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20).isActive = true
        verticalStackView2.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        horizontalStackView.spacing = 10
        verticalStackView1.spacing = 5
        
        movieImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
    }
    
    
}
