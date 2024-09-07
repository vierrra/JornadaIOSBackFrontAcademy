//
//  RegisterViewModel.swift
//  PrimeiroAppMVVM
//
//  Created by Renato Vieira on 18/08/24.
//

import Foundation
import FirebaseAuth

protocol RegisterViewModellProtocol: AnyObject {
    func successRegister()
    func errorRegister(_ errorMessage: String)
}

class RegisterViewModel {
    
    private var auth = Auth.auth()
    private weak var delegate: RegisterViewModellProtocol?
    
    public func delegate(_ delegate: RegisterViewModellProtocol) {
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

    public func validationsFiledsTextFields(_ email: String, _ password: String, confirmPassword: String) -> Bool {
        if isValidEmail(email) && isValidPassword(password) && isValidPassword(confirmPassword) {
            return true
        } else {
            return false
        }
    }
    
    public func registerUser(_ email: String, _ password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if error == nil {
                print("Sucesso no cadastro")
                self?.delegate?.successRegister()
            } else {
                print("Erro no cadastro, error: \(String(describing: error?.localizedDescription))")
                self?.delegate?.errorRegister((String(describing: error?.localizedDescription)))
            }
        }
    }
}
