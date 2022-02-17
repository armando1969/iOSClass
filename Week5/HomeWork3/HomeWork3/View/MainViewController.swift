//
//  MainViewController.swift
//  HomeWork3
//
//  Created by Consultant on 2/17/22.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    private let viewModel = ViewModel()
    private var cancellables = Set<AnyCancellable>()
    private let segments = ["Movies", "Favorites"]
    internal var customer = ""
    
    private lazy var segmentControl: UISegmentedControl = {
        let segments = UISegmentedControl(items: segments)
        segments.selectedSegmentIndex = 0
        segments.layer.cornerRadius = 9
        segments.layer.borderWidth = 1
        segments.layer.masksToBounds = true
        segments.layer.borderColor = UIColor.blue.cgColor
        segments.tintColor = UIColor.blue
        segments.addTarget(self, action: #selector(switchSegment(_:)), for: .valueChanged)
        segments.translatesAutoresizingMaskIntoConstraints = false
        return segments
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
      //  tableView.prefetchDataSource = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.hidesBackButton = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Hello: \(customer)",
                                                           style: UIBarButtonItem.Style.plain,
                                                               target: nil,
                                                               action: nil)
        navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.dataSource = self
        tableView.delegate = self
        SetupUI()
        Binding()
    }
    
    private func SetupUI() {
        
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        //create the tableview constrains
        let safeArea = view.safeAreaLayoutGuide
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant:  20).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant:  -20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20).isActive = true
        
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
    
    @objc private func switchSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            view.backgroundColor = .blue
        case 1:
            view.backgroundColor = .black
        default:
            return
        }
    }

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell
        else {
            return UITableViewCell() }
        let title = viewModel.getTitle(by: indexPath.row)
        let overview = viewModel.getOverview(by: indexPath.row)
        let image = viewModel.getImageData(by: indexPath.row)
        cell.configureCell(title: title, overview: overview, imageData: image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detail = DetailViewController()
        detail.originalTitle = viewModel.getTitle(by: indexPath.row)
        detail.overView = viewModel.getOverview(by: indexPath.row)
        detail.image = viewModel.getImageData(by: indexPath.row)!
        navigationController?.pushViewController(detail, animated: true)
        
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//extension ViewController: UITableViewDataSourcePrefetching {
//
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        viewModel.loadMoreMovies()
//    }
//}
