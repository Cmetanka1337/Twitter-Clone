//
//  ProfileTableHeaderView.swift
//  Twitter Clone
//
//  Created by Всеволод Буртик on 12.01.2025.
//

import UIKit

class ProfileTableHeaderView: UIView {
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "header")
        
        return imageView
    }()
    
    private let profileAvatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .label
        imageView.image = UIImage(systemName: "person")
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.systemBackground.cgColor
        imageView.backgroundColor = .systemBackground
        
        return imageView
    }()
    
    private let displayNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        
        label.text = "Test Account"
        
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        
        label.text = "@TestAccountUsername"
        
        return label
    }()
    
    private let userBioLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        
        label.text = "Bio text. Bio text. Bio text. Bio text"
        
        return label
    }()
    
    private let joinDateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFill
        
        imageView.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
        
        return imageView
    }()
    
    private let joinDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        
        label.text = "Joined May 2225"
        
        return label
    }()
    
    private let locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .secondaryLabel
        imageView.image = UIImage(systemName: "mappin")
        
        return imageView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        
        label.text = "Uruguay"
        
        return label
    }()
    
    private let followingCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .label
        label.text = "123"
        
        return label
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Following", for: .normal)
        button.tintColor = .secondaryLabel
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        
        return button
    }()
    
    private let followersCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .label
        label.text = "234"
        
        return label
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Followers", for: .normal)
        button.tintColor = .secondaryLabel
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.tintColor = .label
        
        return button
    }()
    
    private var tabs: [UIButton] = ["Posts", "Replies", "Highlights", "Articles", "Media", "Likes"].map { buttonTitle in
        let button = UIButton()
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        
        return button
    }
    
    private lazy var sectionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: tabs)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let indicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        
        return view
    }()
    
    private var leadingAnchors: [NSLayoutConstraint] = []
    private var trailingAnchors: [NSLayoutConstraint] = []
    
    private enum SectionsTabs: String {
        case posts = "Posts"
        case replies = "Replies"
        case highlights = "Highlights"
        case articles = "Articles"
        case media = "Media"
        case likes = "Likes"
        
        var index: Int {
            switch self {
            case .posts:
                return 0
            case .replies:
                return 1
            case .highlights:
                return 2
            case .articles:
                return 3
            case .media:
                return 4
            case .likes:
                return 5
            }
        }
    }
    
    private var selectedTab: Int = 0 {
        didSet{
            for i in 0..<tabs.count {
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [weak self] in
                    let color: UIColor = i == self?.selectedTab ? .label : .secondaryLabel
                    guard let button = self?.sectionStackView.arrangedSubviews[i] as? UIButton else { return }
                    button.setTitleColor(color, for: .normal)
                    
                    self?.leadingAnchors[i].isActive = i == self?.selectedTab ? true : false
                    self?.trailingAnchors[i].isActive = i == self?.selectedTab ? true : false
                    self?.layoutIfNeeded()
                }
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        applyConstraints()
        configureSectionButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSectionButton() {
        for (i, button) in sectionStackView.arrangedSubviews.enumerated() {
            guard let button = button as? UIButton else { return }
            button.addTarget(self, action: #selector(didTapTab(_:)), for: .touchUpInside)
            
            if i == selectedTab {
                button.setTitleColor(.label, for: .normal)
            } else {
                button.setTitleColor(.secondaryLabel, for: .normal)
            }
        }
    }
    
    @objc private func didTapTab(_ sender: UIButton) {
        guard let label = sender.titleLabel?.text else { return}
        
        switch label {
        case SectionsTabs.posts.rawValue:
            selectedTab = SectionsTabs.posts.index
        case SectionsTabs.replies.rawValue:
            selectedTab = SectionsTabs.replies.index
        case SectionsTabs.highlights.rawValue:
            selectedTab = SectionsTabs.highlights.index
        case SectionsTabs.articles.rawValue:
            selectedTab = SectionsTabs.articles.index
        case SectionsTabs.media.rawValue:
            selectedTab = SectionsTabs.media.index
        case SectionsTabs.likes.rawValue:
            selectedTab = SectionsTabs.likes.index
        default:
            selectedTab = 0
        }
    }
    
    private func applyConstraints() {
        addSubview(backgroundImageView)
        addSubview(profileAvatarImageView)
        addSubview(displayNameLabel)
        addSubview(usernameLabel)
        addSubview(userBioLabel)
        addSubview(joinDateImageView)
        addSubview(joinDateLabel)
        addSubview(locationImageView)
        addSubview(locationLabel)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(followingCountLabel)
        addSubview(followersCountLabel)
        addSubview(sectionStackView)
        addSubview(indicator)
        
        for i in 0..<tabs.count {
            let leadingAnchor = indicator.leadingAnchor.constraint(equalTo: sectionStackView.arrangedSubviews[i].leadingAnchor)
            leadingAnchors.append(leadingAnchor)
            let trailingAnchor = indicator.trailingAnchor.constraint(equalTo: sectionStackView.arrangedSubviews[i].trailingAnchor)
            trailingAnchors.append(trailingAnchor)
        }
        
        NSLayoutConstraint.activate([
            backgroundImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundImageView.widthAnchor.constraint(equalToConstant: bounds.width),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: bounds.height / 2.5),
            
            profileAvatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            profileAvatarImageView.centerYAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: 10),
            profileAvatarImageView.widthAnchor.constraint(equalToConstant: 80),
            profileAvatarImageView.heightAnchor.constraint(equalTo: profileAvatarImageView.widthAnchor),
            
            displayNameLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
            displayNameLabel.topAnchor.constraint(equalTo: profileAvatarImageView.bottomAnchor, constant: 5),
            displayNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -120),
            
            usernameLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
            usernameLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 2),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -120),
            
            userBioLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
            userBioLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            userBioLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
            
            locationImageView.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
            locationImageView.topAnchor.constraint(equalTo: userBioLabel.bottomAnchor, constant: 8),
            
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 2),
            locationLabel.topAnchor.constraint(equalTo: userBioLabel.bottomAnchor, constant: 8),
            locationLabel.trailingAnchor.constraint(equalTo: joinDateImageView.leadingAnchor, constant: -10),
            
            joinDateImageView.leadingAnchor.constraint(equalTo: locationLabel.trailingAnchor, constant: 10),
            joinDateImageView.topAnchor.constraint(equalTo: userBioLabel.bottomAnchor, constant: 8),
            
            joinDateLabel.leadingAnchor.constraint(equalTo: joinDateImageView.trailingAnchor, constant: 2),
            joinDateLabel.topAnchor.constraint(equalTo: userBioLabel.bottomAnchor, constant: 8),
            joinDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
            
            followingCountLabel.leadingAnchor.constraint(equalTo: profileAvatarImageView.leadingAnchor),
            followingCountLabel.topAnchor.constraint(equalTo: locationImageView.bottomAnchor, constant: 8),
            followingCountLabel.trailingAnchor.constraint(equalTo: followingButton.leadingAnchor, constant: -1),
            
            followingButton.leadingAnchor.constraint(equalTo: followingCountLabel.trailingAnchor, constant: 1),
            followingButton.centerYAnchor.constraint(equalTo: followingCountLabel.centerYAnchor),
            followingButton.trailingAnchor.constraint(equalTo: followersCountLabel.leadingAnchor, constant: -10),
            
            followersCountLabel.leadingAnchor.constraint(equalTo: followingButton.trailingAnchor, constant: 10),
            followersCountLabel.centerYAnchor.constraint(equalTo: followingCountLabel.centerYAnchor),
            
            followersButton.leadingAnchor.constraint(equalTo: followersCountLabel.trailingAnchor, constant: 1),
            followersButton.centerYAnchor.constraint(equalTo: followingCountLabel.centerYAnchor),
            
            sectionStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            sectionStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            sectionStackView.topAnchor.constraint(equalTo: followersButton.bottomAnchor, constant: 5),
//            sectionStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            
            indicator.topAnchor.constraint(equalTo: sectionStackView.bottomAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 3),
            leadingAnchors[0],
            trailingAnchors[0]
        ])
    }
}
