//
//  ViewController.swift
//  HomeWork
//
//  Created by Consultant on 1/29/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TableView: UITableView!
    
    private var array = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        TableView.delegate = self
        TableView.dataSource = self
        loadData()
    }
    private func loadData() {
        print("hello")
        DispatchQueue.global().async {
            guard let url = URL(string: "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?api_key=Q9YNbzmt8C5OpY7L3MV4DHJhrdIGCbjx3tVWxRcf&sol=2000&page=1") else
            {
                return
            }
            print("middle")
            do {
                let data = try Data(contentsOf: url)
                print(data)
              //  let response = try JSONSerialization.jsonObject(with: data, options: []) as? [[String]: Any]]
                let response = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
              //  self.array = response!
                print(self.array.count)

            } catch let error {
                print(error.localizedDescription)
            }
            print("goodbye")
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     /*   if let destination = segue.destination {
            if let viewController = destination. as? DetailViewController {
                viewController.user = Users
            }
        } */
     
    }
}
   

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //  let row = indexPath.row
        //let dictionary = array[row]
        
     //   let id = dictionary["id"] as?String
        
        if let cell = TableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? UITableViewCell {
            return cell
        }
    }
    
    
}



extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "ShowDetail", sender: nil)
    }
    
}


