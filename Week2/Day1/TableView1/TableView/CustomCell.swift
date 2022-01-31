//
//  CustomCell.swift
//  TableView
//
//  Created by Consultant on 1/27/22.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var customCellLabel: UILabel!
  
    @IBOutlet weak var customCellButton: UIButton!
    @IBAction func clickButton(_ sender: Any) {
    }
    
    func configureCell(title: String?, buttonTittle: String?)
    {
        
        customCellLabel.text = title
        customCellButton.setTitle(buttonTittle, for: .normal)
    }
    
}
