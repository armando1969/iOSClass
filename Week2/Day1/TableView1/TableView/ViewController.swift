//
//  ViewController.swift
//  TableView
//
//  Created by Consultant on 1/27/22.
//

import UIKit

class ViewController: UIViewController {

 //   private var count = 100
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
      //  myTableView.delegate = self
      //  myTableView.dataSource = self
        
    }

}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 10
        }else  if section == 1 {
            return 20
        }
        return 30
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "section 1"
        } else if section == 1 {
            return "section 2"
        }
        return "section 3"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        let section = indexPath.section
        let title = "Section: \(section) and row: \(row)"
        let buttonTitle = "press here"
        
        if section == 0 && row == 3 {
            if let cell = myTableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomCell {
                cell.configureCell(title: title, buttonTittle: buttonTitle)
                return cell
            }
           
        }
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = "this is the section\(section)"
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = indexPath.row
        let section = indexPath.section
        
        if section == 0 && row == 3 {
            return 105
        }
        return 45.0
    }
    
}
