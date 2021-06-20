//
//  HomeFeedTableViewCell.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 19.06.2021.
//

import UIKit
import AVFoundation

protocol HomeFeedTableViewCellModelable {
    var userName: String? { get }
    var userImageUrl: String? { get }
    var contents: [Content] { get }
    
    var stats: Stats? { get }
    var isMyFavorit: Bool { get }
}


class HomeFeedTableViewCell: UITableViewCell {
    
    static let reusID = "HomeFeedTableViewCell"
    
    // avatr image
    // name
    // content
    // Content can has text
    // audio
    // vido
    // stats
    // like button
    
    private lazy var videoPlayer = AVPlayer(playerItem: nil)
    
    
    
    private lazy var mainStackView: UIStackView = {
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 5
        return $0
    }(UIStackView())
    
    private lazy var topStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 5
        return $0
    }(UIStackView())
    
    private lazy var contentStackView: UIStackView = {
        return $0
    }(UIStackView())
    
    private lazy var bottomStackView: UIStackView = {
        return $0
    }(UIStackView())
    
//    private lazy var topStackView: UIStackView = {
//        return $0
//    }(UIStackView())
    
    // For Top Stack View
    private lazy var userImageView: ImageLoadedView = {
        
        $0.image = UIImage(systemName: "person.circle.fill")
        $0.tintColor = .black
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 30
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(ImageLoadedView())
    
    private lazy var userNameLabel: UILabel = {
        
        $0.textColor = UIColor.secondaryLabel
        $0.text = "Some Name"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return $0
    }(UILabel())
    
    // For Bottom Stack View
    
    
    private lazy var likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var likesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        return imageView
    }()
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    private lazy var commentsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "comment")
        return imageView
    }()
    private lazy var commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    private lazy var sharesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "share")
        return imageView
    }()
    private lazy var sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    private lazy var viewsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "eye")
        return imageView
    }()
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    private lazy var postViewContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var postViewImageView: ImageLoadedView = {
        let view = ImageLoadedView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy  var postViewVideoView: AVPlayerLayer = {
        let layer = AVPlayerLayer(player: self.videoPlayer)
        layer.videoGravity = .resizeAspectFill
        return layer
    }()
    private lazy var postViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
        self.selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        addSubview(mainStackView)
        configureInitView()
    }
    
    private func setUpConstraints() {
        mainStackView.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
        userImageView.constrainHeight(constant: 60)
        userImageView.constrainWidth(constant: 60)
    }
    
    private func configureInitView() {
        mainStackView.addArrangedSubview(topStackView)
        mainStackView.addArrangedSubview(contentStackView)
        mainStackView.addArrangedSubview(bottomStackView)
        
        topStackView.addArrangedSubview(userImageView)
        topStackView.addArrangedSubview(userNameLabel)
    }
}

// MARK: - Configure
extension HomeFeedTableViewCell {
    
    
    func configure(model: HomeFeedTableViewCellModelable) {
        userNameLabel.text = model.userName
        userImageView.downloadImageFrom(withUrl: model.userImageUrl ?? "")
    }
}
