//
//  DetailViewController.swift
//  RedditChallenge
//
//  Created by Consultant on 2/14/22.
//

import UIKit


class DetailViewController: UIViewController {
    
    var changeStatus: ((Bool, String) -> Void)?
    var identifier = ""
    
    private let switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.isOn = false
        return switchControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        view.addSubview(switchControl)
        view.backgroundColor = .white
        
        switchControl.addTarget(self, action: #selector(changeSwitch), for: .valueChanged)
        
        let safeArea = view.safeAreaLayoutGuide
        switchControl.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        switchControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
    }
    
    @objc private func changeSwitch() {
        changeStatus?(switchControl.isOn, identifier)
    }
}
