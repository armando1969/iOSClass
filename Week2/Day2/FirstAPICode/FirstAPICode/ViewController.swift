//
//  ViewController.swift
//  FirstAPICode
//
//  Created by Consultant on 1/30/22.
//

import UIKit

class ViewController: UIViewController {
    
    var array = [[String: Any]]()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
    }
    private func loadData() {
        DispatchQueue.global().async {
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else
            { return }
            do {
                let data = try Data(contentsOf: url)
                if let response = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                { self.array = response
                    print(response)
                }
                

            } catch let error {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
       
}
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let dictionary = array[row]
        
        let title = dictionary["title"] as? String
        let body = dictionary["body"] as? String
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = body
        return cell
    }
    
    
}
