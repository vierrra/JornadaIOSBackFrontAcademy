//
//  LoginViewController.swift
//  PrimeiroAppMVVM
//
//  Created by Renato Vieira on 18/08/24.
//

import UIKit

class LoginViewController: BaseViewController {
    
    private var screen: LoginScreen?
    private var viewModel: LoginViewModel? = LoginViewModel()
    
    override func loadView() {
        screen = LoginScreen()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configProtocols()
        self.isEnabledLoginButton(isEnable: false)
    }
    
    private func configProtocols() {
        screen?.configDelegateProtocolTextFileds(self)
        screen?.delegate = self
        viewModel?.delegate(self)
    }
    
    private  func isEnabledLoginButton(isEnable: Bool) {
        screen?.loginButton.isEnabled = isEnable
        screen?.loginButton.backgroundColor = isEnable ? .systemBlue : .lightGray
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as? NSString {
          let newText = text.replacingCharacters(in: range, with: string)
          textField.text = newText
            if let viewModel = viewModel, let screen = screen {
                if viewModel.validationsFiledsTextFields(screen.emailTextField.text ?? "", screen.passwordTextField.text ?? "") {
                    isEnabledLoginButton(isEnable: true)
              } else {
                    isEnabledLoginButton(isEnable: false)
              }
            }
        }
        return false
    }
}

extension LoginViewController: LoginScreenProtocol {
    func tappedRegisterButton() {
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        print("Chegou Register")
    }
    
    func tappedLoginButton() {
        guard let screen = screen, let viewModel = viewModel else { return }
        
        viewModel.login(screen.emailTextField.text ?? "", screen.passwordTextField.text ?? "")
    }
}

extension LoginViewController: LoginViewModelProtocol {
    
    func sucessLogin() {
        let vc = HomeViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func errorLogin(_ errorMessage: String) {
        confirmAlert(title: "Warning", message: errorMessage, titleButton: "Ok")
    }
}
