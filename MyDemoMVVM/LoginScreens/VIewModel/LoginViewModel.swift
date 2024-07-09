//
//  LoginViewModel.swift
//  MyDemoMVVM
//
//  Created by aditya sharma on 31/05/24.
//

import Foundation

class LoginViewModel {
    var username : String = "" {
        didSet {
            validateCredentials()
        }
    }
    var password: String = "" {
        didSet {
            validateCredentials()
        }
    }
    
    var isLoginButtonEnabled: ((Bool) -> Void)?
    var didLoginSucceed:((User) -> Void)?
    var didLoginFail: ((String) -> Void)?
    
    private func validateCredentials() {
        let isValid = !username.isEmpty && !password.isEmpty
        isLoginButtonEnabled?(isValid)
    }
    
    func login() {
            APIService.shared.login(username: username, password: password) { [weak self] result in
                switch result {
                case .success(let user):
                    self?.didLoginSucceed?(user)
                case .failure(let error):
                    self?.didLoginFail?(error.localizedDescription)
                }
            }
        }
}
