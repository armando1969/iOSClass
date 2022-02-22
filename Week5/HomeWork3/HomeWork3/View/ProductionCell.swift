//
//  ProductionViewCell.swift
//  HomeWork3
//
//  Created by Consultant on 2/19/22.
//

import UIKit

class ProductionCell: UICollectionViewCell {
    
    static let identifier = "ProductionCell"
    
    private lazy var productionCoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
      //  imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var productionCoTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(productionCo: String, imageData: Data?) {
        productionCoTitleLabel.text = productionCo
        if let imageData = imageData {
            let image = UIImage(data: imageData)
            productionCoImageView.image = image
        }
    }
    
    private func setUpUI() {
      //  verticalStackView.addArrangedSubview(productionCoImageView)
      //  verticalStackView.addArrangedSubview(productionCoTitleLabel)
        
        contentView.addSubview(productionCoImageView)
        contentView.addSubview(productionCoTitleLabel)
        
        //the stack constraints
     //   let safeArea = contentView.safeAreaLayoutGuide
        productionCoImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        productionCoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        productionCoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        productionCoImageView.heightAnchor.constraint(equalTo: heightAnchor, constant: 50).isActive = true
        productionCoImageView.widthAnchor.constraint(equalTo: widthAnchor, constant: 150).isActive = true
     //   verticalStackView.spacing = 5
        
        productionCoTitleLabel.topAnchor.constraint(equalTo: productionCoImageView.bottomAnchor).isActive = true
      //  productionCoTitleLabel.widthAnchor.constraint(equalToConstant: 220).isActive = true
    }
    
}
