//
//  DetailsPostStatsView.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 05.07.2021.
//

import UIKit


class DetailsPostStatsView: UIView {
    
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
    
    private lazy var statStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalCentering
        $0.alignment = .fill
        return $0
    }(UIStackView())
    
   
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpStatHStack()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        addSubview(statStackView)
    }
    
    private func setUpStatHStack() {
        let viewshStack = UIStackView(arrangedSubviews: [viewsImage,viewsLabel])
        let likesStack = UIStackView(arrangedSubviews: [likesImage,likesLabel])
        let commentStack = UIStackView(arrangedSubviews: [commentsImage,commentsLabel])
        let shareStack = UIStackView(arrangedSubviews: [sharesImage,sharesLabel])
        let repliesStack = UIStackView(arrangedSubviews: [replayImage,replayLabel])
        
        [viewshStack,likesStack,commentStack,shareStack,repliesStack].forEach {
            $0.spacing = 5
            statStackView.addArrangedSubview($0)
        }
        
        
    }
    
    private func setUpConstraints() {
        statStackView.fillSuperview()
    }
    
    func clearLabels() {
        viewsLabel.text = nil
        likesLabel.text = nil
        commentsLabel.text = nil
        replayLabel.text = nil
        sharesLabel.text = nil
    }
}

// MARK: - Configure
extension DetailsPostStatsView {
    
    
    func configure(stats: Stats?) {
        viewsLabel.text = String(describing: stats?.views?.count ?? 0)
        likesLabel.text = String(describing: stats?.likes?.count ?? 0)
        commentsLabel.text = String(describing: stats?.comments?.count ?? 0)
        replayLabel.text = String(describing: stats?.replies?.count ?? 0)
        sharesLabel.text = String(describing: stats?.shares?.count ?? 0)
    }
}
