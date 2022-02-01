//
//  DetailViewController.swift
//  HomeWork
//
//  Created by Consultant on 1/30/22.
//

import UIKit

protocol CellStatusProtocol {
    func SendingCellStatustoTableView(cellStatus: String)
}

class DetailViewController: UIViewController {
    var delegate: CellStatusProtocol? = nil
    
    var image: String?

    @IBAction func DetailSwitch(_ sender: Any) {
        if ((sender as AnyObject).isOn == true) {
            if self.delegate != nil {
                self.delegate?.SendingCellStatustoTableView(cellStatus: "Status: true")
            }
        } else {
            if self.delegate != nil {
                self.delegate?.SendingCellStatustoTableView(cellStatus: "Status: false")
            }
        }
        
    }
    
    @IBOutlet weak var DetailImage: UIImageView!
    
    override func viewDidLoad() {
        
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

