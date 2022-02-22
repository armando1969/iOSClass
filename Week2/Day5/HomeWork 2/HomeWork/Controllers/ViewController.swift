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
    var status: [Bool]?
    var selectedRow: Int?
    
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
                 self?.status = Array(repeating: false, count: (self?.array.count)!)
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
            if status?[indexPath.row] == true {
                cell.detailTextLabel?.text = "Status: true"
            } else {
                cell.detailTextLabel?.text = "Status: false"
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        image = array[indexPath.row].img_src
        selectedRow = indexPath.row
        performSegue(withIdentifier: "ShowDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailViewController = segue.destination as? DetailViewController {
            detailViewController.row = selectedRow
            detailViewController.image = image!
            detailViewController.status = status?[selectedRow!]
            detailViewController.delegate = self
        }
    }
    
    func sendingCellStatustoTableView(cellStatus: Bool, row: Int) {
        self.status?[row] = cellStatus
        TableView.reloadData()
    }
    
}



extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


