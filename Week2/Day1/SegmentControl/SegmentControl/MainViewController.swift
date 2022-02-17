//
//  MainViewController.swift
//  SegmentControl
//
//  Created by Consultant on 1/26/22.
//

import UIKit

class MainViewController: UIViewController {
    
    private enum coin: Int {
        case Guanajuato
        case Durango
        case Mexico
            
            var image: UIImage? {
                switch self {
                case .Guanajuato:
                    return UIImage(named: "Guanajuato")
                case .Durango:
                    return UIImage(named: "Durango")
                case .Mexico:
                    return UIImage(named: "Mexico")
                }
            }
        }
    
    @IBOutlet private weak var SegmentControlAttributes: UISegmentedControl!
    
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBAction private func SermentControl(_ sender: Any) {
        
        let index = SegmentControlAttributes.selectedSegmentIndex
        
        guard let segmentCase = coin(rawValue: index) else {
            return
        }
      
        imageView.image = segmentCase.image
        switch segmentCase {
        case .Guanajuato:
            imageView.image = UIImage(named: "Guanajuato")
        case .Durango:
            imageView.image = UIImage(named: "Durango")
        case .Mexico:
            imageView.image = UIImage(named: "Mexico")
        } 
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = coin.Guanajuato.image
    }
    
}
