//
//  MovieCell.swift
//  HomeWork #2
//
//  Created by Consultant on 2/12/22.
//

import UIKit

class MovieCell: UITableViewCell {
    
    static let identifier = "MovieCell"

    private lazy var originalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    func configureCell(title: String) {
        originalTitleLabel.text = title
    }
    
    private func setUpUI() {
        contentView.addSubview(originalTitleLabel)
        
        //the label constraints
        let safeArea = contentView.safeAreaLayoutGuide
        originalTitleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        originalTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        originalTitleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        originalTitleLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }
}
