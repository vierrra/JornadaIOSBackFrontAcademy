//
//  RegisterScreen.swift
//  PrimeiroAppMVVM
//
//  Created by Renato Vieira on 18/08/24.
//

import UIKit

protocol RegisterScreenProtocol: AnyObject {
    func tappedRegisterButton()
    func tappedBackButton()
}

class RegisterScreen: UIView {
    
    private weak var delegate: RegisterScreenProtocol?
    
    lazy var createRegisterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.text = "Crie sua conta!"
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Digite seu email:"
        textField.layer.cornerRadius = 8
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Digite sua senha:"
        textField.layer.cornerRadius = 8
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .emailAddress
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirme sua senha:"
        textField.layer.cornerRadius = 8
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .emailAddress
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cadastrar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedRegisterButton() {
        delegate?.tappedRegisterButton()
    }
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Voltar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedBackButton() {
        self.delegate?.tappedBackButton()
    }

    init() {
        super.init(frame: .zero)
        backgroundColor =  .white
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configProtocols(_ delegate: RegisterScreenProtocol, _ delegateTextFields: UITextFieldDelegate) {
        self.delegate = delegate
        self.emailTextField.delegate = delegateTextFields
        self.passwordTextField.delegate = delegateTextFields
        self.confirmPasswordTextField.delegate = delegateTextFields
    }
    
    private func setup() {
        self.buildViewHierarchy()
        self.configContraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(createRegisterLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(confirmPasswordTextField)
        addSubview(registerButton)
        addSubview(backButton)
    }
    
    private func configContraints() {
        createRegisterLabel.anchor(top: safeAreaLayoutGuide.topAnchor, padding: UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0))
        createRegisterLabel.xAnchor(xAnchor: centerXAnchor)
        
        emailTextField.anchor(top: createRegisterLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 80, left: 20, bottom: 0, right: 20))
        emailTextField.size(size: CGSize(width: 0, height: 40))
        
        passwordTextField.anchor(top: emailTextField.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20))
        passwordTextField.size(size: CGSize(width: 0, height: 40))
        
        confirmPasswordTextField.anchor(top: passwordTextField.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20))
        confirmPasswordTextField.size(size: CGSize(width: 0, height: 40))
        
        registerButton.anchor(top: confirmPasswordTextField.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 60, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 40))
        
        backButton.anchor(top: registerButton.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 40))
       
    }
}
