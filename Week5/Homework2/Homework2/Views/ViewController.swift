//
//  ViewController.swift
//  HomeWork #2
//
//  Created by Consultant on 2/12/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    private var cancellables = Set<AnyCancellable>()
    private let segments = ["Movies", "Favorites"]
    
    private lazy var segmentControl: UISegmentedControl = {
        let segments = UISegmentedControl(items: segments)
        segments.translatesAutoresizingMaskIntoConstraints = false
        return segments
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
      //  tableView.prefetchDataSource = self
        tableView.dataSource = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        SetupUI()
        Binding()
    }
    
    private func SetupUI() {
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        //create the constrains
        let safeArea = view.safeAreaLayoutGuide
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant:  20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant:  -20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20).isActive = true
//        segmentControl.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
//        segmentControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
//        segmentControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
//        segmentControl.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }

    func Binding() {
        viewModel
            .$movies
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                    self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.getMovies()
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell
        else {
            return UITableViewCell() }
        let title = viewModel.getTitle(by: indexPath.row)
        let overview = viewModel.getOverview(by: indexPath.row)
        cell.configureCell(title: title, overview: overview)
        return cell
    }
}

//extension ViewController: UITableViewDataSourcePrefetching {
//
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        viewModel.loadMoreMovies()
//    }
//}
