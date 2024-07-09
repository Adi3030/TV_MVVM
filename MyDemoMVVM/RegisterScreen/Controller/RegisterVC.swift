//
//  RegisterVC.swift
//  MyDemoMVVM
//
//  Created by aditya sharma on 31/05/24.
//

import UIKit

class RegisterVC: UIViewController {

        private let viewModel = RegisterViewModel()
        
        private let nameTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Name"
            textField.borderStyle = .roundedRect
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
        
        private let countryTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Country"
            textField.borderStyle = .roundedRect
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
        
        private let mobileTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Mobile"
            textField.borderStyle = .roundedRect
            textField.keyboardType = .phonePad
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
        
        private let passwordTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Password"
            textField.borderStyle = .roundedRect
            textField.isSecureTextEntry = true
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
        
        private let registerButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Register", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.isEnabled = false
            return button
        }()
        
        private let messageLabel: UILabel = {
            let label = UILabel()
            label.textColor = .red
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            title = "Register"
            
            setupSubviews()
            setupConstraints()
            bindViewModel()
        }
        
        private func setupSubviews() {
            view.addSubview(nameTextField)
            view.addSubview(countryTextField)
            view.addSubview(mobileTextField)
            view.addSubview(passwordTextField)
            view.addSubview(registerButton)
            view.addSubview(messageLabel)
            
            nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            countryTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            mobileTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        }
        
        private func setupConstraints() {
            NSLayoutConstraint.activate([
                nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                nameTextField.widthAnchor.constraint(equalToConstant: 300),
                
                countryTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                countryTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
                countryTextField.widthAnchor.constraint(equalToConstant: 300),
                
                mobileTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                mobileTextField.topAnchor.constraint(equalTo: countryTextField.bottomAnchor, constant: 20),
                mobileTextField.widthAnchor.constraint(equalToConstant: 300),
                
                passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                passwordTextField.topAnchor.constraint(equalTo: mobileTextField.bottomAnchor, constant: 20),
                passwordTextField.widthAnchor.constraint(equalToConstant: 300),
                
                registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
                
                messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                messageLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20),
                messageLabel.widthAnchor.constraint(equalToConstant: 300)
            ])
        }
        
        private func bindViewModel() {
            viewModel.isRegisterButtonEnabled = { [weak self] isEnabled in
                self?.registerButton.isEnabled = isEnabled
            }
            
            viewModel.didRegisterSucceed = { [weak self] in
                self?.messageLabel.textColor = .green
                self?.messageLabel.text = "Registration Successful"
            }
            
            viewModel.didRegisterFail = { [weak self] errorMessage in
                self?.messageLabel.textColor = .red
                self?.messageLabel.text = errorMessage
            }
        }
        
        @objc private func textFieldDidChange(_ textField: UITextField) {
            if textField == nameTextField {
                viewModel.name = textField.text ?? ""
            } else if textField == countryTextField {
                viewModel.country = textField.text ?? ""
            } else if textField == mobileTextField {
                viewModel.mobile = textField.text ?? ""
            } else if textField == passwordTextField {
                viewModel.password = textField.text ?? ""
            }
        }
        
        @objc private func registerButtonTapped() {
            viewModel.register()
        }
    }

