//
//  MainViewController.swift
//  HomeWork3
//
//  Created by Consultant on 2/17/22.
//

import UIKit
import Combine

class MainViewController: UIViewController, FavoriteStatusProtocol {
    
    private let viewModel = ViewModel()
    private var cancellables = Set<AnyCancellable>()
    private let segments = ["Movie List", "Favorites"]
    var tableToDisplay = 0
    var moviesList = [Results]()
    var favoriteMovieList = [FavoriteMovies]()
    var favIndex = 0
    var favoriteStatus: [Bool] = [false]
    var filteredMovies = [Results]()
    var customer = ""
    var seaeching = false
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
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
        segment.addTarget(self, action: #selector(switchSegment), for: .valueChanged)
        return segment
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
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
    
    private func fetchMovies() {
//        do {
//            try <#throwing expression#>
//        } catch <#pattern#> {
//            <#statements#>
//        }
        
    }
    
    private func SetupUI() {
        
        view.backgroundColor = .white
        
        stackView.addArrangedSubview(segmentControl)
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(tableView)
        
        view.addSubview(stackView)
        
        //create the tableview constrains
        let safeArea = view.safeAreaLayoutGuide
        segmentControl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        segmentControl.widthAnchor.constraint(equalToConstant: 350).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 35).isActive = true
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
                DispatchQueue.main.async {
                    self?.tableView.reloadData() }
            }
            .store(in: &cancellables)
        viewModel.getMovies()
    }
    
    @objc fileprivate func switchSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            tableToDisplay = 0
        case 1:
            tableToDisplay = 1
        default:
            return
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableToDisplay == 0 {
            return viewModel.movies.count
        } else {
            return favoriteMovieList.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell
        else {
            return UITableViewCell() }
        if tableToDisplay == 0 {
            let title = viewModel.getTitle(by: indexPath.row)
            let overview = viewModel.getOverview(by: indexPath.row)
            let image = viewModel.getMovieImageData(by: indexPath.row)
            cell.configureCell(title: title, overview: overview, imageData: image)
        }
        else {
            if favoriteMovieList.count != 0 {
                let title = favoriteMovieList[indexPath.row].originalTitle
                let overview = favoriteMovieList[indexPath.row].overview
                let image = favoriteMovieList[indexPath.row].posterPath
                cell.configureCell(title: title, overview: overview, imageData: image)
            }
            }
//        if seaeching {
//
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movieId = viewModel.getMovieId(by: indexPath.row)
        let detail = DetailViewController()
        detail.delegate = self
        detail.originalTitle = viewModel.getTitle(by: indexPath.row)
        detail.overView = viewModel.getOverview(by: indexPath.row)
        detail.image = viewModel.getMovieImageData(by: indexPath.row)!
        detail.id = movieId
        for i in stride(from: 0, to: (filteredMovies.count-1), by: 1) {
            if favoriteMovieList[i].id  == movieId {
                detail.isFavorite = true
            } else {
                detail.isFavorite = false
            }
        }
//        detail.productionCo = viewModel.$companies
//                                                    .receive(on: RunLoop.main)
//                                                    .sink(receiveValue: {[weak self] name in
//                                                        return name
//                                                    }).store(in: &cancellables)
//            self.viewModel.getProductionCompanies(id: movieId)
        navigationController?.pushViewController(detail, animated: true)
        if detail.isFavorite == true {
        }
    }
    
    func sendingFavoriteStatus(id: Int, isFavorite: Bool, originalTitle: String, overview: String, posterPath: Data) {
        print(originalTitle)
//        self.favoriteStatus[favIndex] = isFavorite
 //       self.favoriteMovieList![favIndex].id = id
//        self.favoriteMovieList[favIndex].originalTitle = originalTitle
//        self.favoriteMovieList[favIndex].overview = overview
//        self.favoriteMovieList[favIndex].posterPath = posterPath
        favIndex = favIndex + 1
    }
    
   
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        moviesList = viewModel.movies
        if searchText == "" {
            filteredMovies = moviesList
        } else {
            for movie in moviesList {
                if movie.originalTitle.lowercased().contains(searchText.lowercased()) {
                    filteredMovies.append(movie)
                }
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

