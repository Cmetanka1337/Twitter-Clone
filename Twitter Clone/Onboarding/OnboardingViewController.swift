//
//  OnboardingViewController.swift
//  Twitter Clone
//
//  Created by Всеволод Буртик on 14.01.2025.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 32, weight: .heavy)
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "See what`s happening in the world right now."
        
        return label
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create an account", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        button.tintColor = .white
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        
        
        return button
    }()
    
    private let promptLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.tintColor = .gray
        label.text = "Already have an account?"
        
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        
        return button
    }()
    
    private let loginButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        applyConstraints()
        
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)

    }
    
    @objc private func didTapCreateAccountButton() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapLoginButton() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func applyConstraints() {
        view.addSubview(welcomeLabel)
        view.addSubview(createAccountButton)
        loginButtonStackView.addArrangedSubview(promptLabel)
        loginButtonStackView.addArrangedSubview(loginButton)
        view.addSubview(loginButtonStackView)
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            createAccountButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createAccountButton.widthAnchor.constraint(equalTo: welcomeLabel.widthAnchor, constant: -20),
            createAccountButton.heightAnchor.constraint(equalToConstant: 60),
            
            loginButtonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButtonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            loginButtonStackView.widthAnchor.constraint(equalToConstant: view.frame.width - 180),
            loginButtonStackView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
