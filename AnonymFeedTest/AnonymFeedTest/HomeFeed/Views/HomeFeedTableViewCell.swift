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
        $0.axis = .vertical
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
        $0.axis = .horizontal
        $0.distribution = .equalCentering
        $0.alignment = .fill
        return $0
    }(UIStackView())
    

    
    // MARK: - USer UI
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
    
    // MARK: - Stats UI
    
    
    private lazy var likesImage: UIImageView = makeStatImageView(systemImagename: "hand.thumbsup")
    private lazy var likesLabel: UILabel = makeStatLabel()
    
    private lazy var replayImage: UIImageView = makeStatImageView(systemImagename: "repeat")
    private lazy var replayLabel: UILabel = makeStatLabel()
    
    private lazy var commentsImage: UIImageView = makeStatImageView(systemImagename: "bubble.right")
    private lazy var commentsLabel: UILabel = makeStatLabel()
    
    private lazy var sharesImage: UIImageView = makeStatImageView(systemImagename: "square.and.arrow.up")
    private lazy var sharesLabel: UILabel = makeStatLabel()
    
    private lazy var viewsImage: UIImageView = makeStatImageView(systemImagename: "eye")
    private lazy var viewsLabel: UILabel = makeStatLabel()
    
    private func makeStatImageView(systemImagename: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: systemImagename)
        imageView.tintColor = .black
        return imageView
    }
    
    private func makeStatLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.secondaryLabel
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }
    
    
    // MARK: - Content UI
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
    
    // Need to make stats Stack View
    
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
        configureStatHStack()
    }
    
    
    private func configureStatHStack() {
        let viewshStack = UIStackView(arrangedSubviews: [viewsImage,viewsLabel])
        let likesStack = UIStackView(arrangedSubviews: [likesImage,likesLabel])
        let commentStack = UIStackView(arrangedSubviews: [commentsImage,commentsLabel])
        let shareStack = UIStackView(arrangedSubviews: [sharesImage,sharesLabel])
        let repliesStack = UIStackView(arrangedSubviews: [replayImage,replayLabel])
        
        [viewshStack,likesStack,commentStack,shareStack,repliesStack].forEach {
            $0.spacing = 5
            bottomStackView.addArrangedSubview($0)
        }
        
        
    }
}

// MARK: - Configure
extension HomeFeedTableViewCell {
    
    
    func configure(model: HomeFeedTableViewCellModelable) {
        userNameLabel.text = model.userName
        userImageView.downloadImageFrom(withUrl: model.userImageUrl ?? "")
        
        viewsLabel.text = String(describing: model.stats?.views?.count ?? 0)
        likesLabel.text = String(describing: model.stats?.likes?.count ?? 0)
        commentsLabel.text = String(describing: model.stats?.comments?.count ?? 0)
        replayLabel.text = String(describing: model.stats?.replies?.count ?? 0)
        sharesLabel.text = String(describing: model.stats?.shares?.count ?? 0)

    }
}
