//
//  HomeViewController.swift
//  Twitter Clone
//
//  Created by Всеволод Буртик on 10.01.2025.
//

import UIKit
import FirebaseAuth
import Combine

class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewViewModel()
    private var subscriptions: Set<AnyCancellable> = []

    let tableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self , forCellReuseIdentifier: TweetTableViewCell.identifier)
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        view.tintColor = .systemBackground
        view.backgroundColor = .systemBackground

        view.addSubview(tableView)
        configureNavBar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(didTapSignOut))
        bindView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        handleAuthentication()
        viewModel.retrieveUser()
    }
    
    func completeUserOnboarding() {
        let vc = ProfileDataFormViewController()
        present(vc, animated: true)
    }
    
    func bindView() {
        viewModel.$user.sink { [weak self] user in
            guard let user else { return }
            if !user.isUserOnboarded {
                self?.completeUserOnboarding()
            }
        }.store(in: &subscriptions)
    }
    
    private func handleAuthentication() {
        if Auth.auth().currentUser == nil {
            let vc = UINavigationController(rootViewController: OnboardingViewController())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }
    
    private func configureNavBar() {
        let size: CGFloat = 36
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.image = UIImage(named: "logo")?.withTintColor(.label)
        
        let middleView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        middleView.addSubview(logoImageView)
        
        navigationItem.titleView = middleView
        
        let profileImage = UIImage(systemName: "person")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: profileImage, style: .plain, target: self, action: #selector(didTapProfile))
    }
    
    @objc private func didTapProfile() {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc private func didTapSignOut() {
        try? Auth.auth().signOut()
        handleAuthentication()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else {
             return UITableViewCell()
        }
        cell.delegate = self

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
}

extension HomeViewController: TweetTableViewCellDelegate {
    
    func tweetTableViewCellDidTapReply() {
        print("reply")
    }
    
    func tweetTableViewCellDidTapRetweet() {
        print("retweet")
    }
    
    func tweetTableViewCellDidTapLike() {
        print("like")
    }
    
    func tweetTableViewCellDidTapViews() {
        print("view")
    }
    
    func tweetTableViewCellDidTapSave() {
        print("save")
    }
    
    func tweetTableViewCellDidTapShare() {
        print("share")
    }
}
