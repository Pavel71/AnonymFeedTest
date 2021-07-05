//
//  DetailsUserView.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 05.07.2021.
//

import UIKit


class DetailsUserView: UIView {
    
    
    // MARK: - UI Elemetns
    
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
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        addSubview(userImageView)
        addSubview(userNameLabel)
    }
    
    private func setUpConstraints() {
        userImageView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 300, height: 300))
        userImageView.centerXInSuperview()
        
        userNameLabel.anchor(top: userImageView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
    }
    
}

// MARK: - Configure
extension DetailsUserView {
    
    func configure(userImageUrl: String,userName: String) {
        userImageView.downloadImageFrom(withUrl: userImageUrl)
        userNameLabel.text = userName
    }
}
