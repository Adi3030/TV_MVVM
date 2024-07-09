//
//  RegisterViewModel.swift
//  MyDemoMVVM
//
//  Created by aditya sharma on 31/05/24.
//

import Foundation

class RegisterViewModel {
    var name: String = "" {
        didSet {
            validateCredentials()
        }
    }
    
    var country: String  = "" {
        didSet {
            validateCredentials()
        }
    }
    var mobile: String = "" {
        didSet {
            validateCredentials()
        }
    }
    var password: String = "" {
        didSet {
            validateCredentials()
        }
    }
    
    
    var isRegisterButtonEnabled: ((Bool) -> Void)?
    var didRegisterSucceed: (() -> Void)?
    var didRegisterFail: ((String) -> Void)?
    
    
    private func validateCredentials() {
            let isValid = !name.isEmpty && !country.isEmpty && !mobile.isEmpty && !password.isEmpty
            isRegisterButtonEnabled?(isValid)
        }
    
    func register() {
            
            if !name.isEmpty && !country.isEmpty && !mobile.isEmpty && !password.isEmpty {
                didRegisterSucceed?()
            } else {
                didRegisterFail?("All fields are required")
            }
        }
}
