//
//  StoryCell.swift
//  RedditChallenge
//
//  Created by Consultant on 2/12/22.
//

import UIKit

class StoryCell: UITableViewCell {
    
    static let identifier = "StoryCell"
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var storyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var storyTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
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
    
    func configureCell(title: String, statusString: String) {
        storyTitleLabel.text = title
        statusLabel.text = statusString
    }
    
    private func setUpUI() {
        stackView.addArrangedSubview(storyTitleLabel)
        stackView.addArrangedSubview(storyImageView)
        stackView.addArrangedSubview(statusLabel)
        
        contentView.addSubview(stackView)
        
        //the title label constraints
        let safeArea = contentView.safeAreaLayoutGuide
        stackView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        
//        storyTitleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
//        storyTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
//        storyTitleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
//        storyTitleLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor).isActive = true
//
//        //the title label constraints
//        statusLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
//        statusLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
//        statusLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true

    }
}
