//
//  CustomCell.swift
//  TableView
//
//  Created by Consultant on 1/28/22.
//

//This class performs all of the functionality for the custom cell
//summit principles 1. single responsibility

protocol CustomCellDelegate: AnyObject {
    func tap(on row: Int)
}

import UIKit

class CustomCell: UITableViewCell {
    
    weak var delegate: CustomCellDelegate?
    static let identifier = "CustomCell"
    private var rowSelected = 0

    @IBAction func clickButton(_ sender: Any) {
        delegate?.tap(on: rowSelected)
    }
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellButton: UIButton!
    
    func configureCell(Title: String?, buttonTitle: String?, row: Int) {
        cellLabel.text = Title
        cellButton.setTitle(buttonTitle, for: .normal)
        rowSelected = row
    }
    
}
