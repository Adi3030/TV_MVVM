//
//  LoginVC.swift
//  MyDemoMVVM
//
//  Created by aditya sharma on 31/05/24.
//

import UIKit

class LoginVC: UIViewController {
    private let viewModel = LoginViewModel()
    
    private let usernameTextField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
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
    
    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
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
        setupSubviews()
        setUPConstaints()
        bindViewMmodel()
        // Do any additional setup after loading the view.
    }
    
    private func setupSubviews() {
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(messageLabel)
        
        usernameTextField.addTarget(self, action: #selector(textFiledDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFiledDidChange(_:)), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

    
    }
    
    private func setUPConstaints() {
        NSLayoutConstraint.activate([
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            usernameTextField.widthAnchor.constraint(equalToConstant: 300),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            messageLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func bindViewMmodel() {
        viewModel.isLoginButtonEnabled = { [weak self] isEnabled in
            self?.loginButton.isEnabled = isEnabled
            
        }
        
        viewModel.didLoginSucceed = { [weak self] in
            self?.messageLabel.textColor = .green
            self?.messageLabel.text = "Login Successful "
        }
        
        viewModel.didLoginFailed = { [weak self] errorMessage in
            self?.messageLabel.textColor = .red
            self?.messageLabel.text = errorMessage
            
        }
    }
    
    @objc private func textFiledDidChange(_ textField: UITextField) {
        if textField == usernameTextField {
            viewModel.username = textField.text ?? ""
            
        }else if textField == passwordTextField {
            viewModel.password = textField.text ?? ""
        }
    }
    
    @objc private func loginButtonTapped() {
        viewModel.login()
    }
}

