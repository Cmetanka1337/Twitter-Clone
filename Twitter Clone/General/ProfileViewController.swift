//
//  ProfileViewController.swift
//  Twitter Clone
//
//  Created by Всеволод Буртик on 12.01.2025.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var isStatusBarHidden: Bool = true
    
    private let statusBar: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.opacity = 0
        
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationItem.title = "Profile"
        navigationController?.navigationBar.isHidden = true
        
        configure()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        applyConstraints()
    }
    
    private func configure() {
        view.addSubview(tableView)
        view.addSubview(statusBar)
        tableView.frame = view.bounds
        tableView.tableHeaderView = ProfileTableHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 380))
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            statusBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBar.topAnchor.constraint(equalTo: view.topAnchor),
            statusBar.heightAnchor.constraint(equalToConstant: view.bounds.height > 800 ? 40 : 20)
        ])
    }
    
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPosition = scrollView.contentOffset.y
        
        if yPosition >= (tableView.tableHeaderView?.bounds.height)! / 2.5 && isStatusBarHidden {
            isStatusBarHidden = false
            navigationController?.isNavigationBarHidden = false
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                self?.statusBar.layer.opacity = 1
                self?.navigationController?.navigationBar.layer.opacity = 1
            } completion: { _ in }

        } else if yPosition <= 0 && !isStatusBarHidden {
            isStatusBarHidden = true
            navigationController?.isNavigationBarHidden = true
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) { [weak self] in
                self?.statusBar.layer.opacity = 0
                self?.navigationController?.navigationBar.layer.opacity = 0
            } completion: { _ in }
        }
    }
    
}
