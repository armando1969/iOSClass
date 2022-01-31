//
//  ViewController.swift
//  LoginApp
//
//  Created by Consultant on 1/30/22.
//

import UIKit

class ViewController: UIViewController {

    private var Users: users?

    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func enterButton(_ sender: Any) {
        guard let user = userName.text, let pass = password.text, !user.isEmpty, !pass.isEmpty else {
            let emptyAlert = createAlert("the password and/or username are blank")
            present(emptyAlert, animated: true, completion: nil)
            return
        }
        
        guard user == "Florencio" && pass == "123456" else
        {
            let invalidAlert = createAlert("The username and/or password are invalid")
            present(invalidAlert, animated: true, completion: nil)
            return
        }
        
        Users = users(username: user, image: "placeholder-profile-sq.jpg", name: "florencio gallegos")
        performSegue(withIdentifier: "showMainApp", sender: nil)
    }
    //cleaning up the code
    private func createAlert(_ message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert) // you can also use .actionsheet
        let acceptButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(acceptButton)
        return alert
    }
/*  use this if there are multiple controller to seggue to
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier
        if identifier ==  "showMainApp" {
            if let destination = segue.destination as? UITabBarController {
                if let viewController = destination.viewControllers?.first as? DashboardViewController {
                    viewController.user = Users
                }
 
            }
        }
    }*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UITabBarController {
            if let viewController = destination.viewControllers?.first as? DashboardViewController {
                viewController.user = Users
            }
        }
     
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        userName.text = nil
        password.text = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

