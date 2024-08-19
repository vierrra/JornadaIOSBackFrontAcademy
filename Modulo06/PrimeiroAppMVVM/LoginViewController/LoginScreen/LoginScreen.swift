//
//  LoginScreen.swift
//  PrimeiroAppMVVM
//
//  Created by Renato Vieira on 18/08/24.
//

import UIKit

protocol LoginScreenProtocol: AnyObject {
    func tappedRegisterButton()
    func tappedLoginButton()
}

class LoginScreen: UIView {
    
    weak var delegate: LoginScreenProtocol?
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.text = "Seja bem vindo!"
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
        //textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Não tem conta? Cadastra-se", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedRegisterButton() {
        self.delegate?.tappedRegisterButton()
    }
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tappedLoginButton() {
        self.delegate?.tappedLoginButton()
    }
    
    init() {
        super.init(frame: .zero)
        backgroundColor =  .white
        
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configDelegateProtocolTextFileds(_ delegate: UITextFieldDelegate) {
        emailTextField.delegate = delegate
        passwordTextField.delegate = delegate
    }
    
    private func setup() {
        self.buildViewHierarchy()
        self.configContraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(welcomeLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(registerButton)
        addSubview(loginButton)
    }
    
    private func configContraints() {
        welcomeLabel.anchor(top: safeAreaLayoutGuide.topAnchor, padding: UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0))
        welcomeLabel.xAnchor(xAnchor: centerXAnchor)
        
        emailTextField.anchor(top: welcomeLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 80, left: 20, bottom: 0, right: 20))
        emailTextField.size(size: CGSize(width: 0, height: 40))
        
        passwordTextField.anchor(top: emailTextField.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20))
        passwordTextField.size(size: CGSize(width: 0, height: 40))
        
        registerButton.anchor(top: passwordTextField.bottomAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 40))
        registerButton.xAnchor(xAnchor: centerXAnchor)
        
        loginButton.anchor(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 150, right: 20), size: CGSize(width: 0, height: 40))
    }
}
