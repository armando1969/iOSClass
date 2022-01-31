//
//  CustomCellTableViewCell.swift
//  HomeWork
//
//  Created by Consultant on 1/30/22.
//

protocol CustomCellDelegate: AnyObject {
    func tap(on row: Int)
}

import UIKit

class CustomCellTableViewCell: UITableViewCell {
    
    weak var delegate: CustomCellDelegate?
    
    //this is where the status is changed

}
