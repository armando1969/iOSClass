//
//  StoryCell.swift
//  RedditChallenge
//
//  Created by Consultant on 2/12/22.
//

import UIKit

class StoryCell: UITableViewCell {
    
    static let identifier = "StoryCell"

    private lazy var storyTitleLabel: UILabel = {
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
        storyTitleLabel.text = title
    }
    
    private func setUpUI() {
        contentView.addSubview(storyTitleLabel)
        
        //the label constraints
        let safeArea = contentView.safeAreaLayoutGuide
        storyTitleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        storyTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        storyTitleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        storyTitleLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }
}
