//
//  LastViewController.swift
//  Navigation
//
//  Created by Consultant on 1/29/22.
//

import UIKit

class LastViewController: UIViewController {


   
    @IBAction func DismissButton(_ sender: Any) {
       // dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var DismissButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
