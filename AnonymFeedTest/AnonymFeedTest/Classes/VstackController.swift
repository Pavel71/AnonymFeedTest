//
//  VstackController.swift
//  AnonymFeedTest
//
//  Created by Павел Мишагин on 05.07.2021.
//

import UIKit

public class VstackController: UIViewController {
    
    // MARK: - UI elements
    
    private(set) lazy var contentView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        return scrollView
    }()
    
    private(set) lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        return stackView
    }()
    
    var views: [UIView] {
        return stackView.arrangedSubviews
    }
    
    // MARK: - Lyfe Cycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup
    
    func setupViews() {
        
        view.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    func setupConstraints() {
        
        contentView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)

        stackView.fillSuperview()
        stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        

    }
    
}
// MARK: - Stack methods
extension VstackController {
    

    func addView(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }
    
    func addSpacer(_ spacer: CGFloat) {
        stackView.addSpacing(spacing: spacer)
    }

    func addViews(_ views: [UIView]) {
        views.forEach { addView($0) }
    }

    func removeView(_ view: UIView) {
        stackView.removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    func removeAll() {
        stackView.subviews.forEach {
            stackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
}
