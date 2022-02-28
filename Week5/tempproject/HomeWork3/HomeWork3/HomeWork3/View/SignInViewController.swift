//
//  SignInViewController.swift
//  HomeWork3
//
//  Created by Consultant on 2/17/22.
//

import Foundation
import UIKit

class SignInViewController: UIViewController {
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }()
    
    private let saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitle("Save", for: .normal)
        saveButton.layer.cornerRadius = 9
        saveButton.layer.borderWidth = 1
        saveButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        saveButton.setTitleColor(UIColor.blue, for: .normal)
        return saveButton
    }()
    
    private let userTextField: UITextField = {
        let userTextField = UITextField()
        userTextField.translatesAutoresizingMaskIntoConstraints = false
        userTextField.layer.borderWidth = 1
        userTextField.attributedPlaceholder = NSAttributedString(
            string: "write your name here",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.opaqueSeparator])
        userTextField.textColor = .black
        userTextField.borderStyle = UITextField.BorderStyle.roundedRect
        return userTextField
    }()
    
    private let viewModel = ViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    private func setUpUI() {
        view.backgroundColor = .white

        mainStackView.addArrangedSubview(userTextField)
        mainStackView.addArrangedSubview(saveButton)
        
        view.addSubview(mainStackView)

        let safeArea = view.safeAreaLayoutGuide
        userTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20).isActive = true
        userTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 240).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 150).isActive = true

        mainStackView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: -60).isActive = true

    }
    @objc
    private func pressed() {
//        var allowedCharacters = CharacterSet.alphanumerics
//        (userTextField.text(in: allowedCharacters) != nil)
        guard let user = userTextField.text, user.count >= 3 else
        {
            let invalidAlert = createAlert("The username is blank or invalid")
            present(invalidAlert, animated: true, completion: nil)
            return
        }
        let detail = MainViewController()
        viewModel.setUser(user: userTextField.text!)
        navigationController?.pushViewController(detail, animated: true)
    }
}


private func createAlert(_ message: String) -> UIAlertController {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert) // you can also use .actionsheet
    let acceptButton = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(acceptButton)
    return alert
}
