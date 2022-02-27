//
//  MainViewController.swift
//  HomeWork3
//
//  Created by Consultant on 2/17/22.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    private let viewModel = ViewModel.shared
    private var cancellables = Set<AnyCancellable>()
    private let segments = ["Movie List", "Favorites"]
    var tableToDisplay = 0
    var moviesList = [Movie]()
    var filteredMovies: [Movie]!
    var searching = false
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
    
    private var editView: UIView {
        let editView = UIView()
        editView.isHidden = true
        return editView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Hello: \(viewModel.getUser())",
                                                           style: UIBarButtonItem.Style.plain,
                                                               target: nil,
                                                               action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
       // filteredMovies = viewModel.movies
        searchBar.delegate = self
        SetupUI()
        Binding()
    }
    
    @objc
    private func edit() {
        print("here")
        let alert = UIAlertController(title: "Edit", message: "Edit Your Name Here", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.attributedPlaceholder = NSAttributedString(
                string: "Edit user here",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.opaqueSeparator])
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [self, weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            self.viewModel.setUser(user: textField!.text!)
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Hello: \(viewModel.getUser())",
                                                               style: UIBarButtonItem.Style.plain,
                                                                   target: nil,
                                                                   action: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
//    private func fetchMovies() {
////        do {
////            try <#throwing expression#>
////        } catch <#pattern#> {
////            <#statements#>
////        }
//
//    }
    
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
            return }
        DispatchQueue.main.async {
            self.tableView.reloadData() }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableToDisplay == 0 {
            return viewModel.movies.count
        } else {
            return viewModel.favoriteMovies.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell
        else {
            return UITableViewCell() }
        if tableToDisplay == 0 {
            var movie = Movie()
            movie = viewModel.getMovie(by: indexPath.row)
            let title = movie.originalTitle
            let overview = movie.overview
            let image = movie.posterPath
            let favorite = movie.isFavorite //viewModel.getFavorite(by: indexPath.row)
            cell.configureCell(title: title, overview: overview, imageData: image, isFavorite: favorite)
        }
        else {
            var movie = FavoriteMovie(id: 0, originalTitle: "", overview: "", posterPath: "", favoriteIndex: -1)
            movie = viewModel.getfavoriteMovie(by: indexPath.row)
            let title = movie.originalTitle
            let overview = movie.overview
            let image = movie.posterPath
            let favorite = false
            cell.configureCell(title: title, overview: overview, imageData: image, isFavorite: favorite)
             }
        
//        if seaeching {
//
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = viewModel.getMovie(by: indexPath.row)
        let detail = DetailViewController()
        detail.movie = movie
        detail.row = indexPath.row
     //   detail.isFavorite = movie.isFavorite
     //   detail.isFavorite = viewModel.favoriteStatus[indexPath.row]
//        for i in stride(from: 0, to: (filteredMovies.count-1), by: 1) {
//            if viewModel.favoriteMovies[i].id  == movie.id {
//                detail.isFavorite = true
//            } else {
//                detail.isFavorite = false
//            }
//        }
//        detail.productionCo = viewModel.$companies
//                                                    .receive(on: RunLoop.main)
//                                                    .sink(receiveValue: {[weak self] name in
//                                                        return name
//                                                    }).store(in: &cancellables)
//            self.viewModel.getProductionCompanies(id: movieId)
        navigationController?.pushViewController(detail, animated: true)
//        if detail.isFavorite == true {
//        }
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension MainViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        moviesList = viewModel.movies
//        if searchText == "" {
//            filteredMovies = moviesList
//        } else {
//            for movie in moviesList {
//                if movie.originalTitle.lowercased().contains(searchText.lowercased()) {
//                    filteredMovies.append(movie)
//                }
//                print(filteredMovies.count)
//            }
//        }
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
}

