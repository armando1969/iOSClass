//
//  ViewController.swift
//  PostApp
//
//  Created by Consultant on 2/9/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var posts = [Post]()
    
    private let networkManger = NetworkManager()
    private let secondViewController = SecondeViewController()
    private var rowSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUI()
        networkManger.getData { [weak self] array in
            self?.posts = array
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      //  secondView.
        if segue.identifier == "showDetail" {
            let destination = segue.destination as? SecondeViewController
            destination?.posts = posts
            destination?.row = rowSelected
            //secondViewController.post? = posts[rowSelected]
           // secondViewController.title = posts[rowSelected].title
        }
    }
    
    private func setUI() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let row = indexPath.row
        let post = posts[row]
        cell?.textLabel?.text = post.title
        cell?.detailTextLabel?.text = post.overview
        return cell!
    }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowSelected = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
}
