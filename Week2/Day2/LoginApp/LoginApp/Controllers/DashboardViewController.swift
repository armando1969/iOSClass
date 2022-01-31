//
//  DashboardViewController.swift
//  LoginApp
//
//  Created by Consultant on 1/30/22.
//

import UIKit

class DashboardViewController: UIViewController {
    
  /*  enum NetworkError: Error, LocalizedError {
        case internalError
        case badURL
        var errorDescription: String? {
            switch self {
            case .internalError:
                return "Error in the API"
            case .badURL:
                return "the URL is bad"
            }
        }
    }*/
    
    var user: users?

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = user?.name
        // Do any additional setup after loading the view.
        profileImage()
    }
    
    private func profileImage() {
        
        guard let urString = user?.image,  let url = URL(string: urString) else {
            return
        }
        do {
            let data = try Data(contentsOf: url)
            userImage.image = UIImage(data: data)
        } catch (let error) {
            print(error.localizedDescription)
        }
       
    }
    /*
   private func errorFunc() throws {
        //if I have some error
        throw NetworkError.badURL
    } */
}
