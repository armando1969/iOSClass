//
//  DetailViewController.swift
//  HomeWork
//
//  Created by Consultant on 1/30/22.
//

import UIKit

protocol CellStatusProtocol {
    /*
     when you declare a method it always must start with lower cased.
     func sendingCellStatusToTableView(cellStatus: Bool, row: Int)
     */
    func sendingCellStatustoTableView(cellStatus: Bool, row: Int)
}

class DetailViewController: UIViewController {
    var delegate: CellStatusProtocol? = nil
    
    var image: String?
    var status: Bool?
    var row: Int?
    
    /*
     Always use access control in this case for all IBOutlet you can add the private key word
     */
    @IBOutlet private weak var SwitchState: UISwitch!
    
    /*
     Always use access control in this case for all IBAction you can add the private key word
     */
    @IBAction private func DetailSwitch(_ sender: Any) {
        if ((sender as AnyObject).isOn == true) {
                print(row!)
                self.delegate?.sendingCellStatustoTableView(cellStatus: true, row: row!)
        } else {
            if self.delegate != nil {
                self.delegate?.sendingCellStatustoTableView(cellStatus: false, row: row!)
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
        self.delegate?.sendingCellStatustoTableView(cellStatus: false, row: row!)
        loadImage()
        
    }
    
    private func loadImage() {
        
        /*
         for this method that you are getting data from API a better solution is add this task into a different thread to not block the user while you are downloading image. For example now when you try to see the detail view you can feel some delay when the main view is try to display the second view. You can improve it creating a thread with the DispatchQueue to download the image like the network call that you have in the network manager.
         */
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
