//
//  UserSettingsTableViewController.swift
//  LoginApp
//
//  Created by Consultant on 1/30/22.
//

import UIKit

class UserSettingsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        if row == 3 {
        dismiss(animated: true, completion: nil)
        }
    }
}
