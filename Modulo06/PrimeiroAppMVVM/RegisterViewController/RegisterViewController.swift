//
//  RegisterViewController.swift
//  PrimeiroAppMVVM
//
//  Created by Renato Vieira on 18/08/24.
//

import UIKit

class RegisterViewController: BaseViewController {
    
    private var screen: RegisterScreen?
    private var viewModel: RegisterViewModel? = RegisterViewModel()
    
    override func loadView() {
        screen = RegisterScreen()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        screen?.configProtocols(self, self)
        viewModel?.delegate(self)
        self.isEnabledLoginButton(isEnable: true)
    }
    
    private func isEnabledLoginButton(isEnable: Bool) {
        screen?.registerButton.isEnabled = isEnable
        screen?.registerButton.backgroundColor = isEnable ? .systemBlue : .lightGray
    }
    
    private func clearTextFields() {
        screen?.emailTextField.text = ""
        screen?.passwordTextField.text = ""
        screen?.confirmPasswordTextField.text = ""
    }
}

extension RegisterViewController: RegisterScreenProtocol {
    func tappedRegisterButton() {
        print("Registro com sucesso")
        guard let screen = screen, let viewModel = viewModel else { return }
        
        viewModel.registerUser(screen.emailTextField.text ?? "", screen.passwordTextField.text ?? "")
    }
    
    func tappedBackButton() {
        dismiss(animated: true)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as? NSString {
          let newText = text.replacingCharacters(in: range, with: string)
          textField.text = newText
            if let viewModel = viewModel, let screen = screen {
                if viewModel.validationsFiledsTextFields(screen.emailTextField.text ?? "", screen.passwordTextField.text ?? "", confirmPassword: screen.confirmPasswordTextField.text ?? "") {
                    isEnabledLoginButton(isEnable: true)
              } else {
                    isEnabledLoginButton(isEnable: false)
              }
            }
        }
        return false
    }
    
}

extension RegisterViewController: RegisterViewModellProtocol {
    func sucessRegister() {
        showAlertWithCompletion("Parabéns", "Casdastro efetudo com sucesso", titleButton: "OK") {
            self.dismiss(animated: true)
        }
    }
    
    func errorRegister(_ errorMessage: String) {
        confirmAlert(title: "Warning", message: errorMessage, titleButton: "Tente novamente")
        self.clearTextFields()
    }
}


