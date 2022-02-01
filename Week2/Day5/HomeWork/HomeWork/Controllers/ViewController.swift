//
//  ViewController.swift
//  HomeWork
//
//  Created by Consultant on 1/29/22.
//

import UIKit

class ViewController: UIViewController, CellStatusProtocol {
    
    
    private let networkManager = NetworkManager()

    @IBOutlet weak var TableView: UITableView!
    
    private var array = [NasaPhotos]()
    var image: String?
    var status: String = "status: False"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        TableView.delegate = self
        TableView.dataSource = self
        loadData()
    }
    
    
     private func loadData() {
         
         networkManager.getPhotos(from: NetworkURLs.photosURL) { [weak self] result  in
             switch result {
             case .success(let response):
                 self?.array = response.photos
             case .failure(let error):
                 print(error.localizedDescription)
             }
             DispatchQueue.main.async {
                 self?.TableView.reloadData()
             }
         }
     }
     
    }

   

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let title = array[indexPath.row].id
        
        if let cell = TableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? UITableViewCell {
            cell.textLabel?.text = "Id: \(title)"
            cell.detailTextLabel?.text = status
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        image = array[indexPath.row].img_src
        performSegue(withIdentifier: "ShowDetail", sender: nil)
    }
    
    func SendingCellStatustoTableView(cellStatus: String) {
        self.status = cellStatus
    }
    
}



extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print(array.count)
        print(image!)
        
                if let detailViewController = segue.destination as? DetailViewController {
                    detailViewController.image = image!
                }
    }
    
}


