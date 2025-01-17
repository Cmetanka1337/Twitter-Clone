//
//  RegisterViewController.swift
//  Twitter Clone
//
//  Created by Всеволод Буртик on 14.01.2025.
//

import UIKit
import Combine

class RegisterViewController: UIViewController {
    
    private let viewModel = AuthenticationViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []

    private let registerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create your account"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.backgroundColor = .systemFill
        textField.layer.cornerRadius = 30
        textField.clipsToBounds = true
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.backgroundColor = .systemFill
        textField.layer.cornerRadius = 30
        textField.clipsToBounds = true
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private let textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create account", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.isEnabled = false
        
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        label.numberOfLines = 0
        label.isHidden = true
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        applyConstraints()
        
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss)))
        bindViews()
    }
    
    private func bindViews() {
        emailTextField.addTarget(self, action: #selector(didChangeEmailField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(didChangePasswordField), for: .editingChanged)
        viewModel.$isAuthenticationFormValid
            .sink { [weak self] validationState in
            self?.registerButton.isEnabled = validationState
        }
        .store(in: &subscriptions)
        
        viewModel.$user.sink { [weak self] user in
            DispatchQueue.main.async {
                guard user != nil else { return }
                guard let vc = self?.navigationController?.viewControllers.first as? OnboardingViewController else { return }
                vc.dismiss(animated: true)
            }
        }.store(in: &subscriptions)
        
        viewModel.$error.sink { [weak self] error in
            guard let error else { return }
            self?.errorLabel.text = error
            self?.errorLabel.isHidden = false
        }
        .store(in: &subscriptions)
    }
    
    private func applyConstraints() {
        view.addSubview(registerTitleLabel)
        textFieldsStackView.addArrangedSubview(emailTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        view.addSubview(textFieldsStackView)
        view.addSubview(registerButton)
        view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            registerTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            registerTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 20),
            textFieldsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldsStackView.topAnchor.constraint(equalTo: registerTitleLabel.bottomAnchor, constant: 25),
            textFieldsStackView.heightAnchor.constraint(equalToConstant: 130),
            
            registerButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 20),
            registerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            registerButton.widthAnchor.constraint(equalToConstant: 180),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20),
            errorLabel.widthAnchor.constraint(equalToConstant: view.bounds.width - 20)
        ])
    }
}

@objc extension RegisterViewController {
    
    private func didTapToDismiss() {
        view.endEditing(true)
    }
    
    private func didChangeEmailField() {
        viewModel.email = emailTextField.text
        viewModel.validateAuthenticationForm()
    }
    
    private func didChangePasswordField() {
        viewModel.password = passwordTextField.text
        viewModel.validateAuthenticationForm()
    }
    
    private func didTapRegisterButton() {
        view.endEditing(true)
        errorLabel.isHidden = true
        viewModel.createUser()
    }
}
