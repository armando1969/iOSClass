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
    private let segments = ["Movie List", "Favorites"]
    lazy var tableTodisplay = [Results]()
    lazy var movieList = [Results]()
    lazy var filteredMovies = [Results]()
    var customer = ""
    var seaeching = false
    
    
    
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.barTintColor = UIColor.white
        search.layer.cornerRadius = 9
        search.layer.borderWidth = 1
        return search
    }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: segments)
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.selectedSegmentIndex = 0
        segment.layer.cornerRadius = 9
        segment.layer.borderWidth = 1
        segment.layer.masksToBounds = true
     //   segments.addTarget(self, action: #selector(switchSegment(_:)), for: .valueChanged)
        return segment
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
      //  tableView.prefetchDataSource = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        return tableView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
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
        SetupUI()
        Binding()
    }
    
    private func SetupUI() {
        
        view.backgroundColor = .white
        
        stackView.addArrangedSubview(segmentControl)
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(tableView)
        
        view.addSubview(stackView)
        
        //create the tableview constrains
        let safeArea = view.safeAreaLayoutGuide
        stackView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        segmentControl.widthAnchor.constraint(equalToConstant: 350).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: 350).isActive = true
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 70).isActive = true
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
    
    @objc fileprivate func switchSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Movies")
        case 1:
            print("Favorites")
        default:
            return
        }
    }

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableTodisplay = viewModel.movies
        return viewModel.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieCell
        else {
            return UITableViewCell() }
        let title: String = viewModel.getTitle(by: indexPath.row)
        let overview = viewModel.getOverview(by: indexPath.row)
        let image = viewModel.getImageData(by: indexPath.row)
        if seaeching {
            
        }
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

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieList = viewModel.movies
        if searchText == "" {
            filteredMovies = movieList
        } else {
            for movie in movieList {
                if movie.originalTitle.lowercased().contains(searchText.lowercased()) {
                    filteredMovies.append(movie)
                }
            }
        }
        self.tableView.reloadData()
    }
}

//extension ViewController: UITableViewDataSourcePrefetching {
//
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        viewModel.loadMoreMovies()
//    }
//}
