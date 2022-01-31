//
//  ViewController.swift
//  TableView
//
//  Created by Consultant on 1/28/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         myTableView.delegate = self
         myTableView.dataSource = self
    }


}

extension ViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
        return 10
        } else if section == 1 {
            return 20
        }
        return 30
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
        return "Section \(section)"
        } else if section == 1 {
            return "Section \(section)"
        }
        return "Section \(section)"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        let section = indexPath.section
        let title = "this is Section \(section)"
        let subTitle = "and row \(row)"
        
        if section == 0 && row == 3 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell {
                let largeString = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English."
                
                cell.configureCell(Title: largeString, buttonTitle: subTitle,row: row)
                cell.delegate = self
                                   return cell
            }
        //  setting the title for label and button in the manin view controller
      /*      if let lable = cell.viewWithTag(10) as? UILabel {
                lable.text = "this is Section \(section)"
            }
            if let button = cell.viewWithTag(20) as? UIButton {
                button.titleLabel?.text = "and row \(row)"
            }
            return cell */
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text? = title
        cell.detailTextLabel?.text? = subTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let section = indexPath.section
        print("The user selected row: \(row) at sedction: \(section)")
    }
    
}

extension ViewController: CustomCellDelegate {
    func tap(on row: Int) {
        print("the user selected the \(row) row")
        //you can segway to anotheer view, open a browser, etc. here
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 3 {
            return UITableView.automaticDimension
        }
        
        return 45.0
    }
}

