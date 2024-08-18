//
//  LoginViewModel.swift
//  PrimeiroAppMVVM
//
//  Created by Renato Vieira on 18/08/24.
//

import UIKit

class LoginViewModel {
    
    private let getEmail: String = "Vierrra@hotmail.com"
    private let getPassword: String = "123456"

    public func isValidEmail(_ email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailPattern)
        return emailPred.evaluate(with: email)
    }
    
    public func isValidPassword(_ password: String) -> Bool {
        let passwordPattern = ".{6,}"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordPattern)
        return passwordPred.evaluate(with: password)
    }
    
    public func validateEqualsPassword(_ password: UITextField, _ confirmPasswordTextField: UITextField ) -> Bool {
        if password.text == confirmPasswordTextField.text {
            return true
        } else {
            return false
        }
    }
    
    public func getEmailAndPassword(_ email: String, _ password: String) -> Bool {
        if getEmail == email && getPassword == password {
            return true
        } else {
            return false
        }
    }
}
