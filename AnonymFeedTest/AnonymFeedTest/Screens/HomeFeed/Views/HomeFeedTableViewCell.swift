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
    var dispatchGroup = DispatchGroup()
    private lazy var player: AVPlayer =  {
        
        return $0
    }(AVPlayer(playerItem: nil))
    private var audioUrl: String = ""
    private var videoUrl: String = ""
    private var previewVideoImageUrl = ""
    private var lastPlayerItem: AVPlayerItem?
    
    private lazy var mainStackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 10
        $0.isUserInteractionEnabled = true
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
        $0.isUserInteractionEnabled = true
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
        $0.isHidden = true
        return $0
    }(UILabel())
    
    private lazy var taglabel: UILabel = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = UIColor.systemBlue
        $0.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        $0.lineBreakMode = .byClipping
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.isHidden = true
        return $0
    }(UILabel())
    
    
    private lazy var audioButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        $0.setTitle("Auido Play", for: .normal)
        $0.tintColor = .white
        $0.isHidden = true
        $0.isUserInteractionEnabled = true
        return $0
    }(UIButton(type: .system))
    
    private lazy var videoButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        $0.setTitle("Video Play", for: .normal)
        $0.tintColor = .white
        $0.isHidden = true
        $0.isUserInteractionEnabled = true
        return $0
    }(UIButton(type: .system))
    
    private lazy var videoView: UIView = {
        $0.constrainHeight(constant: 250)
        
        $0.layer.addSublayer(postViewVideoLayer)
        $0.addSubview(previewVideoImage)
        previewVideoImage.fillSuperview()
        $0.addSubview(videoButton)
        videoButton.centerInSuperview()
        $0.isHidden = true
        $0.backgroundColor = .lightGray
        return $0
    }(UIView())
    
    private lazy var previewVideoImage: ImageLoadedView = {
        
        $0.constrainHeight(constant: 250)
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.tintColor = .black
        $0.isHidden = true
        return $0
    }(ImageLoadedView())
    
    
    private lazy  var postViewVideoLayer: AVPlayerLayer = {
        let layer = AVPlayerLayer(player: self.player)
        layer.videoGravity = .resizeAspectFill
        return layer
    }()
    
    private lazy var gifImageView: ImageLoadedView = {
        $0.constrainHeight(constant: 250)
        $0.isHidden = true
        return $0
    }(ImageLoadedView())
    

    
    
    
    // Need to make stats Stack View
    
    // MARK: - INit
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
        self.selectionStyle = .none
        audioButton.addTarget(self, action: #selector(handleAudioTapped), for: .touchUpInside)
        videoButton.addTarget(self, action: #selector(handleVideoButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Prepare for reuse
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
        contentlabel.isHidden = true
        
        audioButton.isHidden = true
        audioUrl = ""
        
        taglabel.text = nil
        
        videoView.isHidden = true
        videoUrl = ""
        previewVideoImageUrl = ""
        videoButton.isHidden = true
        previewVideoImage.isHidden = true
        
        NotificationCenter.default.removeObserver(self)
        
        gifImageView.isHidden = true
        gifImageView.image = nil
    }
    
    // MARK: - Set Up Views
    private func setUpViews() {
        contentView.addSubview(mainStackView)
        contentView.addSubview(audioButton)
        configureInitView()
    }
    
    private func setUpConstraints() {
        mainStackView.fillSuperview(padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
        userImageView.constrainHeight(constant: 60)
        userImageView.constrainWidth(constant: 60)
        
        audioButton.centerInSuperview()
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
        contentStackView.addArrangedSubview(gifImageView)
        contentStackView.addArrangedSubview(videoView)
        contentStackView.addArrangedSubview(contentImageView)
        contentStackView.addArrangedSubview(contentlabel)
        contentStackView.addArrangedSubview(taglabel)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        postViewVideoLayer.frame = videoView.bounds
    }
    
    
}

// MARK: - Actions
extension HomeFeedTableViewCell {
    @objc private func handleAudioTapped() {
        print("Auido Tapped")
        
        switch player.timeControlStatus {
        case .paused:
            print("need Activate and play")
            player.play()
            setPlayButtonStyleStop(button: audioButton)

        case .playing:
            print("need set pause")
            setPlayButtonStylePlay(button: audioButton)
            player.pause()
        case .waitingToPlayAtSpecifiedRate:
            print("HS")
        
        }
        
    }
    
    @objc private func handleVideoButton() {
        print("Vidoe Tapped")
        switch player.timeControlStatus {
        case .paused:
            print("need Activate and play")
            player.play()
            setPlayButtonStyleStop(button: videoButton)
        
            previewVideoImage.isHidden = true

        case .playing:
            print("need set pause")
            setPlayButtonStylePlay(button: videoButton)
            
            previewVideoImage.isHidden = false
            player.pause()
        case .waitingToPlayAtSpecifiedRate:
            print("HS")
       
        }
    }
    
    
    private func setPlayButtonStyleStop(button: UIButton) {
        button.setImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        button.alpha = 0.2
    }
    
    private func setPlayButtonStylePlay(button: UIButton) {
        button.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        button.alpha = 1
    }
        
}

//MARK: - Player
extension HomeFeedTableViewCell {
    func prepareDownload(url: URL) {
        
        
        lastPlayerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: lastPlayerItem)
        player.volume = 1.0
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: lastPlayerItem)
    }

    func stopPlayer() {
        player.replaceCurrentItem(with: nil)
    }
    

    @objc func playerDidFinishPlaying(sender: Notification) {

        player.seek(to: .zero)
        [audioButton,videoButton].forEach { $0.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)}
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
                audioUrl = $0.data?.url ?? ""
                audioButton.isHidden = false
                
                if let url = URL(string: $0.data?.url ?? "" ) {
                    prepareDownload(url: url)
                }
            case .image:
                contentImageView.downloadImageFrom(withUrl: $0.data?.small?.url ?? "")
                contentImageView.isHidden = false
            case .imageGIF:
                if let urlStr = $0.data?.original?.url {
                    gifImageView.isHidden = false
                    
                    gifImageView.downloadImageGifFrom(withUrl: urlStr) {[weak self] image in
                        self?.gifImageView.image = image
                    }
                    
                }
                
            case .tags:
                taglabel.isHidden  = false
                let tagString = $0.data?.values?.joined(separator: "#") ?? ""
                taglabel.text = "#\(tagString)"
            case .text:
                
                let oldtext = contentlabel.text ?? ""
                let newText = $0.data?.value ?? ""
                contentlabel.text = oldtext + "\n" + newText
                contentlabel.isHidden = false
            case .video:
                videoView.isHidden = false
                
                videoUrl = $0.data?.url ?? ""
                
                if let videoUrl = URL(string: $0.data?.url ?? "" ) {
                    prepareDownload(url: videoUrl)
                }
                
                videoButton.isHidden = false
                
                if let url =  $0.data?.previewImage?.data?.medium?.url {
                    previewVideoImageUrl = url
                    previewVideoImage.isHidden = false
                    previewVideoImage.downloadImageFrom(withUrl: url)
                }
                
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

