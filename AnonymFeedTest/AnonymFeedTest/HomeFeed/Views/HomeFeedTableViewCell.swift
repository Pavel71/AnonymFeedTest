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
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    private lazy var topStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    private lazy var contentStackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 5
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
        $0.layer.cornerRadius = 10
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
    
    private func makeContentLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.lineBreakMode = .byClipping
        label.text = text
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }
    
    
    // MARK: - Content UI

    private lazy var contentImageView: ImageLoadedView = {
//        $0.image = UIImage(systemName: "globe")
        $0.constrainHeight(constant: 234)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.tintColor = .black
        $0.isHidden = true
        return $0
    }(ImageLoadedView())
    
    private lazy var contentlabel: UILabel = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = UIColor.black
        $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        $0.lineBreakMode = .byClipping
        $0.numberOfLines = 0
        $0.textAlignment = .left
        return $0
    }(UILabel())
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
   
        viewsLabel.text = nil
        likesLabel.text = nil
        commentsLabel.text = nil
        replayLabel.text = nil
        sharesLabel.text = nil

        userNameLabel.text = nil
        userImageView.image = UIImage(systemName: "person.circle.fill")
        
        // clear content
        contentImageView.image = nil
        contentImageView.isHidden = true
        contentlabel.text = nil
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
        
        configureContentStack()
    }
    
    private func configureContentStack() {
        contentStackView.addArrangedSubview(contentImageView)
        contentStackView.addArrangedSubview(contentlabel)
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
        // USer
        userNameLabel.text = model.userName
        userImageView.downloadImageFrom(withUrl: model.userImageUrl ?? "")
        
        // content
        model.contents.forEach {
            // Need to place content in vertical stack view
            switch $0.type {
            case .audio:
                print("make UI Audio")
            case .image:
                contentImageView.downloadImageFrom(withUrl: $0.data?.small?.url ?? "")
                contentImageView.isHidden = false
            case .imageGIF:
                print("make UI Gif")
            case .tags:
                print("Make Ui Tag")
            case .text:
                print("make UI Text",$0.data?.value)
                let Oldtext = contentlabel.text ?? ""
                let newText = $0.data?.value ?? ""
                contentlabel.text = Oldtext + "\n" + newText
            case .video:
            print("make Ui Video")
            case .none:
                break
            }
            
        }
        
        // Stats
        viewsLabel.text = String(describing: model.stats?.views?.count ?? 0)
        likesLabel.text = String(describing: model.stats?.likes?.count ?? 0)
        commentsLabel.text = String(describing: model.stats?.comments?.count ?? 0)
        replayLabel.text = String(describing: model.stats?.replies?.count ?? 0)
        sharesLabel.text = String(describing: model.stats?.shares?.count ?? 0)

    }
}
