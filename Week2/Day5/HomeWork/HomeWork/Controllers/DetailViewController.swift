//
//  DetailViewController.swift
//  HomeWork
//
//  Created by Consultant on 1/30/22.
//

import UIKit

protocol CellStatusProtocol {
    func SendingCellStatustoTableView(cellStatus: Bool, row: Int)
}

class DetailViewController: UIViewController {
    var delegate: CellStatusProtocol? = nil
    
    var image: String?
    var status: Bool?
    var row: Int?

    @IBOutlet weak var SwitchState: UISwitch!
    
    @IBAction func DetailSwitch(_ sender: Any) {
        if ((sender as AnyObject).isOn == true) {
                print(row!)
                self.delegate?.SendingCellStatustoTableView(cellStatus: true, row: row!)
        } else {
            if self.delegate != nil {
                self.delegate?.SendingCellStatustoTableView(cellStatus: false, row: row!)
            }
        }
        
    }
    
    @IBOutlet weak var DetailImage: UIImageView!
    
    override func viewDidLoad() {
        if status == true {
            SwitchState.isOn = true
        } else {
            SwitchState.isOn = false
        }
        self.delegate?.SendingCellStatustoTableView(cellStatus: false, row: row!)
        loadImage()
        
    }
    
    private func loadImage() {
        guard let url = URL(string: image!) else {
            return
        }
        do {
            let data = try Data(contentsOf: url)
            DetailImage.image = UIImage(data: data)
            DetailImage.layer.cornerRadius = DetailImage.frame.size.width / 2
        } catch let error  {
            print(error.localizedDescription)
        }
    }
    
}

