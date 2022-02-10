//
//  ViewController.swift
//  pucsumApp
//
//  Created by Consultant on 2/7/22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    private var subscriber = Set<AnyCancellable>()

    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .lightGray
        return image
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("load new image", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
//        let viewController = storyboard.instantiateViewController(identifier: "ImageList")
//        let subscriber = get()
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    print("downloaded the image")
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }, receiveValue: { response in
//                print(response.count)
//            })

            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUI()
        setUpBinding()
    }

    @objc private func tapButton() {
        print("tapButton")
        
        let frame = image.frame
        viewModel.download(width: Int(frame.size.width), height: Int(frame.size.height))
        
//        let subscriber = get()
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    print("downloaded the image")
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }, receiveValue: { response in
//                print(response.count)
//            })
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        
        view.addSubview(image)
        view.addSubview(button)
        
        let safeArea = view.safeAreaLayoutGuide
        
        button.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        image.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        image.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: button.topAnchor).isActive = true
    }
        
//         func get() -> AnyPublisher<[Images],Error> {
//
//            guard let url = URL(string: url) else {
//                fatalError()
//            }
//
//            return URLSession
//                .shared
//                .dataTaskPublisher(for: url)
//                .map( { data, response in
//                    return data
//                })
//                .decode(type: [Images].self, decoder: JSONDecoder())
//                .eraseToAnyPublisher()
//        }
    
//    private func setUpBinding() {
//        viewModel
//            .data
//            .dropFirst()
//            .receive(on: RunLoop.main)
//            .sink { [weak self] data in
//                let image = UIImage(data: data)
//                self?.image.image = image
//            }
//            .store(in: &subscriber)
//    }
    
    private func setUpBinding() {
        viewModel
            .$data
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                let image = UIImage(data: data)
                self?.image.image = image
            }
            .store(in: &subscriber)
    }
    
}

