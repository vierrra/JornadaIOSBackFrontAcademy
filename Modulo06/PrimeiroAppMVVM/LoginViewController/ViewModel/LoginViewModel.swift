//
//  LoginViewModel.swift
//  PrimeiroAppMVVM
//
//  Created by Renato Vieira on 18/08/24.
//

import UIKit
import FirebaseAuth

protocol LoginViewModelProtocol: AnyObject {
    func sucessLogin()
    func errorLogin(_ errorMessage: String)
    func sucessRegister()
    func errorRegister(_ errorMessage: String)
}

class LoginViewModel {
    
    private weak var delegate: LoginViewModelProtocol?
    private var auth = Auth.auth()
    
    public func delegate(_ delegate: LoginViewModelProtocol) {
        self.delegate = delegate
    }

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
    
    public func login(_ email: String, _ password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if error == nil {
                print("Sucesso no login")
                self?.delegate?.sucessLogin()
            } else {
                print("Erro no login, error: \(String(describing: error?.localizedDescription))")
                self?.delegate?.errorLogin((String(describing: error?.localizedDescription)))
            }
        }
    }
    
    public func registerUser(_ email: String, _ password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if error == nil {
                print("Sucesso no cadastro")
                self?.delegate?.sucessRegister()
            } else {
                print("Erro no cadastro, error: \(String(describing: error?.localizedDescription))")
                self?.delegate?.errorRegister((String(describing: error?.localizedDescription)))
            }
        }
    }
    
    public func validationsFiledsTextFields(_ email: String, _ password: String) -> Bool {
        if isValidEmail(email) && isValidPassword(password) {
            return true
        } else {
            return false
        }
    }
}
