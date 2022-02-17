//
//  SignInViewController.swift
//  HomeWork3
//
//  Created by Consultant on 2/17/22.
//

import Foundation
import UIKit

class SignInViewController: UIViewController {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    private let saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        saveButton.setTitleColor(UIColor.blue, for: .normal)
        return saveButton
    }()
    
    private let userTextField: UITextField = {
        let userTextField = UITextField()
        userTextField.translatesAutoresizingMaskIntoConstraints = false
        userTextField.attributedPlaceholder = NSAttributedString(
            string: "write your name here",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.opaqueSeparator])
     //   userTextField.placeholder = "write your name here"
     //   userTextField.placeholder?.description.
        userTextField.textColor = .black
        userTextField.borderStyle = UITextField.BorderStyle.roundedRect
        return userTextField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpUI()
    }
    
    private func setUpUI() {
        view.backgroundColor = .white

        mainStackView.addArrangedSubview(userTextField)
        stackView.addArrangedSubview(saveButton)
        mainStackView.addArrangedSubview(stackView)
        
        view.addSubview(mainStackView)
        
      //  saveButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)

        let safeArea = view.safeAreaLayoutGuide
        userTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20).isActive = true
        userTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20).isActive = true

        stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        mainStackView.spacing = 5
        saveButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 270).isActive = true


        mainStackView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: -60).isActive = true

    }
    @objc
    private func pressed() {
        guard let user = userTextField.text, user.count >= 3 else
        {
            let invalidAlert = createAlert("The username and/or password is blank or invalid")
            present(invalidAlert, animated: true, completion: nil)
            return
        }
        let detail = MainViewController()
        detail.customer = userTextField.text!
        navigationController?.pushViewController(detail, animated: true)
    }
}


private func createAlert(_ message: String) -> UIAlertController {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert) // you can also use .actionsheet
    let acceptButton = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(acceptButton)
    return alert
}
