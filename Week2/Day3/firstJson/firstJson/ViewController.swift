//
//  ViewController.swift
//  firstJson
//
//  Created by Consultant on 1/26/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private func getData() {
        guard let url = URL(string: "https://jasonplaceholder.typecode.com/posts") else
        {
            return
        }
        do {
            let data = try Data(contentsOf: url)
            print(data)
        } catch let error {
            print(error.localizedDescription)
        }
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    
    
}
