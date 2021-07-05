//
//  DetailsContentView.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 05.07.2021.
//

import UIKit
import AVFoundation

class DetailsContentView: UIView {
    
    
    private lazy var player: AVPlayer =  {
        return $0
    }(AVPlayer(playerItem: nil))
    
    
    // MARK: - UI Elements
    
    private lazy var contentImageView: ImageLoadedView = {
        $0.constrainHeight(constant: 400)
    
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
        $0.constrainHeight(constant: 400)
        
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
        
        $0.constrainHeight(constant: 400)
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
    
    private lazy var contentStackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.spacing = 5
        $0.isUserInteractionEnabled = true
        return $0
    }(UIStackView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
        setUpContentStack()
        setupConstraints()
        
        
        
        audioButton.addTarget(self, action: #selector(handleAudioTapped), for: .touchUpInside)
        videoButton.addTarget(self, action: #selector(handleVideoButton), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        postViewVideoLayer.frame = videoView.bounds
    }
    
    private func setUpViews() {
        addSubview(contentStackView)
        addSubview(audioButton)
    }
    
    private func setupConstraints() {
        contentStackView.fillSuperview()
        audioButton.centerYAnchor.constraint(equalTo: contentImageView.centerYAnchor).isActive = true
        audioButton.centerXAnchor.constraint(equalTo: contentImageView.centerXAnchor).isActive = true
    }
    
    private func setUpContentStack() {
        contentStackView.addArrangedSubview(gifImageView)
        contentStackView.addArrangedSubview(videoView)
        
        contentStackView.addArrangedSubview(contentImageView)
        contentStackView.addArrangedSubview(contentlabel)
        contentStackView.addArrangedSubview(taglabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure
extension DetailsContentView {
    
    
    func configure(contents:[Content]) {
        print("Contents",contents)
        
        contents.forEach {
            // Need to place content in vertical stack view
            switch $0.type {
            case .audio:
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
                
                if let videoUrl = URL(string: $0.data?.url ?? "" ) {
                    prepareDownload(url: videoUrl)
                    // need recalculate bounds and reset for vidoe layer
                    layoutIfNeeded()
                    layoutSubviews()
                }
                
                videoButton.isHidden = false
                
                if let url =  $0.data?.previewImage?.data?.medium?.url {
                    previewVideoImage.isHidden = false
                    previewVideoImage.downloadImageFrom(withUrl: url)
                }
                
            case .none:
                break
            }
            
        }
        
        
    }
}
//MARK: - Player
extension DetailsContentView {
    
    // Need to think about how we can pass player item to avoid new downloading again!
    // or it will be better if we cahs this in our layer
    
    func prepareDownload(url: URL) {

        let playerItem = AVPlayerItem(url: url)
        
        player.replaceCurrentItem(with: playerItem)
        player.volume = 1.0

        NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
    }

    func stopPlayer() {
        player.replaceCurrentItem(with: nil)
    }
    

    @objc func playerDidFinishPlaying(sender: Notification) {

        player.seek(to: .zero)
        [audioButton,videoButton].forEach { $0.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)}
    }
}
// MARK: - Actions
extension DetailsContentView {
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
