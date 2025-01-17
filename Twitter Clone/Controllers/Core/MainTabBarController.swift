//
//  ViewController.swift
//  Twitter Clone
//
//  Created by Всеволод Буртик on 10.01.2025.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: NotificationsViewController())
        let vc4 = UINavigationController(rootViewController: DirectMessagesViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc1.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        vc1.title = "Home"
        vc1.navigationBar.tintColor = .label
        
        
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        vc2.title = "Search"
        vc2.navigationBar.tintColor = .label
        
        vc3.tabBarItem.image = UIImage(systemName: "bell")
        vc3.tabBarItem.selectedImage = UIImage(systemName: "bell.fill")
        vc3.title = "Notifications"
        vc3.navigationBar.tintColor = .label
        
        vc4.tabBarItem.image = UIImage(systemName: "envelope")
        vc4.tabBarItem.selectedImage = UIImage(systemName: "envelope.fill")
        vc4.title = "Messages"
        vc4.navigationBar.tintColor = .label
        
        tabBar.tintColor = .label
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }


}

