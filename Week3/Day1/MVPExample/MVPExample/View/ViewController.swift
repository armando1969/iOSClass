//
//  ViewController.swift
//  MVPExample
//
//  Created by Consultant on 2/4/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var presenter: MoviePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUPUI()
        
        presenter = MoviePresenter(view: self)
        presenter.get()
        
        //presenter = MoviePresenter(view: self)
    }
    
    private func setUPUI() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension ViewController: MovieViewProtocol {
    
    func refreshTableView() {
        tableView.reloadData()
    }

    func displayError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let doneButton = UIAlertAction(title: "Done", style: .default, handler: nil)
        alert.addAction(doneButton)
        present(alert, animated: true, completion: nil)
    }

}

extension ViewController: UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         presenter.rows
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        
        let row = indexPath.row
        let movieTitle = presenter.getTitle(by: indexPath.row)
        let movieOverView = presenter.getOverview(by: row)
        let data = presenter.getImage(by: row)
        cell.configureCell(title: movieTitle, overView: movieOverView, image: data)
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
