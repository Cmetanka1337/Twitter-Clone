//
//  TweetTableViewCell.swift
//  Twitter Clone
//
//  Created by Всеволод Буртик on 10.01.2025.
//

import UIKit

protocol TweetTableViewCellDelegate: AnyObject {
    func tweetTableViewCellDidTapReply()
    func tweetTableViewCellDidTapRetweet()
    func tweetTableViewCellDidTapLike()
    func tweetTableViewCellDidTapViews()
    func tweetTableViewCellDidTapSave()
    func tweetTableViewCellDidTapShare()
}

class TweetTableViewCell: UITableViewCell {
    
    static let identifier = "TweetTableViewCell"
    
    weak var delegate: TweetTableViewCellDelegate?
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .systemBlue
        
        return imageView
    }()
    
    private let displayNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        label.text = "Test Account"
        
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        label.text = "@TestAccountUsername"
        
        return label
    }()
    
    private let tweetTextContentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. A lot of text. "
        
        return label
    }()
    
    private let replyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "replyIcon")!.resized(to: CGSize(width: 20, height: 20)).withTintColor(.secondaryLabel)
        button.setImage(image, for: .normal)
        button.tintColor = .secondaryLabel
        button.setTitle("5,2K", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .light)
        
        return button
    }()
    
    private let retweetButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "retweetIcon")!.resized(to: CGSize(width: 20, height: 20)).withTintColor(.secondaryLabel)
        button.setImage(image, for: .normal)

        button.tintColor = .secondaryLabel
        button.setTitle("3,9K", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .light)
        
        return button
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "likeIcon")?.resized(to: CGSize(width: 20, height: 20)).withTintColor(.secondaryLabel)
        button.setImage(image, for: .normal)
        button.tintColor = .secondaryLabel
        button.setTitle("29K", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .light)
        
        return button
    }()
    
    private let viewsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "viewsIcon")?.resized(to: CGSize(width: 20, height: 20)).withTintColor(.secondaryLabel)
        button.setImage(image, for: .normal)
        button.tintColor = .secondaryLabel
        button.setTitle("1,8M", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .light)
        
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "favoriteIcon")?.resized(to: CGSize(width: 20, height: 20)).withTintColor(.secondaryLabel)
        button.setImage(image, for: .normal)
        button.imageView?.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "downloadIcon")?.resized(to: CGSize(width: 20, height: 20)).withTintColor(.secondaryLabel)
        button.setImage(image, for: .normal)
        button.tintColor = .secondaryLabel
        
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        applyConstraints()
        configureButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func applyConstraints() {
        let padding: CGFloat = 18
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(displayNameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(tweetTextContentLabel)
        contentView.addSubview(replyButton)
        contentView.addSubview(retweetButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(viewsButton)
        contentView.addSubview(saveButton)
        contentView.addSubview(shareButton)
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            
            displayNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 5),
            displayNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            displayNameLabel.trailingAnchor.constraint(equalTo: usernameLabel.leadingAnchor, constant: -5),
            
            usernameLabel.centerYAnchor.constraint(equalTo: displayNameLabel.centerYAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            tweetTextContentLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor) ,
            tweetTextContentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            tweetTextContentLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 5),
            
            replyButton.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor, constant: -2),
            replyButton.topAnchor.constraint(equalTo: tweetTextContentLabel.bottomAnchor, constant: 5),
            replyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            shareButton.centerYAnchor.constraint(equalTo: saveButton.centerYAnchor),
            shareButton.trailingAnchor.constraint(equalTo: tweetTextContentLabel.trailingAnchor),
            
            saveButton.centerYAnchor.constraint(equalTo: viewsButton.centerYAnchor),
            saveButton.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -10),
            
            retweetButton.centerYAnchor.constraint(equalTo: replyButton.centerYAnchor),
            retweetButton.leadingAnchor.constraint(equalTo: replyButton.trailingAnchor, constant: padding),
            
            viewsButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            viewsButton.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -padding),
            
            likeButton.centerYAnchor.constraint(equalTo: retweetButton.centerYAnchor),
            likeButton.leadingAnchor.constraint(equalTo: retweetButton.trailingAnchor, constant: padding),
            likeButton.trailingAnchor.constraint(equalTo: viewsButton.leadingAnchor, constant: -padding)
        ])
    }
    
    private func configureButtons() {
        replyButton.addTarget(self, action: #selector(didTapReply), for: .touchUpInside)
        retweetButton.addTarget(self, action: #selector(didTapRetweet), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        viewsButton.addTarget(self, action: #selector(didTapViews), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShare), for: .touchUpInside)
    }
    
    private static func configureImageForButton(_ image: UIImage) -> UIImage{
        return image.withTintColor(.secondaryLabel)
    }
    
    @objc func didTapReply() {
        delegate?.tweetTableViewCellDidTapReply()
    }
    
    @objc func didTapRetweet() {
        delegate?.tweetTableViewCellDidTapRetweet()
    }
    
    @objc func didTapLike() {
        delegate?.tweetTableViewCellDidTapLike()
    }
    
    @objc func didTapViews() {
        delegate?.tweetTableViewCellDidTapViews()
    }
    
    @objc func didTapSave() {
        delegate?.tweetTableViewCellDidTapSave()
    }
    
    @objc func didTapShare() {
        delegate?.tweetTableViewCellDidTapShare()
    }
}
