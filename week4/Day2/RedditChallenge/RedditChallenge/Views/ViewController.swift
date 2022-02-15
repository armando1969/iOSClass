//
//  ViewController.swift
//  RedditChallenge
//
//  Created by Consultant on 2/12/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var storiesTrue = [String]()
    private let segments = ["Movies", "Favorites"]
    
    private lazy var segmentControl: UISegmentedControl = {
        let segments = UISegmentedControl(items: segments)
        segments.translatesAutoresizingMaskIntoConstraints = false
        return segments
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.dataSource = self
        tableView.register(StoryCell.self, forCellReuseIdentifier: StoryCell.identifier)
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
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
//        segmentControl.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
//        segmentControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
//        segmentControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
//        segmentControl.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }

    func Binding() {
        viewModel
            .$stories
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
               // DispatchQueue.main.async {
                    self?.tableView.reloadData()
            //    }
            }
            .store(in: &cancellables)
        
        viewModel.getStories()
    }
    
    func getStatus(by identifier: String) -> Bool {
        return storiesTrue.contains(identifier)
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.stories.count)
        return viewModel.stories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryCell", for: indexPath) as? StoryCell
        else {
            return UITableViewCell() }
        let title = viewModel.getTitle(by: indexPath.row)
        let identifier = viewModel.getIdentifier(by: indexPath.row)
        let status = getStatus(by: identifier) ? "true" : "false"
        cell.configureCell(title: title, statusString: status)
        return cell
    }
}

extension ViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        viewModel.loadMoreStories()
    }
}
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailViewController()
        detail.identifier = viewModel.getIdentifier(by: indexPath.row)
        detail.changeStatus = { [unowned self]status, identifier in
            if status {
                self.storiesTrue.append(identifier)
            }  else {
                if let index = self.storiesTrue.firstIndex(of: identifier) {
                    self.storiesTrue.remove(at: index)
            }
            }
            self.tableView.reloadData()
        }
        navigationController?.pushViewController(detail, animated: true)
    }
}
