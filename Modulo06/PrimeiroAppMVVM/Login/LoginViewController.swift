//
//  LoginViewController.swift
//  PrimeiroAppMVVM
//
//  Created by Renato Vieira on 18/08/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    var screen: LoginScreen?
    
    override func loadView() {
        screen = LoginScreen()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configProtocols()
    }
    
    private func configProtocols() {
        screen?.configDelegateProtocolTextFileds(self)
        screen?.delegate = self
    }
}

extension LoginViewController: UITextFieldDelegate {
    
}

extension LoginViewController: LoginScreenProtocol {
    func tappedRegisterButton() {
        print("Chegou Register")
    }
    
    func tappedLoginButton() {
        print("Chegou Login")
    }
    
    
}
