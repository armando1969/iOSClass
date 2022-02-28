//
//  ProductionViewCell.swift
//  HomeWork3
//
//  Created by Consultant on 2/19/22.
//

import UIKit

class ProductionCell: UICollectionViewCell {
    
    static let identifier = "ProductionCell"
    private let viewModel = ViewModel()
    
    private lazy var productionCoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    func configureCell(productionCo: String, imageData: String?) {
        productionCoTitleLabel.text = productionCo
        viewModel.getImageData(imageData!) { data in
            DispatchQueue.global().async {
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.productionCoImageView.image = image
                    }
                }
            }

        }
    }
    
    private func setUpUI() {        
        contentView.addSubview(productionCoImageView)
        contentView.addSubview(productionCoTitleLabel)
        
        //image
        productionCoImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        productionCoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        productionCoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        productionCoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 2/3).isActive = true
        // name
        productionCoTitleLabel.topAnchor.constraint(equalTo: productionCoImageView.bottomAnchor, constant: 10).isActive = true
        productionCoTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
    }
    
}
