//
//  ViewController.swift
//  FirstApp
//
//  Created by Consultant on 1/25/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak private var UILabel1: UILabel!
    @IBOutlet weak private var nameTextBox: UITextField!
    @IBOutlet weak private var ageTextBox: UITextField!
    @IBOutlet weak var mergeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UILabel1.text = "Title of My App"
        UILabel1.font = UIFont(name: "Verdana", size: 20)
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func mergeButton(_ sender: UIButton) {
        //we can add validation
        nameTextBox.resignFirstResponder()
        ageTextBox.resignFirstResponder()
        
    //the guard statement
        let char = NSCharacterSet.alphanumerics.inverted
        guard let name = nameTextBox.text, let age = ageTextBox.text, let _ = Int(age) else {
            return
        }
        guard name.rangeOfCharacter(from: char) == nil else
        { return }
        let myString = "\(name) is \(age)"
            mergeLabel.text = myString
       /* if let name = nameTextBox.text, let age = ageTextBox.text {
        let myString = "\(name) is \(age)"
        mergeLabel.text = myString } */
    }
    
    
 /*   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("View Will Appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //megerLabel.text = nameTextBox(<#T##sender: Any##Any#>)
        
        print("View Did Appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("View Will Disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("View Did Disappear")
    }

*/
}

