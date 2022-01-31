//
//  ViewController.swift
//  FirstAPICode
//
//  Created by Consultant on 1/30/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
    }
    private func loadData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else
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
